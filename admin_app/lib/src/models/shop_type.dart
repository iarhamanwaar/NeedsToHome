


class ShopTypeModel {
 int id;
 String focusTypeName;
 String colorCode;
 var previewImage;
 var coverImage;
 String shopTypeId;
 String date;
 String commission;
 String superCategory;







  // used for indicate if client logged in or not
  bool auth;

//  String role;

  ShopTypeModel();

  ShopTypeModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      focusTypeName = jsonMap['focusTypeName'] != null ? jsonMap['focusTypeName'] : '';
      commission = jsonMap['commission'] != null ? jsonMap['commission'] : '';
      colorCode = jsonMap['colorCode'] != null ? jsonMap['colorCode'] : '';
      previewImage = jsonMap['previewImage'] != null ? jsonMap['previewImage'] : '';
      coverImage = jsonMap['coverImage'] != null ? jsonMap['coverImage'] : '';
      shopTypeId = jsonMap['shopTypeId'] != null ? jsonMap['shopTypeId'] : '';
      date = jsonMap['date'] != null ? jsonMap['date'] : '';
      superCategory = jsonMap['superCategory'] != null ? jsonMap['superCategory'] : '';


    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["title"] = focusTypeName;
    map["colorCode"] = colorCode;
    map["previewImage"] = previewImage;
    map["coverImage"] = coverImage;
    map["shopFocusType"] = shopTypeId;
    map["date"] = date;
    map["id"] = id;
    map["superCategory"] = superCategory;



    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
