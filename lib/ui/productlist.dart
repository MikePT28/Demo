//Flutter libs
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dataproviders/getpromotions.dart';
import '../dataproviders/generatetoken.dart';
import '../dataproviders/createcoupons.dart';
import '../dataproviders/getusercoupons.dart';
import '../models/product.dart';

import 'productcard.dart';

class ProductList extends StatefulWidget{

  @override
  State createState() => new ProductListState();

}

class ProductListState extends State<StatefulWidget>{
  GetPromotions _promoProvider = GetPromotions();
  GenerateToken _tokenProvider = GenerateToken();
  CreateCoupon _couponCreator = CreateCoupon();
  GetUserCoupons _getCouponsProvider = GetUserCoupons();

  List<Product> _products = List();
  List<Coupon> _userCoupons = List();

  bool loaded = false;

  @override
  void initState(){
    super.initState();

    load();
  }

  load() async {

    _products = await _promoProvider.getPromotions();
    _userCoupons = await _getCouponsProvider.getCoupons();

    if (_products.length == 0) { return; }

    if (_userCoupons.length > 0) {
      _userCoupons.forEach((coupon){
        _products.removeWhere((product) {
          return product.title == coupon.name;
        });
      });
    }

    setState(() {
      loaded = true;
    });
  }

  reload() async {
    setState(() {
      _products = [];
      _userCoupons = [];
      loaded = false;
    });
    load();
  }

  addProduct(ProductCard card) async  {


    card.isAdding(true);

    List<CouponResponse> coupons = await _couponCreator.createCoupon([card.id]);
    if (coupons.length == 0) {
      card.isAdding(false);
      return;
    };

    _products.removeWhere((_product) {
      return _product.id == card.id;
    });
    card.isAdding(false);
    setState(() {
      _products = _products;
    });

  }

  showFilters() async {
    var list = await _getCouponsProvider.getCoupons();
    list.forEach((coupon) => print(coupon.id) );
  }

  @override
  Widget build(BuildContext context) {
    var view = new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: new Text("dCoupon"),
          actions: <Widget>[
            IconButton(onPressed: showFilters, icon: Icon(Icons.filter_list),),
            IconButton(onPressed: reload, icon: Icon(Icons.refresh),)

          ],
        ),
        backgroundColor: Color(0xFFF4F4F4),
        body: new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Stack(
              children: <Widget>[
                new ListView.builder(itemBuilder: _itemBuilder, itemCount: _products.length,),
                loaded ? Container() : Center(child: CircularProgressIndicator(),)
              ],
            )
        )
    );



    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: view,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {

    if (_products == null || _products.length == 0 || _products.length < index) return null;

    var product = _products[index];

    return ProductCard(product.id, product.title, product.discount, product.imageSrc, (card){
      addProduct(card);
    });
    return Container(
        margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
        child: Card(
          child: Container(
              margin: new EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Stack(
                      children: <Widget>[
                        imageView(_products[index].imageSrc),
                        Positioned(
                          top: 66.0,
                          child: discountTag(product.discount),
                        ),
                      ],
                    ),
                    Expanded(child: Container(child: Column(
                      children: <Widget>[
                        titleText(_products[index].title)
                      ],
                    ),
                      margin: new EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),),
                    ),
                    IconButton(
                      icon: product.added ? CircularProgressIndicator() : Icon(Icons.add),
                      onPressed: () {
//                        addProduct(product);
                      },
                    ),
                  ],
                  ),
                ],
              )
          ),
        )
    );



  }


  Widget titleText(String text) {
    var title = Container(child: new Text(text, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF333333)),),);

    return title;
  }

  Widget discountTag(String discount) {
    var tag = Card(
      elevation: 2.0,
      color: Colors.green,
      child: Container(
        margin: new EdgeInsets.all(4.0),
        child: Text(discount,
          style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );

    return tag;
  }


  Widget imageView(String imageURL) {


    var image = new Image.network(imageURL);

    var box = SizedBox(
      width: 100.0,
      height: 100.0,
      child: image,
    );

    return box;

//    var image = CircleAvatar(
//      backgroundColor: Colors.white,
//      child: OverflowBox(
//        maxHeight: 70.0,
//        maxWidth: 70.0,
////        margin: new EdgeInsets.all(4.0),
//        child: new Image.network(imageURL),
//      ),
//      radius: 50.0,
//    );
//
//
//    return Card(
//      elevation: 0.0,
//      shape: new CircleBorder(),
//      child: image ,
//    );
  }

//  Future<List<Category>> getJSON() async {
//
//    String url = "https://es.dcoupon.eu/market/getAvailableCategories";
//
//    http.Response response = await http.post(url, headers: {"Content-Type":"application/x-www-form-urlencoded"}, body: "apiToken=8u3kk3mp66cdomfr6qcu&datetime=&country=ES&signatureValue=&lang=es");
////    document.body.nodes.first.nodes[0].attributes["title"]
//    List<Category> items = new List();
//    dom.Document document = parse(response.body);
//    document.body.nodes.forEach((e) {
//      if (e.nodes.length > 0) {
//        String name = e.nodes.first.attributes["title"];
//        String value = e.nodes.first.attributes["value"];
//        if (name.isNotEmpty && value.isNotEmpty) {
//          items.add(Category(name, value));
//        }
//      }
//    });
//
//    return items;
////    return JsonDecoder().convert(response.body);
//  }

}
