import 'package:flutter/material.dart';
import './productlist.dart';
import 'dart:async';

const TIMEOUT = const Duration(seconds: 2);

class Splash extends StatefulWidget {

  @override
  State createState() => new SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    new Timer(TIMEOUT, onClose);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [Colors.purple.shade500, Colors.purple.shade800],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          ),
        ),
        child: new Center(
          child: new Image(image: new AssetImage("images/app_logo.png"), width: 100.0, height: 50.0,),
        ),
      ),
    );
  }

  onClose () {
    Navigator.of(context).pushReplacement(new PageRouteBuilder(
        maintainState: true,
        opaque: true,
        pageBuilder: (context, _, __) => new ProductList(),
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, anim1, anim2, child) {
          return new FadeTransition(
            child: child,
            opacity: anim1,
          );
        }));
  }
}
