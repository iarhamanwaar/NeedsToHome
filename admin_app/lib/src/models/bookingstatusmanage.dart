class BookingStatusManage{
  String status;
  String time;

  BookingStatusManage();
  BookingStatusManage.fromJSON(Map<String, dynamic> jsonMap){
    try{
      status=jsonMap['status'];
      time=jsonMap['time'].toString();

    }
    catch(e){
      status='';
      time='';
    }
  }
  Map toMap(){
    Map map=new Map<String, dynamic>();
    map['status']=status;
    map['time']=time;
    return map;
  }
}