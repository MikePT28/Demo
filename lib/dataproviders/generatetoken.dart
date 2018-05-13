//Dart Libs
import 'dart:async';
import 'dart:convert';

//Dependencies
import 'package:http/http.dart' as http;

//Project libs
import '../models/token.dart';

class GenerateToken {

  Future<Token> generateToken() async {

    String url = "https://es.dcoupon.eu/mycoupons/generateUserIDToken";

    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "sessionToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIwYzQ1ZjZjOC1kOTdjLTRkMGEtYWQ4Ni1lZDk1NGM3YjE5ODMiLCJpc3MiOiJkY291cG9uLmNvbSIsImlhdCI6MTUyNjE1MDI4MCwiZXhwIjoxNTU3Njg2MjgwLCJzdWIiOiIxODc3NSIsImVtYWlsIjoiYnBkbWZuc3FAc2hhcmtsYXNlcnMuY29tIiwiYWxpYXMiOiJOb21icmUiLCJyZWd0eXAiOiJlbWFpbCJ9.Av2RBfAtqLCBrchGMqiSfPi8BVF0JK5Dwv1APAvfakg");

    var responseJSON = json.decode(response.body);

    return new Token.fromJSON(responseJSON);
  }

}