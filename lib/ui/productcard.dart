import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {

  String _title;
  String _discount;
  String _imageURL;
  String id;
  Function _action;

  ProductCard(this.id, this._title, this._discount, this._imageURL, [this._action]);

  var _state;
  @override
  State<StatefulWidget> createState() {
    _state = _ProductCard();
    return _state;
  }

  isAdding(bool adding) {
    _state.setAdding(adding);
  }


}

class _ProductCard extends State<ProductCard> {

  bool _adding = false;

  setAdding(bool adding) {
    setState(() {
      _adding = adding;
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
                        imageView(widget._imageURL),
                        Positioned(
                          top: 66.0,
                          child: discountTag(widget._discount),
                        ),
                      ],
                    ),
                    Expanded(child: Container(child: Column(
                      children: <Widget>[
                        titleText(widget._title)
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
    if (widget._action == null) return Container();

    if (widget._discount == null) {
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
      icon: _adding ? CircularProgressIndicator() : Icon(Icons.add),
      onPressed: () {
        widget._action(widget);
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