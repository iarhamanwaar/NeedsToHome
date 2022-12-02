
class Dashboard {
  int newOrders = 0;
  int processing  = 0;
  int outForDelivery = 0;
  int completed =0;
  int newOrdersPercent =0;
  int processingPercent =0 ;
  int outForDeliveryPercent =0;
  int completePercent = 0;
  double totalEarnCod = 0;
  double totalEarnOnline = 0;
  double totalEarn = 0;
  int totalProducts = 0;
  int totalCategory = 0;
  int totalSales = 0;
  double thisMonthSales = 0;


  Dashboard();

  Dashboard.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      newOrders = jsonMap['newOrders'] ;
      processing = jsonMap['processing'];
      outForDelivery = jsonMap['outForDelivery'];
      completed = jsonMap['completed'];
      newOrdersPercent = jsonMap['newOrdersPercent']!=null?jsonMap['newOrdersPercent']:0;
      processingPercent = jsonMap['processingPercent']!=null?jsonMap['processingPercent']:0;
      outForDeliveryPercent = jsonMap['outForDeliveryPercent']!=null?jsonMap['outForDeliveryPercent']:0;
      completePercent = jsonMap['completePercent']!=null?jsonMap['completePercent']:0;
      totalEarnCod = jsonMap['totalEarnCod'].toDouble();
      totalEarnOnline = jsonMap['totalEarnOnline'].toDouble();
      totalEarn = jsonMap['totalEarn'].toDouble();
      totalProducts = jsonMap['totalProducts'];
      totalCategory = jsonMap['totalCategory'];
      totalSales = jsonMap['totalSales'];
      thisMonthSales = jsonMap['thisMonthSales'].toDouble();
    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["newOrders"] = newOrders;
    map["processing"] = processing;
    map["outForDelivery"] = outForDelivery;
    map["completed"] = completed;
    map["newOrdersPercent"] = newOrdersPercent;
    map["processingPercent"] = processingPercent;
    map["outForDeliveryPercent"] = outForDeliveryPercent;
    map["completePercent"] = completePercent;
    map["totalEarnCod"] = totalEarnCod;
    map["totalEarnOnline"] = totalEarnOnline;
    map["totalEarn"] = totalEarn;
    map["totalProducts"] = totalProducts;
    map["totalCategory"] = totalCategory;
    map["totalSales"] = totalSales;
    map["thisMonthSales"] = thisMonthSales;



    return map;
  }


}
