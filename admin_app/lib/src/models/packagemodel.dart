class PackageModel{
  String id;
  String name;
  String status;
  String date;
  var image;

  PackageModel();
  PackageModel.fromJSON(Map<String,dynamic> jsonMap){
    id=jsonMap['id'];
    name=jsonMap['name'];
    status=jsonMap['status'];
    date=jsonMap['date'];
    image=jsonMap['image'];
  }
  Map toMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['name']=name;
    map['status']=status;
    map['date']=date;
    map['image']=image;
    return map;
  }
}