import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/product_controller.dart';
import 'package:multisuperstore/src/elements/ClearCartWidget.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';



// ignore: must_be_immutable
class UploadPrescription extends StatefulWidget {
  Vendor shopDetails;
  int shopTypeID;
  int focusId;
  UploadPrescription({Key key, this.shopDetails, this.shopTypeID,this.focusId}) : super(key: key);
  @override
  _UploadPrescriptionState createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends StateMVC<UploadPrescription> {

  ProductController _con;
  bool loader = false;

  _UploadPrescriptionState() : super(ProductController()) {
    _con = controller;

  }


  @override
  Widget build(BuildContext context) {
    var redColor = Colors.red;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios,color:Theme.of(context).backgroundColor),
            ),
          title: Text(S.of(context).upload_prescription,style: Theme.of(context).textTheme.headline1),

           ),
        body: Container(
          color:Theme.of(context).dividerColor,
          child:Container(
            child:Column(
              children: [
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
                    padding: EdgeInsets.only(top:10,left:10,right:10,bottom:10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      color: Theme.of(context).primaryColor
                    ),
                    child:SingleChildScrollView(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(S.of(context).have_a_prescription_upload_here,style: Theme.of(context).textTheme.headline1),
                          InkWell(
                              onTap: () {},
                              child: Container(
                                margin: EdgeInsets.only(top:20,bottom:20),
                                padding: EdgeInsets.all(8),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Wrap(
                                  children: [
                                    Div(
                                      colS:4,
                                      colM:4,
                                      colL:4,
                                      child: GestureDetector(
                                        onTap: () {
                                          getImage();
                                        },
                                        child:Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            right:BorderSide(
                                              width:1,
                                                color: Theme.of(context).colorScheme.primary
                                            )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt,color:Theme.of(context).colorScheme.primary,),
                                            SizedBox(height:5),
                                            Text(S.of(context).camera,style:TextStyle(color:Theme.of(context).colorScheme.primary)),

                                          ],
                                        )
                                      ),
                                      ),
                                    ),

                                    Div(
                                      colS:4,
                                      colM:4,
                                      colL:4,
                                      child: GestureDetector(
                                        onTap: () {
                                          getImagegaller();
                                        },
                                        child:Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right:BorderSide(
                                                      width:1,
                                                      color: Theme.of(context).colorScheme.primary
                                                  )
                                              )
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.image,color: Theme.of(context).colorScheme.primary,),
                                              SizedBox(height:5),
                                              Text(S.of(context).gallery,style:TextStyle(color: Theme.of(context).colorScheme.primary)),
                                            ],
                                          )
                                      ),
                                      ),
                                    ),
                                    Div(
                                      colS:4,
                                      colM:4,
                                      colL:4,
                                      child: GestureDetector(
                                          onTap: () {
                                            PrescriptionGuidePopupHelper.exit(context);
                                          },
                                          child:Container(

                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.description,color: Theme.of(context).colorScheme.primary,),
                                              SizedBox(height:5),
                                              Text(S.of(context).instruction,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style:TextStyle(color:Theme.of(context).colorScheme.primary)),

                                            ],
                                          ),
                                          ),
                                      ),
                                    ),



                                  ],
                                ),

                              )),

                          Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 7, right: 10),
                                    child: Icon(Icons.security,size:50, color: Theme.of(context).disabledColor),
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Text(S.of(context).your_attaches_prescription_will_be_secure_and_private_only_our_pharmacist_will_review_it, style: Theme.of(context).textTheme.subtitle2)),
                                  )
                                ],
                              )),
                          SizedBox(height:20),
                          Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top:3, right: 10),
                                    child: Icon(Icons.report, color:redColor),
                                  ),
                                  Expanded(
                                    child:InkWell(
                                      onTap: (){

                                      },
                                      child: Container(
                                          child: Text(
                                              S.of(context).valid_prescription_guide, style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:redColor))
                                          )
                                      ),
                                    )

                                  )
                                ],
                              )),
                          SizedBox(height:3),
                          Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child:Container(
                                        child: Text(
                                            S.of(context).why_upload_a_prescription, style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:redColor))
                                        )),),


                                ],
                              )),
                          SizedBox(height:10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image == null?  Image(image:AssetImage(
                                'assets/img/prescription.jpg',
                              ),
                                width: 150,
                                height: 250,
                                fit: BoxFit.fitHeight,
                              ): Image.file(_image,width: 350,
                                height: 250,
                                fit: BoxFit.fitHeight,),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 7, right: 10),
                                          child: Icon(Icons.mobile_screen_share, color: Theme.of(context).disabledColor),
                                        ),
                                        Expanded(
                                          child: Container(
                                              child: Text(S.of(context).never_lose_the_digital_copy_of_your_prescription_it_will_be_with_you_wherever_you_go, style: Theme.of(context).textTheme.subtitle2)),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 17),
                                Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 7, right:10),
                                          child: Icon(Icons.description, color: Theme.of(context).disabledColor),
                                        ),

                                        Expanded(
                                          child: Container(
                                              child: Text(S.of(context).its_your_prescription_hart_to_understand_1mg_pharmacist_will_help_you_in_placing_order,
                                                  style: Theme.of(context).textTheme.subtitle2)),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 17),
                                Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 7, right: 10),
                                          child: Icon(Icons.lock_outline, color: Theme.of(context).disabledColor),
                                        ),
                                        Expanded(
                                          child: Container(
                                              padding: EdgeInsets.only(top: 7),
                                              child: Text(S.of(context).details_from_your_prescription_are_not_shared_with_any_third_party,
                                                  style: Theme.of(context).textTheme.subtitle2)),
                                        ),

                                      ],
                                    )),
                                SizedBox(height: 17),
                                Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 7, right: 10),
                                          child: Icon(Icons.build, color: Theme.of(context).disabledColor),
                                        ),
                                        Expanded(
                                          child: Container(
                                              child: Text(S.of(context).government_regulation_require_a_prescription_for_ordering_some_medicines, style: Theme.of(context).textTheme.subtitle2)),
                                        )
                                      ],
                                    )),
                                SizedBox(height: 10),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child:
                    InkWell(
                        onTap: () {},
                        child: Container(
                          padding:EdgeInsets.only(left:10,right:10,bottom:20,),
                          child:Column(
                            children: [

                              Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                  /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                ),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  onPressed: () {

                                    _con.prescriptionCart(widget.shopDetails.shopId,widget.shopDetails.shopName,widget.shopTypeID,widget.shopDetails.subtitle,widget.shopDetails.latitude,widget.shopDetails.longitude,widget.focusId,ClearCartShow);
                                  },
                                  child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'CONTINUE',
                                              style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                          ),
                                          Icon(Icons.arrow_forward,color:Theme.of(context).primaryColorLight)
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),

                        ))
                )
              ],
            ),


          ),

             ));
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        currentCheckout.value.uploadImage = _image;

      } else {
        print('No image selected.');
      }
    });
  }

  Future getImagegaller() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        currentCheckout.value.uploadImage = _image;
       // register(_image);

      } else {
        print('No image selected.');
      }
    });
  }

  // ignore: non_constant_identifier_names
  void ClearCartShow() {
    var size = MediaQuery.of(context)
        .size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: size.height * 0.3,
            color: Color(0xff737373),
            child: Container(

              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClearCart(),
                            ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left:size.width * 0.05,right:size.width * 0.05,top: 5, bottom: 5),
                      child:Row(
                        children: [
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.grey[200],
                                    width:1
                                )
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).cancel,
                                    style:Theme.of(context).textTheme.subtitle1
                                  )),
                            ),
                          ),
                          SizedBox(width:size.width * 0.02),
                          Container(
                            width: size.width * 0.44,
                            height: 45.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30),
                              /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                            ),
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              onPressed: () {

                                _con.clearCart();
                              },
                              child: Center(
                                  child: Text(
                                    S.of(context).clear_cart,
                                    style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                                  )),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

}

