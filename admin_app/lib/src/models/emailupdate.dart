class EmailUpdate {
  String password;
  String email;
  EmailUpdate();
  EmailUpdate.fromJSON(Map<String, dynamic> jsonMap){
    try {
      password = jsonMap['password'] != null ? jsonMap['password'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap(){
    var map=Map<String,dynamic>();
    map['password']=password;
    map['email']=email;


    return map;
  }
}
