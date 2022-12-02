import '../helpers/custom_trace.dart';

class Address {
  String id;
  String addressSelect;
  double latitude;
  double longitude;
  String isDefault;
  String username;
  String phone;
  String userId;

  Address();

  Address.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      addressSelect = jsonMap['addressSelect'];
      latitude = jsonMap['latitude'];
      longitude = jsonMap['longitude'];
      isDefault = jsonMap['is_default'];
      username = jsonMap['username'];
      phone = jsonMap['phone'];
      userId = jsonMap['userId'];
    } catch (e) {
      id = '';
      addressSelect = '';
      latitude = 0;
      longitude = 0;
      isDefault = '';
      username = '';
      phone = '';
      userId = '';
      print('error address');
      print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["addressSelect"] = addressSelect;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["isDefault"] = isDefault;
    map["username"] = username;
    map["phone"] = phone;
    map["userId"] = userId;
    return map;
  }
}