class PrescriptionGuidePopupHelper {

  static exit(context) => showDialog(context: context, builder: (context) =>  PrescriptionGuidePopup());
}

class PrescriptionGuidePopup extends StatefulWidget{
  @override
  _PrescriptionGuidePopupState createState() => _PrescriptionGuidePopupState();
}

class _PrescriptionGuidePopupState extends State<PrescriptionGuidePopup> {
  @override
  Widget build(BuildContext context) {
  var size =MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
      insetPadding: EdgeInsets.only(top:size.height * 0.09,
        left:size.width * 0.09,
        right:size.width * 0.09,
        bottom:size.width * 0.09,
      ),
    );
  }

  _buildChild
      (BuildContext context) => SingleChildScrollView(
    child:Container(

      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),

      child: Column(

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:10,left:18,right:10),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Expanded(
                  child:Container(
                    padding: EdgeInsets.only(right:10),
                    child:Text(S.of(context).valid_prescription_guide,
                        style: Theme.of(context).textTheme.headline1
                    ),
                  )),
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close,color:Theme.of(context).disabledColor),
                )
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10,right: 18, left:18),
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children:[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image:AssetImage(
                        'assets/img/prescription.jpg',
                      ),
                        width: 150,
                        height: 250,
                        fit: BoxFit.fitHeight,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:20,left:20,right:20),
                    child: Text(S.of(context).include_detail_of_doctor_and_patient_clinic_visit_details, style: Theme.of(context).textTheme.subtitle2),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:20,left:20,right:20),
                    child: Text(S.of(context).medicines_will_be_dispensed_as_per_prescription, style: Theme.of(context).textTheme.subtitle2),
                  ),







                  SizedBox(height:30),
                ]
            ),

          ),


        ],
      ),
    ),
  );



}
