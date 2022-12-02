import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class ShopSettings{
  String id;
  String boostStore;
  String technicalAssistant;
  String conditions;

  ShopSettings();
  ShopSettings.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'];
      boostStore=jsonMap['boostStore'] != null ? jsonMap['boostStore'] : '';
      technicalAssistant=jsonMap['technicalAssistant'] != null ? jsonMap['technicalAssistant'] : '';
      conditions=jsonMap['conditions'] != null ? jsonMap['conditions'] : '';
    }
    catch(e){
      id='';
      boostStore='';
      technicalAssistant='';
      conditions='';
      print(CustomTrace(StackTrace.current,message: e));
    }
  }

  Map toMap(){
    var map=new Map<String,dynamic>();
    map['id']=id;
    map['boostStore']=boostStore;
    map['technicalAssistant']=technicalAssistant;
    map['conditions']=conditions;
    return map;
  }
  @override
  String toString() {
    var map = this.toMap();
    return map.toString();
  }
}