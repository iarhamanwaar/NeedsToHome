class VendorWallet{

  String id,
  vendorId,
  amount,status,notes,reqDate,
  processDate;

  VendorWallet();
  VendorWallet.fromJSON(Map<String,dynamic> jsonMap){
    try{
      vendorId=jsonMap['vendorId']!=null?jsonMap['vendorId']:'';
      id=jsonMap['id'] !=null?jsonMap['id']:'';
      amount=jsonMap['amount']!=null?jsonMap['amount']:'';
      status=jsonMap['status']!=null?jsonMap['status']:'';
      notes=jsonMap['notes']!=null?jsonMap['notes']:'';
      reqDate=jsonMap['reqDate']!=null?jsonMap['reqDate']:'';
      processDate=jsonMap['processDate']!=null?jsonMap['processDate']:'';
    }
    catch(e){
      vendorId='';
      id='';
      amount='';
      status='';
      notes='';
      print(e);
    }

  }
}