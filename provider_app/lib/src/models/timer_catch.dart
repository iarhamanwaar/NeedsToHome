class TimerCatch {
  int takenTime;
  String takenhrs;

  TimerCatch();

  TimerCatch.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      takenTime = jsonMap['takenTime'];
      takenhrs = jsonMap['takenhrs'] != null ? jsonMap['takenhrs'] : '';
    } catch (e) {
      takenTime = 0;
      takenhrs = '';

      print(e);
    }
  }
}
