class TaxModel{
  String id;
  String tax;
  String date;

  TaxModel();

  TaxModel.fromJSON(Map<String,dynamic> jsonMap){
    id=jsonMap['id'];
    tax=jsonMap['tax'];
    date=jsonMap['date'];

  }
}