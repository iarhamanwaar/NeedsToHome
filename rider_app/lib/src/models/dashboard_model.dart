class DashboardModel{
  double todayEarn =0 ;
  double thisMonthEarn = 0;
  double lastSDaysEarn = 0;
  double totalEarn = 0;
  double cashInHand =0;
  int todayOrders = 0;
  int thisMonthOrders = 0;
  int totalOrders = 0;
  String rating = '0';










  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DashboardModel();

  DashboardModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      todayOrders = jsonMap['todayOrders'] != null ? jsonMap['todayOrders'] : 0;
      rating = jsonMap['rating'] != null ? jsonMap['rating'] : 0;
      thisMonthOrders = jsonMap['thisMonthOrders'] != null ? jsonMap['thisMonthOrders'] : 0;
      totalOrders = jsonMap['totalOrders'] != null ? jsonMap['totalOrders'] : 0;
      todayEarn = jsonMap['todayEarn'] != null ? jsonMap['todayEarn'].toDouble()  : 0;
      totalEarn = jsonMap['totalEarn']!= null ? jsonMap['totalEarn'].toDouble()  : 0;
      thisMonthEarn = jsonMap['thisMonthEarn']  != null ? jsonMap['thisMonthEarn'].toDouble() : 0;
      lastSDaysEarn = jsonMap['lastSDaysEarn']  != null ? jsonMap['lastSDaysEarn'].toDouble(): 0;
      cashInHand = jsonMap['cashInHand']  != null ? jsonMap['cashInHand'].toDouble() : 0;

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["todayOrders"] = todayOrders;
    map["rating"] =  rating;
    map["thisMonthOrders"] = thisMonthOrders;
    map["thisMonthOrders"] = thisMonthOrders;

    map["todayEarn"] = todayEarn;
    map["totalEarn"] = totalEarn;
    map["cashInHand"] = cashInHand;







    return map;
  }



}