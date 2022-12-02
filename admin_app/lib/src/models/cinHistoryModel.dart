class CinHistoryModel{
  String id;
  String driverId;
  String driverName;
  String cashCollected;
  String collectedTime;
  String type;

  CinHistoryModel();

  CinHistoryModel.fromJson(Map<String,dynamic> jsonMap){

    id=jsonMap['id'];
    driverId=jsonMap['driverId'];
    driverName=jsonMap['driverName'];
    cashCollected=jsonMap['cashCollected'];
    collectedTime=jsonMap['collectedTime'];
    type=jsonMap['type'];
  }
}