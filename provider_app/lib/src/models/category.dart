class Category {
  String id;
  String categoryName;
  String categoryId;
  String subcategoryName;
  String subcategoryId;
  int experience;
  String type;
  int chargePreHrs;
  int quickPitch;

  Category();

  Category.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      categoryName = jsonMap['categoryName'];
      categoryId = jsonMap['categoryId'];
      subcategoryName = jsonMap['subcategoryName'];
      subcategoryId = jsonMap['subcategoryId'];
      experience = jsonMap['experience'];
      chargePreHrs = jsonMap['chargePreHrs'];
      quickPitch = jsonMap['quickPitch'];
      type = jsonMap['type'];
    } catch (e) {
      id = '';
      categoryName = '';
      categoryId = '';
      subcategoryName = '';
      subcategoryId = '';
      experience = 0;
      chargePreHrs = 0;
      quickPitch = 0;
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["categoryName"] = categoryName;
    map["categoryId"] = categoryId;
    map["subcategoryName"] = subcategoryName;
    map["subcategoryId"] = subcategoryId;
    map["experience"] = experience;
    map["chargePreHrs"] = chargePreHrs;
    map["quickPitch"] = quickPitch;
    map["type"] = type;
    return map;
  }
}
