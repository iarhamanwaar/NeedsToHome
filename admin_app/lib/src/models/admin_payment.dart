class AdminPayment {
  String minimumPurchase;
  String currency;
  String driverCommission;
  String cancelTimer;
  String decimalPoints;
  String handyServiceTax;
  String handyServiceCommission;



  // used for indicate if client logged in or not
  bool currencyPosition;
  bool codMode;

//  String role;

  AdminPayment();

  AdminPayment.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      currency = jsonMap['currency'] != null ? jsonMap['currency'] : '';
      minimumPurchase = jsonMap['minimumPurchase'] != null ? jsonMap['minimumPurchase'] : '';
      currencyPosition = jsonMap['currencyPosition'] != null ? jsonMap['currencyPosition'] : false;
      driverCommission = jsonMap['driverCommission'] != null ? jsonMap['driverCommission'] : '';
      cancelTimer = jsonMap['cancelTimer'] != null ? jsonMap['cancelTimer'] : '';
      decimalPoints = jsonMap['decimalPoints'] != null ? jsonMap['decimalPoints'] : '';
      handyServiceTax = jsonMap['handyServiceTax'] != null ? jsonMap['handyServiceTax'] : '';
      handyServiceCommission = jsonMap['handyServiceCommission'] != null ? jsonMap['handyServiceCommission'] : '';
      codMode = jsonMap['codMode'] != null ? jsonMap['codMode'] : '';



    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["minimumPurchase"] = minimumPurchase;
    map["currency"] = currency;
    map["currencyPosition"] = currencyPosition;
    map["driverCommission"] = driverCommission;
    map["cancelTimer"] = cancelTimer;
    map["decimalPoints"] = decimalPoints;
    map["handyServiceTax"] = handyServiceTax;
    map["handyServiceCommission"] = handyServiceCommission;
    map["codMode"] = codMode;







    return map;
  }



}