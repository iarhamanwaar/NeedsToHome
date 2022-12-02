class SocialMediaLink{
  String faceBook;
  String whatsApp;
  String twitter;
  String instagram;

  SocialMediaLink();
  SocialMediaLink.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      faceBook=jsonMap['faceBook'];
      whatsApp=jsonMap['whatsApp'];
      twitter=jsonMap['twitter'];
      instagram=jsonMap['instagram'];
    }
    catch(e){
      faceBook='';
      whatsApp='';
      twitter='';
      instagram='';
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