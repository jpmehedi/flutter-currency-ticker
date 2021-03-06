import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton andriodDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      icon: Icon(Icons.arrow_drop_down),
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosDropdown() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.blue,
      itemExtent: 32.0,
      onSelectedItemChanged: (seletedIndex) {
        setState(() {
          selectedCurrency = currenciesList[seletedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  String bitcoinValue = '?';
  Map<String, String> coinValues = {};
  bool isAwiting = false;
  void getData() async {
    isAwiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isAwiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CriptoCard(
            criptoValue: 'BTC',
            bitcoinValue: isAwiting ? '?' : coinValues['BTC'],
            selectedCurrency: selectedCurrency,
          ),
          CriptoCard(
            criptoValue: 'ETH',
            bitcoinValue: isAwiting ? '?' : coinValues['ETH'],
            selectedCurrency: selectedCurrency,
          ),
          CriptoCard(
            criptoValue: 'LTC',
            bitcoinValue: isAwiting ? '?' : coinValues['LTC'],
            selectedCurrency: selectedCurrency,
          ),
        
          SizedBox(
            height: 80,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosDropdown() : andriodDropdown(),
          ),
        ],
      ),
    );
  }
}

class CriptoCard extends StatelessWidget {
  CriptoCard({this.criptoValue, this.bitcoinValue, this.selectedCurrency});

  final String bitcoinValue;
  final String selectedCurrency;
  final String criptoValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $criptoValue = $bitcoinValue $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
