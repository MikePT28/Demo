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

class Coupon {
  String id;
  String name;
  String promoType;
  String status;
  String imageSrc;
  String maxStamps;
  String usedStamps;
  DateTime startDate;
  DateTime endDate;

  Coupon({this.id, this.name, this.promoType, this.status, this.imageSrc, this.maxStamps, this.usedStamps, this.startDate, this.endDate});

  factory Coupon.fromJSON(Map<String, dynamic> json) {
    return Coupon(
      id: json["couponId"],
      name: json["name"],
      promoType: json["promotionType"],
      status: json["status"],
      imageSrc: json["lowImage"],
      maxStamps: json["maxStamps"],
      usedStamps: json["totalStampsBurnt"],
      startDate: DateTime.parse(json["initialDate"]),
      endDate: DateTime.parse(json["endDate"])
    );
  }
}
