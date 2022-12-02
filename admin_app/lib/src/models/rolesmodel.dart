class RolesModel{
  String id;
  String name;
  String codename;
  String parentStatus;
  String description;
  bool switchPermission = false;

  RolesModel();
  RolesModel.fromJson(Map<String,dynamic> jsonMap){
    id=jsonMap['id'];
    name=jsonMap['name'];
    codename=jsonMap['codename'];
    parentStatus=jsonMap['parentStatus'];
    description=jsonMap['description'];

  }
}