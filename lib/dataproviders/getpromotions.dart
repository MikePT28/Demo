//Dart Libs
import 'dart:async';

//Dependencies
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as dom;

//Project libs
import '../models/product.dart';

class GetPromotions {

  Future<List<Product>> getPromotions([List<String> categoriesIDs = const []]) async {

    String ids = "";
    if (categoriesIDs.length == 1) {
      ids = categoriesIDs.first;
    }
    else {
      for (int i = 0; i < categoriesIDs.length; i++) {
        ids = ids+categoriesIDs[i];
        if(i < categoriesIDs.length - 1 ) {
          ids = ids+",";
        }
      }
    }


    String url = "https://es.dcoupon.eu/market/getPromotions";

    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: "apiToken=8u3kk3mp66cdomfr6qcu&datetime=&country=ES&signatureValue=&categoryIds=$ids&retailerTokens=&storeIds=&textSearch=&companyTokens=&longitude=&latitude=&radius=&zipcode=&start=0&limit=999&orderBy=NEWEST&lang=es");

    List<Product> items = new List();

    dom.Document document = parse(response.body);

    document.body.nodes.forEach((e) {

      if (e.nodes.length > 0 && e.attributes["class"].toString().contains("coupon-list-item")) {
        String imageSrc = e.nodes.first.nodes.first.nodes.first.nodes.first.attributes["src"].toString();
        imageSrc = "https:"+imageSrc;
        String discount = e.nodes.first.nodes.first.nodes[1].nodes.first.nodes.first.toString().replaceAll("\"", "").replaceAll("\"", "");
        String title = e.nodes.first.nodes.first.nodes[2].nodes.first.nodes.first.toString().replaceAll("\"", "").replaceAll("\"", "").replaceAll(" - Ver Info.", "").replaceAll("-Ver info.", "").replaceAll("-Ver Info-", "");
        String description = e.nodes.first.nodes.first.nodes[3].nodes.first.nodes.first.nodes.first.toString().replaceAll("\"", "").replaceAll("\"", "");
        String id = e.nodes.first.nodes[1].nodes[1].attributes["data-promotion_token"];


        items.add(Product(title, discount, description, imageSrc, id));
      }
    });

    return items;
  }

}