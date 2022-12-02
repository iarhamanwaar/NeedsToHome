import 'package:login_and_signup_web/src/models/bookingdetails.dart';
import 'package:login_and_signup_web/src/models/bookingstatusmanage.dart';

class ProviderBooking{
  String bookingId;
  String userId;
  String userName;
  String providerId;
  String providerName;
  String type;
  List<BookingDetails> bookingDetails=<BookingDetails>[];
  String phone;
  String date;
  String status;
  String bookId;
  List<BookingStatusManage> bookingStatusManage=<BookingStatusManage>[];
  String totalAmount;
  String commissionAmount;
  String commissionStatus;
  String payment;
  String transactionId;
  String categoryId;
  String settlementValue;
  String taxAmount;

  ProviderBooking();

  ProviderBooking.fromJSON(Map<String, dynamic> jsonMap){
    try{
      bookingId=jsonMap['bookingId'];
      userId=jsonMap['userId'];
      userName=jsonMap['userName'];
      providerId=jsonMap['providerId'];
      type=jsonMap['type']!=null?jsonMap['type']:'';
      providerName=jsonMap['providerName'];
      bookingDetails = jsonMap['detail'] != null ? List.from(jsonMap['detail']).map((element) => BookingDetails.fromJSON(element)).toList() : [];
      phone=jsonMap['phone'];
      date=jsonMap['date'].toString();
      status=jsonMap['status'];
      bookId=jsonMap['bookId'];
      bookingStatusManage = jsonMap['statusManage'] != null ? List.from(jsonMap['statusManage']).map((element) => BookingStatusManage.fromJSON(element)).toList() : [];
      totalAmount=jsonMap['totalAmount']!=null?jsonMap['totalAmount']:'';
      commissionAmount=jsonMap['commissionAmount'];
      commissionStatus=jsonMap['commissionStatus'];
      payment=jsonMap['payment'];
      transactionId=jsonMap['transactionId'];
      categoryId=jsonMap['categoryId'];
      taxAmount=jsonMap['taxAmount'];
      settlementValue=jsonMap['settlementValue']??'0';
    }
    catch(e){

    }
  }
}