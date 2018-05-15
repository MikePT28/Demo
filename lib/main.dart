import 'package:flutter/material.dart';
import './ui/loginscreen.dart';
import './ui/productlist.dart';
import 'models/session.dart';
import 'ui/mycouponsscreen.dart';

void main() => runApp(new App());

class App extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _App();

}

class _App extends State<StatefulWidget> {
  final _themeData = ThemeData(primarySwatch: Colors.deepOrange,
    bottomAppBarColor: Colors.deepOrange,

  );

  int index = 0;

  Widget main() {
    var app = new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: new MaterialApp(theme: _themeData,home: new ProductList()),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: new MaterialApp(theme: _themeData,home: _myCoupons()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) { setState((){ this.index = index; }); },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home, color: (index == 0 ? Colors.deepOrange : null),),
            title: new Text("Coupons", style: TextStyle(color: (index == 0 ? Colors.deepOrange: null))),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(const IconData(0xe902, fontFamily: 'Icons'), color: (index == 0 ? null : Colors.deepOrange),),
            title: new Text("My Coupons", style: TextStyle(color: (index == 0 ? null : Colors.deepOrange)),),

          ),
        ],
      ),
    );

    return MaterialApp(home: app,);
  }

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
      title: 'dCoupon',
      theme: _themeData,
      home: home(),
    );
  }

  Widget home() {

    return _loading ? Scaffold() : Session.shared.isEmpty() ? LoginScreen() : main();//ProductList();

  }

  _loadHome() async {
    var loaded = await Session.loadStoredSession();
    setState(() {
      _loading = false;
    });
  }

  Widget _myCoupons() {
    return MyCouponsScreen();
  }

}

