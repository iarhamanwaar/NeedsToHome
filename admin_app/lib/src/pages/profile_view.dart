import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/VendorDetailsWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class ProfileView extends StatefulWidget {
  final String coverImage;
  final int type;
  final int shopId;
  final String shopName;
  final String status;
  const ProfileView({Key key, this.type, this.coverImage, this.shopId, this.shopName, this.status}) : super(key: key);
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends StateMVC<ProfileView> {
  UserController _con;

  _ProfileViewState() : super(UserController()) {
    _con = controller;
  }
  ScrollController _customScrollViewController;
  ScrollController _singleChildScrollViewController;

  final _sliverAppBarExpandedHeight = 200.0;


  @override
  void initState() {
    print('loader data');
    _customScrollViewController = ScrollController();
    _singleChildScrollViewController = ScrollController();

    _singleChildScrollViewController.addListener(() {
      if (_singleChildScrollViewController.offset <
          _sliverAppBarExpandedHeight) {
        _customScrollViewController
            .jumpTo(_singleChildScrollViewController.offset);
      }
    });
    _con.getVendorProfileDetailData(widget.shopId);
    _con.listenForWalletBanner(widget.shopId);
    _con.getBusinessCard(widget.shopId);
    super.initState();

    print(widget.coverImage);
  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
        CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: _customScrollViewController,
              slivers: [
                SliverAppBar(
                  pinned:true,
                  automaticallyImplyLeading: false,
                  expandedHeight: _sliverAppBarExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: widget.coverImage =='no_image' && widget.type==1? Image.asset(
                        'assets/img/grocerydefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ):
                    widget.coverImage =='no_image' && widget.type==2?Image.asset(
                        'assets/img/resturentdefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ):
                    widget.coverImage =='no_image' && widget.type==3?Image.asset(
                        'assets/img/pharmacydefaultbg.jpg',
                        fit: BoxFit.cover,
                        height:200
                    ): Image.network(
                        widget.coverImage,
                        fit: BoxFit.cover,
                        height:200
                    ),
                  ),
                ),
                SliverFillRemaining(),
              ],
            ),


    Scrollbar(
    isAlwaysShown: true,
     //controller: _controller,
     child:SingleChildScrollView(
            //controller: _singleChildScrollViewController,
           child:Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children:[
               Align(
                 alignment: Alignment.topLeft,
               child:Padding(
                 padding: EdgeInsets.only(top:20,right:20,),
                 child:Container(
                   width:40,height:40,
                   decoration: BoxDecoration(shape: BoxShape.circle,
                       color:Colors.black.withOpacity(0.5)
                   ),
                   child:IconButton(
                     onPressed: (){
                       Navigator.pop(context);
                     },
                     icon:Icon(Icons.arrow_back),
                     color: Theme.of(context).primaryColorLight,
                   ),
                 ),
               ),
               ),
               Align(
                 alignment: Alignment.topRight,
                 child:Padding(
                     padding: EdgeInsets.only(top:0,right:40,),
                     child:  Badge(
                       toAnimate: false,
                       shape: BadgeShape.square,
                       badgeColor: Colors.blue,
                       borderRadius: BorderRadius.circular(8),
                       badgeContent: Text(widget.status, style: TextStyle(color:Theme.of(context).primaryColorLight)),
                     ),

                 ),
               ),
               Container(
                 margin: EdgeInsets.only(top: _sliverAppBarExpandedHeight - 200),
                 padding: EdgeInsets.symmetric(horizontal:0),
                 child: Align(

                   child:Responsive(
                       children:[
                         Wrap(
                             children:[
                               Div(
                                   colS: 12,
                                   colM:6,
                                   colL:4,
                                   child: Column(
                                       children:[

                                         SizedBox(
                                           height: 15,
                                         ),

                                       ]
                                   )
                               ),
                               Div(
                                   colS: 12,
                                   colM:12,
                                   colL:12,
                                   child: Padding(
                                     padding: EdgeInsets.only(top:0),
                                     child:_con.loaderData ?VendorDetailsWidget(con: _con,walletModel: _con.walletBannerData,shopId: widget.shopId):EmptyOrdersWidget(),
                                   )
                               ),


                             ]
                         ),
                       ]
                   ),


                 ),
               ),
             ]
           ),

          ),),
        ],
      );
  }
}

