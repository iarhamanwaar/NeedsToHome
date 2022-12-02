class DeliverySettingsModel{





  bool autoAssign;
  bool allowAllDeliveryBoys;
  bool instantDelivery;
  bool takeaway;
  bool scheduleDelivery;

  DeliverySettingsModel();
  DeliverySettingsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      autoAssign=jsonMap['autoAssign']!=null?jsonMap['autoAssign']:false;
      allowAllDeliveryBoys=jsonMap['allowAllDeliveryBoys']!=null?jsonMap['allowAllDeliveryBoys']:false;
      instantDelivery=jsonMap['instantDelivery']!=null?jsonMap['instantDelivery']:false;
      takeaway=jsonMap['takeaway']!=null?jsonMap['takeaway']:false;
      scheduleDelivery=jsonMap['scheduleDelivery']!=null?jsonMap['scheduleDelivery']:false;
    }
    catch(e){
      print(e);
    }
  }
  Map toMap(){
    var map=Map<String, dynamic>();
    map['autoAssign']=autoAssign;
    map['allowAllDeliveryBoys']=allowAllDeliveryBoys;
    map['instantDelivery']=instantDelivery;
    map['takeaway']=takeaway;
    map['scheduleDelivery']=scheduleDelivery;
    return map;
  }
}