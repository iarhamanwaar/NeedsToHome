import '../helpers/custom_trace.dart';

class ProviderServiceDataModel {
  String categoryName;
  String subcategoryName;
  String experience;
  String type;
  String chargePreHrs;
  String quickPitch;
  String id;

  ProviderServiceDataModel();

  ProviderServiceDataModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      categoryName = jsonMap['categoryName'];
      subcategoryName = jsonMap['subcategoryName'];
      experience = jsonMap['experience'];

      type = jsonMap['type'];

      chargePreHrs = jsonMap['chargePreHrs'];
      quickPitch = jsonMap['quickPitch'];
      id = jsonMap['id'];
    } catch (e) {

      print(CustomTrace(StackTrace.current, message: e));
    }
  }


}
