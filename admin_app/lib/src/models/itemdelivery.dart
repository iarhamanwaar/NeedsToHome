class ItemDeliveryModel {
  String pickupAddress;
  String deliveryAddress;
  String item;
  String notes;
  String totalKm;
  String driverFees;
  String commission;
  String totalAmount;
  String date;
  String status;
  String userId;
  String userName;
  String driverId;
  String driverName;

  ItemDeliveryModel();

  ItemDeliveryModel.fromJson(Map<String, dynamic> jsonMap){
    pickupAddress = jsonMap['pickupAddress'];
    deliveryAddress = jsonMap['deliveryAddress'];
    item = jsonMap['item'];
    notes = jsonMap['notes'];
    totalKm = jsonMap['totalKm'];
    driverFees = jsonMap['driverFees'];
    commission = jsonMap['commission'];
    totalAmount = jsonMap['totalAmount'];
    date = jsonMap['date'];
    status = jsonMap['status'];
    userId = jsonMap['userId'];
    userName = jsonMap['userName'];
    driverId = jsonMap['driverId'];
    driverName = jsonMap['driverName'];
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['pickupAddress'] = pickupAddress;
    map['deliveryAddress'] = deliveryAddress;
    map['item'] = item;
    map['notes'] = notes;
    map['totalKm'] = totalKm;
    map['driverFees'] = driverFees;
    map['commission'] = commission;
    map['totalAmount'] = totalAmount;
    map['date'] = date;
    map['status'] = status;
    map['userId'] = userId;
    map['userName'] = userName;
    map['driverId'] = driverId;
    map['driverName'] = driverName;
    return map;
  }

}