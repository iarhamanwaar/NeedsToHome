import 'package:login_and_signup_web/src/helpers/custom_trace.dart';

class ShopTiming{
  String id;
  String openingTime;
  String closingTime;
  String holidays;

  ShopTiming();
  ShopTiming.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'];
      openingTime=jsonMap['openingTime'] != null ? jsonMap['openingTime'] : '';
      openingTime=jsonMap['closingTime'] != null ? jsonMap['closingTime'] : '';
      holidays=jsonMap['holidays'];
    }
    catch(e){
      id='';
      openingTime='';
      openingTime='';
      holidays='';
      print(CustomTrace(StackTrace.current,message: e));
    }
  }

  Map toMap(){
    var map=new Map<String,dynamic>();
    map['id']=id;
    map['openingTime']=openingTime;
    map['closingTime']=closingTime;
    map['holidays']=holidays;
    return map;
  }
}