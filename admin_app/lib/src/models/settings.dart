
import 'package:login_and_signup_web/src/models/admin_general.dart';

import 'package:login_and_signup_web/src/models/smtp_model.dart';

import 'admin_payment.dart';
import 'delivery_setting.dart';

class SettingsModel {
  AdminGeneral general;
  AdminPayment payment;
  DeliverySettingsModel delivery;
  Smtp  smtp;




  // used for indicate if client logged in or not
  bool auth;

//  String role;

  SettingsModel();

  SettingsModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      general =  jsonMap['general'] != null ? AdminGeneral.fromJSON(jsonMap['general']) : AdminGeneral.fromJSON({});
      payment =  jsonMap['payment'] != null ? AdminPayment.fromJSON(jsonMap['payment']) : AdminPayment.fromJSON({});
      delivery =  jsonMap['delivery'] != null ? DeliverySettingsModel.fromJSON(jsonMap['delivery']) : DeliverySettingsModel.fromJSON({});
      smtp =  jsonMap['smtp'] != null ? Smtp.fromJSON(jsonMap['smtp']) : Smtp.fromJSON({});

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["general"] = general;
    map["payment"] = payment;
    map["driver"] = delivery;
    map["smtp"] = smtp;




    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
