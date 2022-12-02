class BookingDetails{
  String userid;
  String providerId;
  String categoryId;
  String categoryName;
  String subcategoryId;
  String subcategoryName;
  String longitude;
  String latitude;
  String time;
  String date;
  String address;
  String description;
  String service;
  String chargePerHrs;
  String bookingTime;
  var subcategoryImg;
  String providerName;
  String providerMobile;
  var providerImage;
  String status;
  String username;
  String bookId;
  String userRatingStatus;
  String providerRatingStatus;
  String userMobile;
  String popStatus;

  BookingDetails();

  BookingDetails.fromJSON(Map<String, dynamic> jsonMap) {
    try{
      userid=jsonMap['userid'];
      providerId=jsonMap['providerId'];
      categoryId=jsonMap['categoryId'];
      categoryName=jsonMap['categoryName'];
      subcategoryId=jsonMap['subcategoryId'];
      subcategoryName=jsonMap['subcategoryName'];
      longitude=jsonMap['longitude'].toString();
      latitude=jsonMap['latitude'].toString();
      time=jsonMap['time'];
      date=jsonMap['date'];
      address=jsonMap['address'];
      description=jsonMap['description'];
      service=jsonMap['service'];
      chargePerHrs=jsonMap['chargeperhrs'];
      bookingTime=jsonMap['bookingTime'].toString();
      subcategoryImg=jsonMap['subcategoryImg'];
      providerName=jsonMap['providerName'];
      providerMobile=jsonMap['providerMobile'];
      providerImage=jsonMap['providerImage'];
      status=jsonMap['status'];
      username=jsonMap['username'];
      bookId=jsonMap['bookId'];
      userRatingStatus=jsonMap['userRatingStatus'];
      providerRatingStatus=jsonMap['providerRatingStatus'];
      userMobile=jsonMap['userMobile'];
      popStatus=jsonMap['popStatus'];
    }
    catch(e){
      print(e);
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map[userid]=userid;
    map[providerId]=providerId;
    map[categoryId]=categoryId;
    map[categoryName]=categoryName;
    map[subcategoryId]=subcategoryId;
    map[subcategoryName]=subcategoryName;
    map[longitude]=longitude;
    map[latitude]=latitude;
    map[time]=time;
    map[date]=date;
    map[address]=address;
    map[description]=description;
    map[service]=service;
    map[chargePerHrs]=chargePerHrs;
    map[subcategoryImg]=subcategoryImg;
    map[providerName]=providerName;
    map[providerMobile]=providerMobile;
    map[providerImage]=providerImage;
    map[status]=status;
    map[providerImage]=providerImage;
    map[providerImage]=providerImage;
    map[providerImage]=providerImage;
    map[providerImage]=providerImage;
    return map;
  }

}