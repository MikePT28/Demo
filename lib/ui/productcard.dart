import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {

  final String _title;
  final String _discount;
  final String _imageURL;
  final String id;
  final Function _action;

  ProductCard(this.id, this._title, this._discount, this._imageURL, [this._action]);


  @override
  State<StatefulWidget> createState() {
    return ProductCardState(this.id, this._title, this._discount, this._imageURL, this._action);
  }


}

class ProductCardState extends State<ProductCard> {
  String _title;
  String _discount;
  String _imageURL;
  String id;
  Function _action;

  ProductCardState(this.id, this._title, this._discount, this._imageURL, [this._action]);

  bool adding = false;

  setAdding(bool adding) {
    setState(() {
      this.adding = adding;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
                        imageView(_imageURL),
                        Positioned(
                          top: 66.0,
                          child: discountTag(_discount),
                        ),
                      ],
                    ),
                    Expanded(child: Container(child: Column(
                      children: <Widget>[
                        titleText(_title)
                      ],
                    ),
                      margin: new EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),),
                    ),
                    actionButton()
                  ],
                  ),
                ],
              )
          ),
        )
    );

  }

  bool _switchState = true;
  Widget actionButton() {
    if (_action == null) return Container();

    if (_discount == null) {
      return Container(child: Switch(
        value: _switchState,
        onChanged: (newValue){
          setState(() {
            _switchState = newValue;
          });
        },
        activeColor: Colors.green,
        activeTrackColor: Colors.lightGreen.shade300,
      ),);
    }

    return IconButton(
      icon: adding ? SizedBox(width: 30.0, height: 30.0, child: CircularProgressIndicator(),) : Icon(Icons.add),
      onPressed: () {
        if(adding) return;
        _action(this);
      },
    );
  }

  Widget titleText(String text) {
    var title = Container(child: new Text(text, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Color(0xFF333333)),),);

    return title;
  }

  Widget discountTag(String discount) {
    if (discount == null || discount.length == 0) return Container();

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