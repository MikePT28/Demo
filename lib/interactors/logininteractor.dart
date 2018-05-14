import 'package:shared_preferences/shared_preferences.dart';

import '../models/session.dart';
import '../dataproviders/login.dart';
import '../models/user.dart';

abstract class LoginInteractorDelegate {

  loginSuccess(User user);
  loginError(String message);

}

class LoginInteractor {
  final LoginProvider _provider = LoginProvider();

  LoginInteractorDelegate delegate;

  LoginInteractor({this.delegate});

  doLogin({String username, String password}) async {
    var response = await _provider.doLogin(username: username, password: password);
    if (response is LoginError) {
      LoginError error = response as LoginError;
      delegate.loginError(error.errrorMessage);
    }
    else {
      LoginResponse success = response as LoginResponse;
      Session.shared.setCurrent(success.user);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("localKey" , success.user.apiKey);

      delegate.loginSuccess(success.user);
    }
  }

}