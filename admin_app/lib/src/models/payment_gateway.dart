class PaymentGatewayModel{
  String rayzorPaySK;
  String upiId;
  String paypalClientID;
  String fwpbfPublickey;
  String stripePK;
  String stripeSK;
  String mpesaConsumerKey;
  String mpesaConsumerSecret;
  String mpesaPasskey;
  String payStackPK;
  String payStackSK;
  bool rayzorPay;
  bool upiID;
  bool paypal;
  bool flutterWay;
  bool stripe;
  bool mpesa;
  bool payStack;



  PaymentGatewayModel();

  PaymentGatewayModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      rayzorPaySK = jsonMap['rayzorPaySK'] != null ? jsonMap['rayzorPaySK'] : '';
      upiId = jsonMap['upiId'] != null ? jsonMap['upiId'] : '';
      paypalClientID = jsonMap['paypalClientID'] != null ? jsonMap['paypalClientID'] : '';
      fwpbfPublickey = jsonMap['fwpbfPublickey'] != null ? jsonMap['fwpbfPublickey'] : '';
      stripePK = jsonMap['stripePK'] != null ? jsonMap['stripePK'] : '';
      stripeSK = jsonMap['stripeSK'] != null ? jsonMap['stripeSK'] : '';
      payStackPK = jsonMap['payStackPK'] != null ? jsonMap['payStackPK'] : '';
      payStackSK = jsonMap['payStackSK'] != null ? jsonMap['payStackSK'] : '';
      mpesaConsumerKey = jsonMap['mpesaConsumerKey'] != null ? jsonMap['mpesaConsumerKey'] : '';
      mpesaConsumerSecret = jsonMap['mpesaConsumerSecret'] != null ? jsonMap['mpesaConsumerSecret'] : '';
      mpesaPasskey = jsonMap['mpesaPasskey'] != null ? jsonMap['mpesaPasskey'] : '';
      rayzorPay = jsonMap['rayzorPay'] != null ? jsonMap['rayzorPay'] : false;
      upiID = jsonMap['upiID'] != null ? jsonMap['upiID'] : false;
      paypal = jsonMap['paypal'] != null ? jsonMap['paypal'] : false;
      flutterWay = jsonMap['flutterWay'] != null ? jsonMap['flutterWay'] : false;
      stripe = jsonMap['stripe'] != null ? jsonMap['stripe'] : false;
      mpesa = jsonMap['mpesa'] != null ? jsonMap['mpesa'] : false;
      payStack = jsonMap['payStack'] != null ? jsonMap['payStack'] : false;

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["rayzorPaySK"] = rayzorPaySK;
    map["upiId"] = upiId;
    map["paypalClientID"] = paypalClientID;
    map["fwpbfPublickey"] = fwpbfPublickey;
    map["stripePK"] = stripePK;
    map["stripeSK"] = stripeSK;
    map["rayzorPay"] = rayzorPay;
    map["upiID"] = upiID;
    map["paypal"] = paypal;
    map["flutterWay"] = flutterWay;
    map["stripe"] = stripe;
    map["mpesa"] = mpesa;
    map["payStack"] = payStack;
    map["payStackPK"] = payStackPK;
    map["payStackSK"] = payStackSK;
    map["mpesaConsumerKey"] = mpesaConsumerKey;
    map["mpesaConsumerSecret"] = mpesaConsumerSecret;
    map["mpesaPasskey"] = mpesaPasskey;





    return map;
  }



}