class VersionControl{

  String versionControlId;
  String app;
  String appName;
  String version;
  String appLink;
  String status;





  VersionControl();

  VersionControl.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      versionControlId = jsonMap['versionControlId'] != null ? jsonMap['versionControlId'] : '';
      app = jsonMap['app'] != null ? jsonMap['app'] : '';
      appName = jsonMap['appName'] != null ? jsonMap['appName'] : '';
      version = jsonMap['version'] != null ? jsonMap['version']: '';
      appLink = jsonMap['appLink']!= null ? jsonMap['appLink'] : '';
      status = jsonMap['status'] != null ? jsonMap['status'] : '';


    } catch (e) {

      print(e);
    }
  }




}