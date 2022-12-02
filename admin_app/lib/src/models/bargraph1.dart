
class BarGraph1Model {
  int month;
  double orders;




  BarGraph1Model();

  BarGraph1Model.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      month = jsonMap['month'];
      orders = jsonMap['orders'].toDouble();


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["month"] = month;
    map["orders"] = orders;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();

    return map.toString();
  }
}
