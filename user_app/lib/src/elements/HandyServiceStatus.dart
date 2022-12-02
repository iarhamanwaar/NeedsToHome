import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../helpers/helper.dart';
import '../repository/hservice_repository.dart';
import '../repository/user_repository.dart';
import 'BlockButtonWidget.dart';

class HandyServiceStatus extends StatefulWidget {


  @override
  _HandyServiceStatusState createState() => _HandyServiceStatusState();
}

class _HandyServiceStatusState extends State<HandyServiceStatus> {
  GlobalKey<PageContainerState> key = GlobalKey();
  PageController controller;

  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    controller = PageController();

  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;

    return    currentUser.value.id!=null?StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("HService")
        .where("userid", isEqualTo: currentUser.value.id)
            .where("userRatingStatus", isEqualTo: 'no')
        . snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasError || snapshot.data == null) {
    return Container();
    } else {

      return snapshot.data.docs.length>0 ?Container(
          height:size.height * 0.16,
          child:Container(
              width:double.infinity,
              height:size.height * 0.16,
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
              ),
          child: PageIndicatorContainer(
          key: key,
          align: IndicatorAlign.bottom,
          length: snapshot.data.docs.length,
          indicatorSpace: 15.0,
          shape: IndicatorShape.defaultOval,
          indicatorColor: Colors.white,
          indicatorSelectorColor: Colors.black,
          child:PageView.builder(
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          reverse: false,
          itemBuilder: (context, index) {
            DocumentSnapshot course = snapshot.data.docs[index];

            return course['status']!='rejected'?Container(
              height:size.height * 0.12,
              padding:EdgeInsets.only(bottom:15),
              child:Column(
                  children:[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:Container(

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
                                                  Text('Handy Status: ${course['status']}',
                                                    style: Theme.of(context).textTheme.subtitle1,
                                                  ),
                                                  Text(course['status']=='pending'?
                                                      'Your request is waiting for accept':
                                                       course['status']=='paymentPending'?'Please click & pay your amount':
                                                       course['status']=='Success' && course['userRatingStatus']=='no'?S.of(context).give_your_rating:
                                                       course['status']=='confirmUnSuccess'?S.of(context).waiting_for_payment_confirmation
                                                      :'Provider ${course['providerName']} has ${course['status']} ${S.of(context).successfully}',
                                                    style: Theme.of(context).textTheme.caption,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(left:15,right:15,top:10),
                                                      child:InkWell(
                                                    onTap: (){
                                                      currentBookView.value.providerMobile = course['providerMobile'];
                                                      currentBookView.value.providerId = course['providerId'];
                                                      currentBookView.value.providerName = course['providerName'];
                                                      currentBookView.value.bookId = course['bookId'];
                                                      Navigator.of(context).pushNamed('/H_BookingDetails', arguments: course['bookId']);
                                                    },
                                                    child: Text(S.of(context).view_more,style:TextStyle(color:Colors.red)),
                                                  ))
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(

                                          padding: EdgeInsets.only(left:10,right:10),
                                          child: course['status'] == 'pending'
                                              ?  Image.asset("assets/img/waiting.gif",  height: 40,)
                                              : course['status'] == 'accepted'
                                              ?  Image.asset("assets/img/my_marker.png",   height: 40,)
                                              : course['status'] == 'ontheway'
                                              ?  Image.asset("assets/img/onthway.gif",   height: 40,)
                                              : course['status'] == 'processing'
                                              ?  Image.asset("assets/img/processing.gif",  height: 40,)
                                              : course['status'] == 'processing'
                                              ?  Image.asset("assets/img/processing.gif",   height: 40,)
                                              : course['status'] == 'paymentPending'
                                              ?  InkWell(
                                              onTap: ()=>{_showAlert(context,course['bookId'])},
                                              child: Image.asset("assets/img/paymentwaiting.gif",  height: 40,))
                                              : course['status'] == 'confirmUnSuccess'
                                              ?  Image.asset("assets/img/paymentwaiting.gif",   height: 40,)
                                              : course['status']=='Success' && course['userRatingStatus']=='no'
                                              ?  Image.asset("assets/img/rating.png",   height: 40,)
                                              :  Image.asset("assets/img/rejected.png",  height: 40,),

                                        ),
                                        course['status']=='paymentPending'? Container(
                                          padding: EdgeInsets.only(right:10),
                                          child:MaterialButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),

                                            minWidth:80,
                                            height: 28,
                                            color: Theme.of(context).colorScheme.secondary,
                                            child: new Text('Pay',
                                                style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                                            ),
                                            onPressed: () {
                                              _showAlert(context,course['bookId']);
                                            }

                                        ),) :course['status']=='Success' && course['userRatingStatus']=='no'?Container(
                                          padding: EdgeInsets.only(right:10),
                                          child:MaterialButton(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),

                                              minWidth:80,
                                              height: 28,
                                              color: Theme.of(context).colorScheme.secondary,
                                              child: new Text('Rate',
                                                  style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                                              ),
                                              onPressed: () {

                                                ratingModel(context, course['bookId'], course['providerRatingStatus'], 1, course['providerId']);
                                              }

                                          ),):Container()
                                      ],
                                    )




                                  ],
                                ),




                              ]
                          )

                      ),),



                  ]
              ),
            ):Container();
      }
      )
      )
      )
      ):Container();
    }}):Container();
  }
}


