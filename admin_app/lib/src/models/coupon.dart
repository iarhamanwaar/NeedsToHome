

class Coupon{
  String id;
  String title;
  String couponType;
  String zone;
  String shopId;
  String startDate;
  String endDate;
  String code;
  String status;
  String discountType;
  String discount;
  String terms;
  String minimumPurchasedAmount;
  String limit;
  var image;
  String addedBy;
  String maximumLimit;
  String 	currentApplied;



  Coupon();
  Coupon.fromJSON(Map<String,dynamic> jsonMap){
    try {
    title=jsonMap['title'].toString();
    id=jsonMap['id'].toString();
    zone=jsonMap['zone'].toString();
    addedBy=jsonMap['addedBy'].toString();
    startDate =jsonMap['startDate'].toString();
    endDate = jsonMap['endDate'].toString();
    code=jsonMap['code'].toString();
    shopId=jsonMap['shopId']!=null?jsonMap['shopId']:'';
    status=jsonMap['status'].toString();
    image = jsonMap['image'];
    couponType=jsonMap['couponType'].toString();
    limit=jsonMap['limit'].toString();
    discountType=jsonMap['discountType'].toString();
    discount=jsonMap['discount'].toString()!= null ? jsonMap['discount'].toString() :  0.0;
    terms=jsonMap['terms'].toString();
    currentApplied = jsonMap['currentApplied'].toString()!= null ? jsonMap['currentApplied'].toString() :  '0';
    maximumLimit = jsonMap['maximumLimit'];
    minimumPurchasedAmount= jsonMap['minimumPurchasedAmount']!= null ? jsonMap['minimumPurchasedAmount'] :  '0';
    } catch (e) {

      print(e);
    }
    }
  Map toMap(){
    var map=Map<String,dynamic>();
    map['title']=title;
    map['zone']= zone;
    map['shopId']= shopId;
    map['couponType']=couponType;
    map['discountType']=discountType;
    map['discount']=discount;
    map['minimumPurchasedAmount']=minimumPurchasedAmount;
    map['code']=code;
    map['terms']=terms;
    map['limit']=limit;
    map['minimumPurchasedAmount']=minimumPurchasedAmount;
    map['startDate']= startDate;
    map['endDate']= endDate;
    map['image']= image;
    map['maximumLimit']= maximumLimit;
    return map;
  }
}