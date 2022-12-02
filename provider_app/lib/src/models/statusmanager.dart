import '../helpers/custom_trace.dart';

class StatusManager {
  bool serviceBooked;
  String serviceBookedTime;
  bool serviceAccepted;
  String serviceAcceptedTime;
  bool startedCustomerPlaced;
  String startedCustomerPlacedTime;
  bool providerArrived;
  String providerArrivedTime;
  bool jobStarted;
  String jobStartedTime;
  bool jobCompleted;
  String jobCompletedTime;

  StatusManager();

  StatusManager.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      serviceBooked = jsonMap['serviceBooked'];
      serviceBookedTime = jsonMap['serviceBookedTime'];
      serviceAccepted = jsonMap['serviceAccepted'];
      serviceAcceptedTime = jsonMap['serviceAcceptedTime'];
      startedCustomerPlaced = jsonMap['startedCustomerPlaced'];
      startedCustomerPlacedTime = jsonMap['startedCustomerPlacedTime'];
      providerArrived = jsonMap['providerArrived'];
      providerArrivedTime = jsonMap['providerArrivedTime'];
      jobStarted = jsonMap['jobStarted'];
      jobStartedTime = jsonMap['jobStartedTime'];
      jobCompleted = jsonMap['jobCompleted'];
      jobCompletedTime = jsonMap['jobCompletedTime'];
    } catch (e) {
      serviceBooked = false;
      serviceBookedTime = '';
      serviceAccepted = false;
      serviceAcceptedTime = '';
      startedCustomerPlaced = false;
      startedCustomerPlacedTime = '';
      providerArrived = false;
      providerArrivedTime = '';
      jobStarted = false;
      jobStartedTime = '';
      jobCompleted = false;
      jobCompletedTime = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["serviceBooked"] = serviceBooked;
    map["serviceBookedTime"] = serviceBookedTime;
    map["serviceAccepted"] = serviceAccepted;
    map["serviceAcceptedTime"] = serviceAcceptedTime;
    map["startedCustomerPlaced"] = startedCustomerPlaced;
    map["startedCustomerPlacedTime"] = startedCustomerPlacedTime;
    map["providerArrived"] = providerArrived;
    map["providerArrivedTime"] = providerArrivedTime;
    map["jobStarted"] = jobStarted;
    map["jobStartedTime"] = jobStartedTime;
    map["jobCompleted"] = jobCompleted;
    map["jobCompletedTime"] = jobCompletedTime;
    return map;
  }

}
