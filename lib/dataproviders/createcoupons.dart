//Dart Libs
import 'dart:async';

//Dependencies
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

//Project libs
import '../models/product.dart' show CouponResponse;

class CreateCoupon {

  Future<List<CouponResponse>> createCoupon([List<String> productIDs = const []]) async {

    String ids = "";
    if (productIDs.length == 1) {
      ids = productIDs.first;
    }
    else {
      for (int i = 0; i < productIDs.length; i++) {
        ids = ids+productIDs[i];
        if(i < productIDs.length - 1 ) {
          ids = ids+"%2C";
        }
      }
    }

    String url = "https://es.dcoupon.eu/market/createMultipleCoupons";

    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIwYzQ1ZjZjOC1kOTdjLTRkMGEtYWQ4Ni1lZDk1NGM3YjE5ODMiLCJpc3MiOiJkY291cG9uLmNvbSIsImlhdCI6MTUyNjE1MDI4MCwiZXhwIjoxNTU3Njg2MjgwLCJzdWIiOiIxODc3NSIsImVtYWlsIjoiYnBkbWZuc3FAc2hhcmtsYXNlcnMuY29tIiwiYWxpYXMiOiJOb21icmUiLCJyZWd0eXAiOiJlbWFpbCJ9.Av2RBfAtqLCBrchGMqiSfPi8BVF0JK5Dwv1APAvfakg&metaCouponTokens=$ids&apiTokenPublisher=8u3kk3mp66cdomfr6qcu&creationLatitude=&creationLongitude=");
    var responseXML = xml.parse(response.body);
    List<CouponResponse> coupons = [];
    responseXML.findAllElements("ns2:createMultipleCouponResponse").toList().forEach( (xml) {
      String productToken = xml.findAllElements("apiTokenMetaCoupon").first.children.first.text;
      String responseCode = xml.findAllElements("genericResponse").first.findAllElements("responseCode").first.children.first.text;
      coupons.add(CouponResponse(productID: productToken, added: responseCode == "0"));
    });
    return coupons;
  }

}


