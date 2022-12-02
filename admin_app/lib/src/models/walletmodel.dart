class WalletModel{
  String totalEarn;
  double totalWalletBalance = 0;
  double requestedAmount = 0;
  int requestedCount =0;
  double cashCollectAmount = 0;
  int cashCollectCount =0;
  int totalWithdraw = 0;
  double totalWithdrawAmount = 0;
  int totalOrderCount =0;
  double totalOrderAmount = 0;
  String bankAccountNumber;
  String bankName;

  WalletModel();
  WalletModel.fromJSON(Map<String,dynamic> jsonMap){
    try {
      totalEarn = jsonMap['totalEarn'] != null ? jsonMap['totalEarn'] : '';
      totalWalletBalance = jsonMap['totalWalletBalance'] != null
          ? jsonMap['totalWalletBalance'].toDouble()
          : 0;
      requestedAmount =
      jsonMap['requestedAmount'] != null ? jsonMap['requestedAmount'].toDouble()  : 0;
      requestedCount =
      jsonMap['requestedCount'] != null ? jsonMap['requestedCount'] : 0;

      cashCollectCount =
      jsonMap['cashCollectCount'] != null ? jsonMap['cashCollectCount'] : 0;
      totalWithdraw =
      jsonMap['totalWithdraw'] != null ? jsonMap['totalWithdraw'] : 0;
      totalWithdrawAmount =
      jsonMap['totalWithdrawAmount'] != null ? jsonMap['totalWithdrawAmount'].toDouble() : 0;
      totalOrderCount =
      jsonMap['totalOrderCount'] != null ? jsonMap['totalOrderCount'] : 0;
      totalOrderAmount =
      jsonMap['totalOrderAmount'] != null ? jsonMap['totalOrderAmount'].toDouble() : 0;
      bankAccountNumber =
      jsonMap['bankAccountNumber'] != null ? jsonMap['bankAccountNumber'] : '';
      bankName = jsonMap['bankName'] != null ? jsonMap['bankName'] : '';

    } catch(e){
      print(e);
    }
  }

  Map toMap(){
    var map=Map<String,dynamic>();
    map['totalEarn']=totalEarn;
    map['totalWalletBalance']=totalWalletBalance;
    map['requestedAmount']=requestedAmount;
    map['requestedCount']=requestedCount;
    map['cashCollectAmount']=cashCollectAmount;
    map['cashCollectCount']=cashCollectCount;
    map['totalWithdraw']=totalWithdraw;
    map['totalWithdrawAmount']=totalWithdrawAmount;

    return map;
  }
}