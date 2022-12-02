class PasswordUpdate {
  String oldPassword;
  String newPassword;
  String vendorId;
  PasswordUpdate();
  PasswordUpdate.fromJSON(Map<String, dynamic> jsonMap){
    try {
      oldPassword = jsonMap['oldPassword'] != null ? jsonMap['oldPassword'] : '';
      newPassword = jsonMap['newPassword'] != null ? jsonMap['newPassword'] : '';
      vendorId = jsonMap['vendorId'] != null ? jsonMap['vendorId'] : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap(){
    var map=Map<String,dynamic>();
    map['oldPassword']=oldPassword;
    map['newPassword']=newPassword;
    map['vendorId']=vendorId;


    return map;
  }
}
