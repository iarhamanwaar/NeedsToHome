
class DashboardCounter {
  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  String subtext;
  int total;


  // used for indicate if client logged in or not
  bool auth;

//  String role;

  DashboardCounter();

  DashboardCounter.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      imagePath = jsonMap['imagePath'] != null ? jsonMap['imagePath'] : '';
      titleTxt = jsonMap['titleTxt'] != null ? jsonMap['titleTxt'] : '';
      startColor = jsonMap['startColor'] != null ? jsonMap['startColor'] : '';
      endColor = jsonMap['endColor'] != null ? jsonMap['endColor'] : '';
      subtext = jsonMap['subtext'] != null ? jsonMap['subtext'] : '';
      total = jsonMap['total'] != null ? jsonMap['total'] : 0;


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["imagePath"] = imagePath;
    map["titleTxt"] = titleTxt;
    map["startColor"] = startColor;
    map["endColor"] = endColor;
    map["subtext"] = subtext;
    map["total"] = total;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
