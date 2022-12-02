
class Rating {
  String bookId;
  double rate;
  String userId;
  String providerId;
  String review;
  String type;

  Rating();

  Rating.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      bookId = jsonMap['bookId'].toString();
      rate = jsonMap['rate'];
      userId = jsonMap['userId'];
      providerId = jsonMap['providerId'];
      review = jsonMap['review'];
      type = jsonMap['type'];
    } catch (e) {
      bookId = '';
      rate = 0.0;
      userId = '';
      providerId = '';
      review = '';
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["bookId"] = bookId;
    map["rate"] = rate;
    map["userId"] = userId;
    map["providerId"] = providerId;
    map["review"] = review;
    return map;
  }
}
