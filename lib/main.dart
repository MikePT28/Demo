import 'package:flutter/material.dart';
import './ui/loginscreen.dart';
import 'models/session.dart';
import 'ui/appcontainer.dart';

void main() async {
  runApp(new App());
}

class App extends StatefulWidget {

  @override
  _App createState() => _App();

}

class _App extends State<App> {
  static final _themeData = ThemeData(primarySwatch: Colors.deepOrange,
    bottomAppBarColor: Colors.deepOrange,

  );

  bool _loading = false;
  bool _loggedIn = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'dCoupon',
      theme: _themeData,
      home: home(),
    );
  }

  Widget home() {

    return _loading ? Scaffold() : !_loggedIn ? LoginScreen(loggedInCallback: () {
      setState(_loginCallback);
    },) : AppContainer();//ProductList();

  }

  _loadHome() async {
    _loggedIn = await Session.loadStoredSession();
    setState(() {
      _loading = false;
    });
  }

  _loginCallback() {

    main();

  }


}

