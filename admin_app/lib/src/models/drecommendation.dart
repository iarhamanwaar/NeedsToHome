class DRecommendation{
  String id;
  String superId,shopTypeId,focusTypeId,sortBy;

  DRecommendation();
  DRecommendation.fromJSON(Map<String,dynamic> jsonMap){
    try{
      id=jsonMap['id']!=null?jsonMap['id']:'';
      superId=jsonMap['superId']!=null?jsonMap['superId']:'';
      shopTypeId=jsonMap['shopTypeId']!=null?jsonMap['shopTypeId']:'';
      focusTypeId=jsonMap['focusTypeId']!=null?jsonMap['focusTypeId']:'';
      sortBy=jsonMap['sortBy']!=null?jsonMap['sortBy']:'';
    }
    catch(e){
      id='';
      superId='';
      shopTypeId='';
      focusTypeId='';
      sortBy='';
    }

  }
}