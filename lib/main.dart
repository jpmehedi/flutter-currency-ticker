import 'package:flutter/material.dart';

void main() => runApp(CurrencyTiker());

class CurrencyTiker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:Text("data") ,
    );
  }
}

