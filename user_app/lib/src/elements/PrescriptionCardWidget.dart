import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/vendor.dart';
import 'package:multisuperstore/src/pages/upload_prescription.dart';

import '../repository/user_repository.dart';
// ignore: must_be_immutable
class PrescriptionCardWidgets extends StatefulWidget {
  Vendor shopDetails;
  int shopTypeID;
  int focusId;
  PrescriptionCardWidgets({Key key, this.shopDetails, this.shopTypeID,this.focusId}) : super(key: key);

  @override
  _PrescriptionCardWidgetsState createState() => _PrescriptionCardWidgetsState();
}

class _PrescriptionCardWidgetsState extends State<PrescriptionCardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(bottom:15),
      child:Column(
          children:[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:Container(
                  width:double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(top:10),
                  decoration: BoxDecoration(
                    color: Color(0xffd2f0e8),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).disabledColor.withOpacity(0.05),
                          blurRadius: 1
                      )
                    ],
                    /*image: DecorationImage(image: AssetImage('assets/img/login-bg4.jpg'),
                                                fit: BoxFit.fill
                                            )*/
                  ),
                  child:Column(
                      children:[
                        Row(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left:15,right:15),
                                      child:Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text('Order with prescription',
                                            style: Theme.of(context).textTheme.subtitle1,
                                          ),
                                          Text('Upload your prescription & we do the rest',
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ],
                                      ),
                                    ),

                                    MaterialButton(
                                      onPressed:(){
                                        if (currentUser.value.apiToken != null) {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                              UploadPrescription(shopTypeID: widget.shopTypeID,shopDetails:widget.shopDetails,focusId:widget.focusId)));
                                        } else {
                                          Navigator.of(context).pushNamed('/Login');
                                        }

                                      },
                                      color:Colors.transparent,
                                        elevation: 0,
                                        highlightColor: Colors.transparent,
                                        highlightElevation: 0,
                                        child: Text('Upload now',
                                        style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Colors.green,fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                         Container(
                           padding: EdgeInsets.only(left:10,right:10),
                           child:Image.asset('assets/img/bookmark.png',
                           height: 70,
                           )
                         ),

                          ],
                        )
                      ]
                  )

              ),),



          ]
      ),
    );
  }
}
