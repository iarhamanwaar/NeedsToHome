class SocialMediaLink{
  String faceBook;
  String whatsApp;
  String twitter;
  String instagram;

  SocialMediaLink();
  SocialMediaLink.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      faceBook=jsonMap['faceBook']!=null?jsonMap['faceBook']:'';
      whatsApp=jsonMap['whatsApp']!=null?jsonMap['whatsApp']:'';
      twitter=jsonMap['twitter']!=null?jsonMap['twitter']:'';
      instagram=jsonMap['instagram']!=null?jsonMap['instagram']:'';
    }
    catch(e){
      print(e);
    }
  }
  Map toMap(){
    var map=Map<String, dynamic>();
    map['faceBook']=faceBook;
    map['whatsApp']=whatsApp;
    map['twitter']=twitter;
    map['instagram']=instagram;
    return map;
  }
}