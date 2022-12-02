class RolePermissionModel{
  String id;
  String name;
  List permission=[];
  String description;

  RolePermissionModel();

  RolePermissionModel.fromJSON(Map<String,dynamic> jsonMap){
    id=jsonMap['id'];
    name=jsonMap['name'];
    permission=jsonMap['permission'];
    description=jsonMap['description'];
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
    map['name']=name;
    map['permission']=permission;
    map['description']=description;
    return map;
  }
}