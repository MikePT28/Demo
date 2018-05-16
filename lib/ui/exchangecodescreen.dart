import 'package:flutter/material.dart';
import 'dart:async';

import '../dataproviders/generatetoken.dart';
import 'productlist.dart';
import '../models/token.dart';

class ExchangeCodeScreen extends StatefulWidget {

  ExchangeCodeScreen();

  @override
  State createState() => _ExchangeCodeScreenState();

}

class _ExchangeCodeScreenState extends State<ExchangeCodeScreen> implements LinearProgressBarDelegate {
  GenerateToken _tokenProvider = GenerateToken();

  static const _tokenExpiresTime = 90; //In Seconds
  int _timeSpent = 0;

  Stopwatch _stopwatch = Stopwatch();

  bool _showing = false;
  bool _fetching = false;
  Token _token;

  _fetchToken() async {
    _timeSpent = 0;
    setState(() {
      _fetching = true;
    });

    _token = await _tokenProvider.generateToken();
    _stopwatch.reset();
    _stopwatch.start();

    setState(() {
      _fetching = false;
    });
  }

  @override
  int timeout() => _tokenExpiresTime;

  @override
  timerTick() {
    _timeSpent += 1;
    if (_timeSpent >= _tokenExpiresTime) {
      _stopwatch.stop();
      _showing =false;
      setState(() { });
      return;
    }

  }

  @override
  void initState() {
    super.initState();
  }

  _reload() {
    _stopwatch.stop();
    setState(() {
      _showing = false;
      _fetching = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: new Text("dCoupon"),
        actions: <Widget>[
          _showing ? IconButton(onPressed: _reload, icon: Icon(Icons.cancel),) : Container()

        ],
      ),
      backgroundColor: Color(0xFFF4F4F4),
      body: Center(
        child: Container(
          margin: new EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 100.0,
                  child: Card(
                    child: _showing ? _codeSegment() : _showCodeButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showCodeButton() {
    return FlatButton(
      onPressed: (){
        _fetchToken();
        setState(() {
          _showing = true;
        });
      },
      child: Text(
        "Show exchange code",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _codeSegment() {
    if (_fetching) return Center(child: CircularProgressIndicator(),);


    var text = Text(_token.token,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 60.0
      ),
    );


    return Container(
      child: Stack(
        children: <Widget>[
          Center(child: text,),
          Positioned(
            child: LinearBar(stopwatch: _stopwatch, delegate: this),
          )
        ],
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

abstract class LinearProgressBarDelegate {

  int timeout();
  timerTick();

}

class LinearBar extends StatefulWidget {
  LinearBar({this.stopwatch, this.delegate});
  final Stopwatch stopwatch;
  final LinearProgressBarDelegate delegate;

  LinearBarState createState() => new LinearBarState(stopwatch: stopwatch, delegate: delegate);
}

class LinearBarState extends State<LinearBar> {

  Timer timer;
  final Stopwatch stopwatch;
  final LinearProgressBarDelegate delegate;

  LinearBarState({this.stopwatch, this.delegate}) {
    timer = new Timer.periodic(new Duration(milliseconds: 1000), callback);
  }

  void callback(Timer timer) {
    if (stopwatch.isRunning) {
      delegate.timerTick();
      setState(() {
        value = timer.tick / delegate.timeout();
      });
    }
  }

  var value = 0.0;
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value,);
  }
}

