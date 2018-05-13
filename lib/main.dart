import 'package:flutter/material.dart';
import './ui/productlist.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      theme: new ThemeData(primarySwatch: Colors.deepOrange,),
      home: new ProductList(),
    );
  }
}

