//Flutter libs
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dataproviders/getpromotions.dart';
import '../dataproviders/createcoupons.dart';
import '../dataproviders/getusercoupons.dart';
import '../models/product.dart';
import '../models/session.dart';

import 'productcard.dart';

import 'interfaces/ipage.dart';

import 'package:demo/main.dart';

class ProductList extends StatefulWidget {
  final InterScreenNotifications notification;

  ProductList({this.notification});

  @override
  State createState() {
    return ProductListState(notifications: notification);
  }

}

class ProductListState extends State<StatefulWidget> {
  final InterScreenNotifications notifications;

  ProductListState({this.notifications});

  GetPromotions _promoProvider = GetPromotions();
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

  addProduct(ProductCardState card) async  {
    card.setAdding(true);

    List<CouponResponse> coupons = await _couponCreator.createCoupon([card.id]);
    if (coupons.length == 0) {
      card.setAdding(false);
      return;
    }

    card.setAdding(false);
    _products.removeWhere((_product) {
      return _product.id == card.id;
    });
    notifications.notifyDataChange(0);
    setState(() {
    });
  }

  showFilters() async {
//    var list = await _getCouponsProvider.getCoupons();
//    list.forEach((coupon) => print(coupon.id) );
    _logout();
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
                _list(),
                loaded ? Container() : Center(child: CircularProgressIndicator(),)
              ],
            )
        )
    );

    return view;

  }

  Widget _list() {
    return new ListView.builder(itemBuilder: _itemBuilder, itemCount: _products.length, );

  }

  Widget _itemBuilder(BuildContext context, int index) {

    if (_products == null || _products.length == 0 || _products.length < index) return null;

    var product = _products[index];

    return ProductCard(product.id, product.title, product.discount, product.imageSrc, (card){
      addProduct(card);
    });
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

  }


  _logout() async {
    bool loggedOut = await Session.shared.emptySession();

    if (!loggedOut) return;

    main();

  }

}
