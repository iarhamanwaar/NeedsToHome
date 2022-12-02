
class SummaryReport {
  double totalRevenue =0;
  double thisMonthRevenue =0;
  double totalPaidCommission = 0;
  double totalDueCommission =0;
  int totalOrders = 0;
  int thisMonthOrders =0;
  int totalPaidOrders =0;
  int totalDueOrders =0;



  // used for indicate if client logged in or not
  bool auth;

//  String role;

  SummaryReport();

  SummaryReport.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      totalRevenue = jsonMap['totalRevenue'] ;
      totalPaidCommission = jsonMap['totalPaidCommission'];
      totalDueCommission = jsonMap['totalDueCommission'] ;
      thisMonthRevenue = jsonMap['thisMonthRevenue'] ;
      totalOrders = jsonMap['totalOrders'];
      thisMonthOrders = jsonMap['thisMonthOrders'] ;
      totalPaidOrders = jsonMap['totalPaidOrders'] ;
      totalDueOrders = jsonMap['totalDueOrders'];


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["totalRevenue"] = totalRevenue;
    map["totalPaidCommission"] = totalPaidCommission;
    map["totalDueCommission"] = totalDueCommission;
    map["thisMonthRevenue"] = thisMonthRevenue;
    map["totalOrders"] = totalOrders;
    map["thisMonthOrders"] = thisMonthOrders;
    map["totalPaidOrders"] = totalPaidOrders;
    map["totalDueOrders"] = totalDueOrders;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
