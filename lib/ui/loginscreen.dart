import 'package:flutter/material.dart';
import '../interactors/logininteractor.dart';
import '../models/user.dart';

import 'productlist.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<StatefulWidget> implements LoginInteractorDelegate {
  LoginInteractor _loginInteractor;

  bool _performinLoginAction = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _errorMessage = "";

  doLogin() {
    _usernameController.text = "ixxgznle@sharklasers.com";
    _passwordController.text = "password";
    //Validate
    if (_usernameController.text.isEmpty && _passwordController.text.isEmpty) {
      return;
    }

    _loginInteractor.doLogin(username: _usernameController.text, password: _passwordController.text);
    setState(() {
      _errorMessage = "";
      _performinLoginAction = true;
    });

  }
  @override
  void initState() {
    super.initState();
    _loginInteractor = LoginInteractor(delegate: this);
  }

  @override
  loginError(String message) {
    setState(() {
      _performinLoginAction = false;
      _errorMessage = message;
    });
  }

  @override
  loginSuccess(User user) {
    _performinLoginAction = false;
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductList()));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: new Text("dCoupon")),
      body: Container(
        margin: new EdgeInsets.all(24.0),
        child: logInBlock()
      ),
    );
  }

  Widget logInBlock() {
    return Column(
      children: <Widget>[
        TextField(decoration: InputDecoration(hintText: "Username"), controller: _usernameController,),
        SizedBox(height: 12.0,),
        TextField(decoration: InputDecoration(hintText: "Password"), obscureText: true, controller: _passwordController,),
        SizedBox(height: 12.0,),
        errorMessage(),
        actionSegment(),
      ],
    );
  }

  Widget actionSegment() {
    return _performinLoginAction ?
    Center(child: CircularProgressIndicator(),)
        :
    FlatButton(child: new Text("Login"),
        onPressed: (){
          doLogin();
        });
  }

  Widget errorMessage() {
    return (_errorMessage.length > 0) ?
      Column(
      children: <Widget>[
        SizedBox(height: 8.0,),
        Text(_errorMessage, textAlign: TextAlign.left, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
        SizedBox(height: 8.0,),
      ],
    )
        :
    SizedBox(height: 8.0,);
  }
}


//const TIMEOUT = const Duration(seconds: 2);
//
//class Splash extends StatefulWidget {
//
//  @override
//  State createState() => new SplashState();
//}
//
//class SplashState extends State<Splash> {
//
//  @override
//  void initState() {
//    super.initState();
//    new Timer(TIMEOUT, onClose);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: new Container(
//        decoration: new BoxDecoration(
//          gradient: new LinearGradient(
//              colors: [Colors.purple.shade500, Colors.purple.shade800],
//              begin: Alignment.topCenter,
//              end: Alignment.bottomCenter
//          ),
//        ),
//        child: new Center(
//          child: new Image(image: new AssetImage("images/app_logo.png"), width: 100.0, height: 50.0,),
//        ),
//      ),
//    );
//  }
//
//  onClose () {
//    Navigator.of(context).pushReplacement(new PageRouteBuilder(
//        maintainState: true,
//        opaque: true,
//        pageBuilder: (context, _, __) => new ProductList(),
//        transitionDuration: const Duration(milliseconds: 300),
//        transitionsBuilder: (context, anim1, anim2, child) {
//          return new FadeTransition(
//            child: child,
//            opacity: anim1,
//          );
//        }));
//  }
//}
