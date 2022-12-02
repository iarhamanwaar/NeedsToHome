import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_indicator/page_indicator.dart';
import '../controllers/order_controller.dart';
import '../repository/order_repository.dart';
import '../repository/user_repository.dart';
import 'BlockButtonWidget.dart';
// ignore: must_be_immutable
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

    return    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("HService")
            .where("providerId",
            isEqualTo: currentUser.value.id)
            .where("providerRatingStatus", isEqualTo: 'no')
            .snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasError || snapshot.data == null) {
    return Container();
    } else {

      return snapshot.data.docs.length>0?Container(
          height:size.height * 0.15,
          child:Container(
              width:double.infinity,
              height:size.height * 0.15,
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

            return Container(
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
                                                  Text(course['status']=='confirmUnSuccess'?'Waiting for payment confirmation':'Your Status: ${course['status']}',
                                                    style: Theme.of(context).textTheme.subtitle1,
                                                  ),
                                                  Text('Book ID ${course['bookId']}',
                                                    style: Theme.of(context).textTheme.caption,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                  Container(
                                                      padding: EdgeInsets.only(left:15,right:15,top:10),
                                                      child:InkWell(
                                                    onTap: (){
                                                      currentBookView.value.bookid =
                                                      course['bookId'];
                                                      currentBookView.value.userid =
                                                      course['userid'];
                                                      currentBookView.value.username =
                                                      course['username'];
                                                      currentBookView.value.mobile =
                                                      course['userMobile'];

                                                      Navigator.of(context).pushNamed(
                                                          '/BookTracking',
                                                          arguments: course['bookId']);
                                                    },
                                                    child: Text('View',style:TextStyle(color:Colors.red)),
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

                                              child: Image.asset("assets/img/paymentwaiting.gif",  height: 40,))
                                              : course['status'] == 'confirmUnSuccess'
                                              ?  Image.asset("assets/img/paymentwaiting.gif",   height: 40,)
                                              : course['status']=='Success' && course['userRatingStatus']=='no'
                                              ?  Image.asset("assets/img/rating.png",   height: 40,)
                                              :  Image.asset("assets/img/rejected.png",  height: 40,),

                                        ),
                                        course['status']=='confirmUnSuccess'? Container(
                                          padding: EdgeInsets.only(right:10),
                                          child:MaterialButton(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),

                                            minWidth:80,
                                            height: 28,
                                            color: Theme.of(context).colorScheme.secondary,
                                            child: new Text('Received',
                                                style: Theme.of(context).textTheme.headline1.merge(TextStyle( color:Theme.of(context).primaryColorLight))
                                            ),
                                            onPressed: () {
                                              PaymentConfirmation(context,course["bookId"]);
                                            }

                                        ),) :Container()
                                      ],
                                    )




                                  ],
                                ),




                              ]
                          )

                      ),),



                  ]
              ),
            );
      }
      )
      )
      )
      ):Container();
    }});
  }
}






// ignore: non_constant_identifier_names
void PaymentConfirmation(context, bookId) {
  showDialog(
      context: context,
      builder: (context) => PaymentConfirmationPopup(bookId: bookId));
}

// ignore: must_be_immutable
class PaymentConfirmationPopup extends StatefulWidget {
  PaymentConfirmationPopup({Key key, this.bookId}) : super(key: key);
  String bookId;
  @override
  _PaymentConfirmationPopupState createState() =>
      _PaymentConfirmationPopupState();
}

class _PaymentConfirmationPopupState
    extends StateMVC<PaymentConfirmationPopup> {
  OrderController _con;
  _PaymentConfirmationPopupState() : super(OrderController()) {
    _con = controller;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChild(context),
        insetPadding:
        EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4),
      ),
    );
  }

  _buildChild(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    child: Column(
      children: <Widget>[
        SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            S.of(context).payment_confirmation,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 70),
        Image(
            image: AssetImage('assets/img/paymentwaiting.gif'),
            width: 100,
            height: 100),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12,
          ),
          child: Text(
            S.of(context).confirm_when_user_paid_the_full_amount,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        SizedBox(height: 70),
        BlockButtonWidget(
          text: Text(
            S.of(context).confirm,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            _con.updateData(widget.bookId, 'Success');
            return Navigator.of(context).pop(true);
          },
        ),
      ],
    ),
  );
}
