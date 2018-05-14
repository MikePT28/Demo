import 'package:flutter/material.dart';
import './ui/loginscreen.dart';
import './ui/productlist.dart';
import 'models/session.dart';
import 'dart:async';

void main() => runApp(new App());

class App extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _App();

}

class _App extends State<StatefulWidget> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHome();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Demo',
      theme: new ThemeData(primarySwatch: Colors.deepOrange,),
      home: home(),
    );
  }

  Widget home() {

    return _loading ? Scaffold() : Session.shared.isEmpty() ? LoginScreen() : ProductList();

  }

  _loadHome() async {
    var loaded = await Session.loadStoredSession();
    setState(() {
      _loading = false;
    });
  }
}

