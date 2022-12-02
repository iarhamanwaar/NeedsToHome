class PasswordUpdate {
  String oldPassword;
  String newPassword;
  String adminId;
  PasswordUpdate();
  PasswordUpdate.fromJSON(Map<String, dynamic> jsonMap){
    try {
      oldPassword = jsonMap['oldPassword'] != null ? jsonMap['oldPassword'] : '';
      newPassword = jsonMap['newPassword'] != null ? jsonMap['newPassword'] : '';
      adminId = jsonMap['adminId'] != null ? jsonMap['adminId'] : '';
    } catch (e) {
      print(e);
    }
  }

  Map toMap(){
    var map=Map<String,dynamic>();
    map['oldPassword']=oldPassword;
    map['newPassword']=newPassword;
    map['adminId']=adminId;


    return map;
  }
}
