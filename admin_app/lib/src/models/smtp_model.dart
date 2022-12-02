class Smtp{
  String host;
  String port;
  String user;
  String password;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Smtp();

  Smtp.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      host = jsonMap['host'] != null ? jsonMap['host'] : '';
      port = jsonMap['port'] != null ? jsonMap['port'] : '';
      user = jsonMap['user'] != null ? jsonMap['user'] : '';
      password = jsonMap['password'] != null ? jsonMap['password'] : '';



    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["host"] = host;
    map["port"] = port;
    map["user"] = user;
    map["password"] = password;







    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}