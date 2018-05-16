//Dart Libs
import 'dart:async';
import 'dart:convert';

//Dependencies
import 'package:http/http.dart' as http;

//Project libs
import '../models/token.dart';
import '../models/session.dart';

class GenerateToken {

  Future<Token> generateToken() async {

    String url = "https://es.dcoupon.eu/mycoupons/generateUserIDToken";

    String jwt = Session.shared.current.apiKey;

    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "sessionToken=$jwt");

    var responseJSON = json.decode(response.body);

    return new Token.fromJSON(responseJSON);
  }

}