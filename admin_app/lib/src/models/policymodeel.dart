class PolicyModel{
  String id;
  String policy;
  String value;

  PolicyModel();
  PolicyModel.fromJSON(Map<String,dynamic> jsonMap){
    id=jsonMap['id'];
    policy=jsonMap['policy'];
    value=jsonMap['value'];
  }
  Map toMap(){
    var map=Map<String,dynamic>();
    map['id']=id;
    map['policy']=policy;
    map['value']=value;
    return map;
  }
}