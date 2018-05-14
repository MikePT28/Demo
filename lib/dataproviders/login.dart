//Dart Libs
import 'dart:async';
import 'dart:convert';

//Dependencies
import 'package:http/http.dart' as http;

//Models
import '../models/user.dart';

class LoginProvider {

  Future<dynamic> doLogin({String username, String password}) async {

    String url = "https://api.dcoupon.eu/id/login";

    var headers = {
      "Content-Type":"application/json",
      "Authorization" : "JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIzYWRhNmFhNC1lY2UyLTQyMjAtYTVkMi0xYjBiY2FhYWM5NmMiLCJpc3MiOiJkY291cG9uLmNvbSIsImlhdCI6MTUyNjI4ODYzMSwiZXhwIjoxNTU3ODI0NjMxLCJzdWIiOiIxODgyNyIsImVtYWlsIjoiZWVwc2Zldm1Ac2hhcmtsYXNlcnMuY29tIiwiYWxpYXMiOiJOb21icmUiLCJyZWd0eXAiOiJlbWFpbCJ9.O-bpKSLYbZpREejOqVy4ENFoRG-0F2Ove21SSroKS4w"
    };

    var body = {
      "emailAddress": username,
      "password" : password,
      "remember" : false,
      "appId" : ""
    };

    http.Response response = await http.post(url, headers: headers, body: jsonEncode(body)).catchError((error) { print(error.toString());});

    var responseJSON = json.decode(response.body);

    int error = responseJSON["statusCode"];
    if (error != null && error > 200) {
      var body = responseJSON["body"];
      return new LoginError.fromJSON(body);
    }

    return new LoginResponse.fromJSON(responseJSON);
  }

}

class LoginResponse {
  User user;

  LoginResponse({String alias, String emailAddress, String jwt}){
    user = new User(name: alias, email: emailAddress, apiKey: jwt);
  }

  factory LoginResponse.fromJSON(Map<String, dynamic> json) {
    return LoginResponse(
      alias: json["alias"],
      emailAddress: json["emailAddress"],
      jwt: json["jwt"]
    );
  }
}

class LoginError {
  String errorCode;
  int errorId;
  String errrorMessage;

  LoginError({this.errorCode, this.errorId, this.errrorMessage});

  factory LoginError.fromJSON(Map<String, dynamic> json){
    return LoginError(
      errorCode: json["errorCode"],
      errorId: json["errorId"],
      errrorMessage: json["errorMessage"]
    );

  }
}

