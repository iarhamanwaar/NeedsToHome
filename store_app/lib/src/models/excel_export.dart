class ExcelExportModel{

  String title;
  double columnWidth;
  String color;
  bool bold;






  // used for indicate if client logged in or not
  bool auth;

//  String role;

  ExcelExportModel({this.title, this.columnWidth, this.color, this.bold});

  ExcelExportModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      title = jsonMap['title'] != null ? jsonMap['title'] : '';
      columnWidth = jsonMap['columnWidth'] != null ? jsonMap['columnWidth'].toDouble() : 0;
      color = jsonMap['color']!= null ? jsonMap['color'] : '';
      bold = jsonMap['bold']!= null ? jsonMap['bold'] : false;




    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = title;
    map["columnWidth"] =  columnWidth;
    map["color"] = color;
    map["bold"] = bold;
    return map;
  }



}