void _showAlert(BuildContext context, bookId) {

  showDialog(context: context, barrierDismissible: true, builder: (context) => BillingDetailsPopup(bookId: bookId));
}
// ignore: must_be_immutable
class BillingDetailsPopup extends StatefulWidget {
  BillingDetailsPopup({Key key, this.bookId}) : super(key: key);
  String bookId;

  @override
  _BillingDetailsPopupState createState() => _BillingDetailsPopupState();
}

class _BillingDetailsPopupState extends StateMVC<BillingDetailsPopup> {
  OrderController _con;

  _BillingDetailsPopupState() : super(OrderController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context, widget.bookId),
        insetPadding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
            bottom: MediaQuery.of(context).size.width * 0.03),
      ),
    );
  }

  _buildChild(BuildContext context, bookId) => SingleChildScrollView(
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("h_payment").where("bookingId", isEqualTo: bookId).snapshots(),
          builder: (context, snapshot) {

            if (snapshot.hasError || snapshot.data == null) {
              return Container();
            } else {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      S.current.payment_details,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(children: [
                        Container(
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(0, 3), //
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Center(child: Icon(Icons.attach_money, size: 30, color: Colors.blue))]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(S.current.cash, style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          S.current.bill_details,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.provider_name, style: Theme.of(context).textTheme.subtitle2),
                                Text(snapshot.data.docs[0]['providerName'], style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.billing_name, style: Theme.of(context).textTheme.subtitle2),
                                Container(
                                    width: 200,
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                                      Text(snapshot.data.docs[0]['billingName'],
                                          overflow: TextOverflow.ellipsis, maxLines: 2, style: Theme.of(context).textTheme.subtitle2),
                                    ]))
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.booking_id, style: Theme.of(context).textTheme.subtitle2),
                                Text(snapshot.data.docs[0]['bookingId'], style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.date, style: Theme.of(context).textTheme.subtitle2),
                                Text(snapshot.data.docs[0]['date'], style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.worked_hours, style: Theme.of(context).textTheme.subtitle2),
                                Text('${snapshot.data.docs[0]['workedHours']} hrs', style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ),


                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(S.current.price, style: Theme.of(context).textTheme.subtitle2),
                                Text(Helper.pricePrint(snapshot.data.docs[0]['total']), style: Theme.of(context).textTheme.subtitle2)
                              ],
                            ),
                            SizedBox(height: 12),
                            snapshot.data.docs[0]['miscellaneousAmount'] != 0
                                ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed('/viewItemDetails', arguments: snapshot.data.documents[0]);
                                  },
                                  child: Text('${S.current.miscellaneous_amount} (Click)', style: Theme.of(context).textTheme.subtitle2),
                                ),
                                Text(Helper.pricePrint(snapshot.data.docs[0]['miscellaneousAmount']), style: Theme.of(context).textTheme.subtitle2)
                              ],
                            )
                                : Row(),
                          ]),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 8),
                  Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tax', style: Theme.of(context).textTheme.subtitle2),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(' ${snapshot.data.docs[0]['tax']}%', style: Theme.of(context).textTheme.subtitle2),
                                Text(Helper.pricePrint(snapshot.data.docs[0]['taxAmount']), style: Theme.of(context).textTheme.subtitle2),
                              ],
                            ),
                          ]),
                        ),
                      )),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.current.discount, style: TextStyle(fontSize: 18, color: Colors.grey)),
                          Text('RM 0.00', style: TextStyle(fontSize: 18, color: Colors.cyanAccent[700]))
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.current.total, style: TextStyle(fontSize: 18, color: Colors.grey)),
                          Text(Helper.pricePrint(snapshot.data.docs[0]['grandTotal']),
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      ),
                      SizedBox(height: 20),
                      BlockButtonWidget(
                        text: Text(
                          S.current.confirm,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () async {
                          _con.updateHandyStatus(widget.bookId, 'confirmUnSuccess');

                          return Navigator.of(context).pop(true);
                        },
                      ),
                      SizedBox(height: 20),
                    ]),
                  ),
                ],
              );
            }}),
    ),
  );
}

