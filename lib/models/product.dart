class Product {
  String imageSrc;
  String discount;
  String title;
  String description;
  String id;

  bool added = false;

  Product(this.title, this.discount, this.description, this.imageSrc, this.id);
}

class CouponResponse {
  final String productID;
  final bool added;

  CouponResponse({this.productID, this.added});
}