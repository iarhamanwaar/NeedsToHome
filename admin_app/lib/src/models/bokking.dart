class Booking{
  String bookingId;
  String userId;
  String providerId;
  String detail;
  String phone;
  String date;
  String status;
  String bookId;
  String statusManage;
  String totalAmount;
  String commissionAmount;
  String commissionStatus;
  String payment;
  String transactionId;
  String categoryId;

Booking();
Booking.fromJSON(Map<String,dynamic> jsonMap){
  bookingId=jsonMap['bookingId'];
  userId=jsonMap['userId'];
  providerId=jsonMap['providerId'];
  detail=jsonMap['detail'];
  phone=jsonMap['phone'];
  date=jsonMap['date'];
  status=jsonMap['status'];
  bookId=jsonMap['bookId'];
  statusManage=jsonMap['statusManage'];
  totalAmount=jsonMap['totalAmount'];
  commissionAmount=jsonMap['commissionAmount'];
  commissionStatus=jsonMap['commissionStatus'];
  payment=jsonMap['payment'];
  transactionId=jsonMap['transactionId'];
  categoryId=jsonMap['categoryId'];
}
}