import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_indicator/page_indicator.dart';
import '../controllers/order_controller.dart';


class BottomLiveStatusWidget extends StatefulWidget {
  const BottomLiveStatusWidget({Key key}) : super(key: key);

  @override
  _BottomLiveStatusWidgetState createState() => _BottomLiveStatusWidgetState();
}

class _BottomLiveStatusWidgetState extends StateMVC<BottomLiveStatusWidget> {
  GlobalKey<PageContainerState> key = GlobalKey();
  PageController controller1;
  int _currentPage = 0;
  Timer _timer;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  OrderController _con;

  _BottomLiveStatusWidgetState() : super(OrderController()) {
    _con = controller;
  }
    @override
  void initState() {
    super.initState();
    controller1 = PageController();

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    _timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return    currentUser.value.id!=null? StreamBuilder(
        stream: FirebaseFirestore.instance.collection("orderDetails").where("grandState", isEqualTo:false )
            .where("userId", isEqualTo: currentUser.value.id ).snapshots(),
    builder: (context, snapshot) {
    if (snapshot.hasError || snapshot.data == null) {
    return Container();
    } else {
      return Container(
          height:size.height * 0.085,
        child: PageIndicatorContainer(
            key: key,
            align: IndicatorAlign.bottom,
            length: snapshot.data.docs.length,
            indicatorSpace: 15.0,
            indicatorColor: Colors.white,
            shape: IndicatorShape.defaultOval,
            indicatorSelectorColor: Colors.black,
            child:PageView.builder(
          itemCount: snapshot.data.docs.length,
          scrollDirection: Axis.horizontal,
          controller: _pageController,
              reverse: false,
          itemBuilder: (context, index) {
            DocumentSnapshot course = snapshot.data.docs[index];
            return Container(

                decoration: BoxDecoration(
                    color: Colors.amberAccent.withOpacity(0.91),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        spreadRadius: 1.0,
                      ),
                    ]
                ),
                width: double.infinity,
                height:size.height * 0.085,
                child: Container(
                    padding: EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 36,
                            height: 36.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage('${GlobalConfiguration().getValue('base_upload')}/uploads/vendor_image/vendor_${course['shopId']}.png')
                                )
                            )),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.only(left: 10, right: 9),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(course['shopName'],
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .subtitle2,
                                          )
                                      ),
                                      Container(
                                          child: Text('Your order is being ${course['status']}',
                                            style: Theme
                                                .of(context)
                                                .textTheme
                                                .caption,
                                          )
                                      ),

                                    ]
                                )
                            )
                        ),
                        // ignore: deprecated_member_use
                        Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).pushNamed('/orderDetails', arguments: course['orderId']);
                                        },
                                        child: Text(
                                          'View',
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText2
                                              .merge(TextStyle(color: Colors.red)),
                                        ),
                                      )),
                                  SizedBox(width: 15),
                                  Container(
                                      height: 20, width: 20,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2.0,
                                            spreadRadius: 1.0,
                                          ),
                                        ],
                                        color: Theme
                                            .of(context)
                                            .primaryColor,
                                        shape: BoxShape.circle,
                                      ),

                                      child: InkWell(
                                        onTap: (){
                                          _con.updateOrderStatus(course['orderId'], true);
                                        },
                                          child: Icon(Icons.close, size: 14)
                                      )
                                  )

                                ]
                            )
                        ),


                      ],
                    ))
            );
          },
        ))
      );

    }
    }):Container();
  }
}
