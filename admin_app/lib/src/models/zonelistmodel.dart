import '../helpers/custom_trace.dart';

class ZoneListModel {
  String zoneId;
  String title;
  List position = [];


  ZoneListModel();

  ZoneListModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      zoneId = jsonMap['zoneId']!= null ? jsonMap['zoneId'] : '';
      title = jsonMap['title']!= null ? jsonMap['title'] : '';
      position = jsonMap['position'];

    } catch (e) {
      zoneId = '';
      title = '';
      title = '';
      print(CustomTrace(StackTrace.current, message: e));
    }
  }



}
