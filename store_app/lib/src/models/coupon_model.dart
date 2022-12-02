

class CouponModel{
  String title;
  String code;
  String image;
  String couponType;
  String discountType;
  double discount;
  String terms;
  double minimumPurchasedAmount;
  String limitUser;
  String zoneId;
  String shopId;



  CouponModel();
  CouponModel.fromJSON(Map<String,dynamic> jsonMap){
    try {
      title = jsonMap['title'] != null ? jsonMap['title'] : '';
      code = jsonMap['code'] != null ? jsonMap['code'] : '';
      image = jsonMap['image'] != null ? jsonMap['image'] : '';
      couponType = jsonMap['couponType'] != null ? jsonMap['couponType'] : '';
      limitUser = jsonMap['limitUser'] != null ? jsonMap['limitUser'] : '';
      discountType =
      jsonMap['discountType'] != null ? jsonMap['discountType'] : '';
      discount = jsonMap['discount'].toDouble() != null
          ? jsonMap['discount'].toDouble()
          : 0.0;
      terms = jsonMap['terms'] != null ? jsonMap['terms'] : '';
      minimumPurchasedAmount =
      jsonMap['minimumPurchasedAmount'].toDouble() != null
          ? jsonMap['minimumPurchasedAmount'].toDouble()
          : 0.0;
    }   catch (e) {
      print('coupon error $e');
    }
    }

  Map<String, dynamic> toJson() => {
    "title": title,
    "code": code,
    "image": image,
    "couponType": couponType,
    "limitUser": limitUser,
    "discountType": discountType,
    "discount": discount,
    "terms": terms,
    "minimumPurchasedAmount": minimumPurchasedAmount,
  };


  Map toMap(){
    var map=Map<String,dynamic>();
    map['title']=title;
    map['code']=code;
    map['image']=image;
    map['couponType']=couponType;
    map['limitUser']=limitUser;
    map['discountType']=discountType;
    map['discount']=discount;
    map['terms']=terms;
    map['minimumPurchasedAmount']= minimumPurchasedAmount;
    return map;
}
}