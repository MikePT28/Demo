import 'package:flutter/material.dart';
import 'productlist.dart';
import 'mycouponsscreen.dart';
import 'exchangecodescreen.dart';
import 'interfaces/ipage.dart';
import 'package:flutter/services.dart';

class AppContainer extends StatefulWidget {

  @override
  _AppContainer createState() => _AppContainer();

}

class _AppContainer extends State<AppContainer> implements InterScreenNotifications {
  static final _themeData = ThemeData(primarySwatch: Colors.deepOrange,
    bottomAppBarColor: Colors.deepOrange,

  );

  int index = 0;

  List pages;

  @override
  void initState() {
    pages = [
      ProductList(notification: this),
      MyCouponsScreen(),
      ExchangeCodeScreen(),
    ];
    super.initState();
  }



  @override
  notifyDataChange(int page) {
    if (page == 0) {
      (pages[1] as IPage).dataChanged();
    }
  }

  Widget main() {
    var app = new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Offstage(
            offstage: index != 0,
            child: new TickerMode(
              enabled: index == 0,
              child: new MaterialApp(theme: _themeData,home:pages.first),
            ),
          ),
          new Offstage(
            offstage: index != 1,
            child: new TickerMode(
              enabled: index == 1,
              child: new MaterialApp(theme: _themeData,home:pages[1]),
            ),
          ),
          new Offstage(
            offstage: index != 2,
            child: new TickerMode(
              enabled: index == 2,
              child: new MaterialApp(theme: _themeData,home:pages.last),
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
            icon: new Icon(const IconData(0xe902, fontFamily: 'Icons'), color: (index != 1 ? null : Colors.deepOrange),),
            title: new Text("My Coupons", style: TextStyle(color: (index != 1 ? null : Colors.deepOrange)),),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(const IconData(0xe903, fontFamily: 'Icons'), color: (index != 2 ? null : Colors.deepOrange),),
            title: new Text("Exchange", style: TextStyle(color: (index != 2 ? null : Colors.deepOrange)),),
          ),
        ],
      ),
    );



    return MaterialApp(home: app);
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
      },
      child: main(),
    );
  }



}
