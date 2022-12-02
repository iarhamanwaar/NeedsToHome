class ZoneModel{
  String id;
  String title;
  String position;
  bool status;
  String date;
  int drivers;
  int provider;
  int shop;

  ZoneModel();
  ZoneModel.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id'] !=null?jsonMap['id']:'';
      title=jsonMap['title']!=null?jsonMap['title']:'';
      status=jsonMap['status']!=null?jsonMap['status']:'';
      position=jsonMap['position']!=null?jsonMap['position']:'';
      date=jsonMap['date']!=null?jsonMap['date']:'';
      drivers=jsonMap['drivers']!=null?jsonMap['drivers']:'';
      shop=jsonMap['shop']!=null?jsonMap['shop']:'';
      provider=jsonMap['provider']!=null?jsonMap['provider']:'';
    }
    catch(e){
      print(e);
    }
  }
}