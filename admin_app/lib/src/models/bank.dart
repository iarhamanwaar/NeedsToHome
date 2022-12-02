
class Bank {
  String id;
  String personalProof;
  String selectedYear;
  String businessType;
  String holdersName;
  String accountNumber;
  String bankCode;
  String branch;
  String bankName;
  String proofType;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  Bank();

  Bank.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id=jsonMap['id'];
      personalProof=jsonMap['personalProof'];
      selectedYear=jsonMap['selectedYear'] != null ? jsonMap['selectedYear'] : '';
      businessType=jsonMap['businessType'] != null ? jsonMap['businessType'] : '';
      holdersName = jsonMap['holdersName']  != null ? jsonMap['holdersName'] : '';
      accountNumber = jsonMap['accountNumber'] != null ? jsonMap['accountNumber'] : '';
      bankCode  = jsonMap['bankCode'] != null ? jsonMap['bankCode'] : '';
      branch  = jsonMap['branch'] != null ? jsonMap['branch'] : '';
      bankName  = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';
      proofType  = jsonMap['proofType'] != null ? jsonMap['proofType'] : '';

    } catch (e) {

      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    id='';
    personalProof='';
    selectedYear='';
    businessType='';
    holdersName = '';
    accountNumber = '';
    bankCode= '';
    branch= '';
    bankName= '';
    proofType = '';

    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
