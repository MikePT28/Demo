//Dart Libs
import 'dart:async';
import 'dart:convert';

//Dependencies
import 'package:http/http.dart' as http;

//Project libs
import '../models/product.dart' show Coupon;
import '../models/session.dart';


class GetUserCoupons {

  Future<List<Coupon>> getCoupons() async {

    String url = "https://es.dcoupon.eu/mycoupons/getUserCoupons";

    String jwt = Session.shared.current.apiKey;
    String body = "sessionToken=$jwt";

    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: body);

    var responseJSON = json.decode(response.body);

    List<Coupon> coupons = [];
    responseJSON.forEach((json) {
      coupons.add(new Coupon.fromJSON(json));
    });

    return coupons;
  }

}