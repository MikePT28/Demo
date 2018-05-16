//Flutter libs
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../dataproviders/getusercoupons.dart';
import '../models/product.dart';

import 'productcard.dart';

import 'interfaces/ipage.dart';


class MyCouponsScreen extends StatefulWidget implements IPage {

  MyCouponsScreen();

  final MyCouponsScreenState _state = MyCouponsScreenState();
  @override
  State createState() => _state;

  @override
  void dataChanged() {
    _state.dataChanged();
  }


}

class MyCouponsScreenState extends State<MyCouponsScreen> implements IPage {

  GetUserCoupons _getCouponsProvider = GetUserCoupons();

  List<Coupon> _userCoupons = List();

  bool loaded = false;


  @override
  void dataChanged() {
    reload();
  }

  @override
  void initState(){
    super.initState();

    load();
  }

  load() async {

    _userCoupons = await _getCouponsProvider.getCoupons();

    if (_userCoupons.length == 0) { return; }

    setState(() {
      loaded = true;
    });
  }

  reload() {
    setState(() {
      _userCoupons = [];
      loaded = false;
    });
    load();
  }


  @override
  Widget build(BuildContext context) {
    var view = new Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: new Text("dCoupon"),
          actions: <Widget>[
            IconButton(onPressed: reload, icon: Icon(Icons.refresh),)

          ],
        ),
        backgroundColor: Color(0xFFF4F4F4),
        body: new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Stack(
              children: <Widget>[
                new ListView.builder(itemBuilder: _itemBuilder, itemCount: _userCoupons.length,),
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

    if (_userCoupons == null || _userCoupons.length == 0 || _userCoupons.length < index) return null;

    var product = _userCoupons[index];

    return ProductCard(product.id, product.name, null, product.imageSrc, (){});


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

}