// ignore: non_constant_identifier_names
void PaymentConfirmation(context) {
  showDialog(context: context, builder: (context) => PaymentConfirmationPopup());
}

class PaymentConfirmationPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context),
        insetPadding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
      ),
    );
  }

  _buildChild(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    child: Column(
      children: <Widget>[
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            S.current.payment_confirmation,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 70),
        Image(image: AssetImage('assets/img/paymentwaiting.gif'), width: 100, height: 100),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            S.current.waiting_for_payment_confirmation,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
      ],
    ),
  );
}

ratingModel(context, bookId, ratingStatus,  con, providerid) {
  TextEditingController textController = TextEditingController();
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return WillPopScope(
          // add this
          onWillPop: () async => false,
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.13,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40),
                      Image(image: AssetImage('assets/img/rating.png'), width: 100, height: 100),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          right: 12,
                        ),
                        child: Text(
                          S.current.give_us_rating,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 21.0,
                          right: 21,
                        ),
                        child: Text('Help your user improve their service by rating then',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color: Theme.of(context).disabledColor))),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 17.0,
                          right: 17,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 30,
                              itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);

                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('${S.current.booking_id}: $bookId', style: Theme.of(context).textTheme.subtitle1),
                      SizedBox(height: 10),
                      /* Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(children: [
                            Text('Before Service'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 120,
                              height:140,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Center(child: Image(image:NetworkImage('${GlobalConfiguration().getValue('base_upload')}/uploads/beforeservice_image/beforeservice_$bookId.jpg'),
                                            width:100,height:140,
                                            fit: BoxFit.fill),)]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                          ),
                          Column(children: [
                            Text('After Service'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 120,
                              height:140,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Center(child: Image(image:NetworkImage('${GlobalConfiguration().getValue('base_upload')}/uploads/afterservice_image/afterservice_$bookId.jpg'),
                                            width:120,
                                            height:140,

                                            fit: BoxFit.fill),)]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ), */
                      SizedBox(height: 20),
                      Text(S.current.tell_us_about_the_service),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30,
                          top: 5,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                              width: double.infinity,
                              height: 70,
                              child: TextField(
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  controller: textController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Comments',
                                    hintStyle: Theme.of(context).textTheme.caption,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey[300],
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Theme.of(context).colorScheme.secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                  ))),
                        ),
                      ),
                      BlockButtonWidget(
                        text: Text(
                          S.current.submit,
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () async {
                          FirebaseFirestore.instance.collection('HService').doc(bookId).update({'userRatingStatus': 'true'}).catchError((e) {
                            print(e);
                          });
                          // con.bookId = bookId;
                          // con.review = textController.text;
                          // con.userId = currentUser.value.id;
                          // con.providerId = providerid;
                          //repositoryUser.giveRegister(con).then((value) {}).catchError((e) {}).whenComplete(() {});
                          return Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}