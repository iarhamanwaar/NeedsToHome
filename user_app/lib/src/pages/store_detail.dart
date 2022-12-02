import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/DeliveryModeWidget.dart';
import 'package:multisuperstore/src/elements/RectangularLoaderWidget.dart';
import 'package:multisuperstore/src/elements/SearchWidgetRe.dart';
import 'package:multisuperstore/src/elements/StoreTimingWidget.dart';
import 'package:multisuperstore/src/elements/VendorDetailsPopup.dart';
import 'package:multisuperstore/src/pages/rating_review.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../elements/OfferSliderWidget.dart';
import '../helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/vendor_controller.dart';
import '../elements/BottomBarWidget.dart';
import '../elements/Productbox1Widget.dart';
import '../models/restaurant_product.dart';
import '../models/vendor.dart';
import 'chat_detail_page.dart';

// ignore: must_be_immutable
class StoreViewDetails extends StatefulWidget {
  Vendor shopDetails;
  int shopTypeID;
  int focusId;
  StoreViewDetails({Key key, this.shopDetails, this.shopTypeID, this.focusId}) : super(key: key);
  @override
  _StoreViewDetailsState createState() => _StoreViewDetailsState();
}

class _StoreViewDetailsState extends StateMVC<StoreViewDetails> with SingleTickerProviderStateMixin {


  VendorController _con;

  _StoreViewDetailsState() : super(VendorController()) {
    _con = controller;
  }



  final controller1 = ScrollController();
  double itemsCount = 25;
  // ignore: non_constant_identifier_names
  double AdBlockHeight = 130.0;
  double itemHeight = 130.0;
  double screenWidth = 0.0;
  double calculateSize = 0.0;
  double shopTitle = 10.0;
  double subOpacity = 1.0;
  bool popperShow = false;
  TabController   _tabController;

  @override
  void initState() {
    super.initState();
    controller1.addListener(onScroll);
    _con.listenForRestaurantProduct(int.parse(widget.shopDetails.shopId), loaderMenuSwap);




    if(currentCheckout.value.deliverType==null){
      currentCheckout.value.deliverType = 1;
    }

  }

  loaderMenuSwap(){
    _tabController = new  TabController(vsync: this, length: _con.vendorResProductList.length);
  }

  tabMaker() {
    // ignore: deprecated_member_use
    List<Tab> tabs = List();

     _con.vendorResProductList.forEach((element) {
        tabs.add(Tab(
        text: element.category_name,
        ));
     });
    return tabs;
  }



  onScroll() {
    setState(() {
      calculateSize = itemHeight - controller1.offset;

      if (calculateSize > 65) {
        AdBlockHeight = calculateSize;
        shopTitle = controller1.offset;
        subOpacity = 0;
      }
      if (shopTitle < 10) {
        shopTitle = 10;
        subOpacity = 1.0;
      }
      //print(cWidth);
      //loginWidth = 250.0;
    });
  }
  void callback(bool nextPage) {
    setState(() {
      this.popperShow = nextPage;
    });
  }

  void moveSwap(int nextPage) {
    _tabController.animateTo(nextPage);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _con.vendorResProductList.length,
      child: Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       floatingActionButton: FancyFab(product:_con.vendorResProductList,moveSwap:this.moveSwap),

        body:   NestedScrollView(
          controller: controller1,
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              TransitionAppBar(
                extent: 250,
                shopTitle: shopTitle,
                shopDetails: widget.shopDetails,
                shopTypeID: widget.shopTypeID,
                subOpacity: subOpacity,
                focusId:  widget.focusId,
                callback: this.callback,
                itemDetails: _con.vendorResProductList,
                avatar: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.shopDetails.logo), fit: BoxFit.fill),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                ),
                title: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                ),
                height: AdBlockHeight,
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      <Widget>[
                        Container(
                          margin:EdgeInsets.only(bottom:10),
                          child:  !Helper.shopOpenStatus(widget.shopDetails)?StoreTimingWidgets(shopDetails: widget.shopDetails):Container(),
                        ),
                        OfferSliderWidget(shopId:widget.shopDetails.shopId),

                      ]
                  )
              ),

              SliverPersistentHeader(
                floating: false,
                pinned: true,
                delegate: _SliverAppBarDelegate(

                  TabBar(
                    controller: _tabController,
                    indicatorWeight: 2.0,
                    isScrollable: true,
                    indicatorColor: Colors.red,
                    unselectedLabelColor: Colors.grey,
                    tabs: tabMaker(),
                  ),
                ),
              ),
            ];
          },
          body: _con.vendorResProductList.isEmpty?  RectangularLoaderWidget() :TabBarView(
            controller: _tabController,
        children: List.generate(
        _con.vendorResProductList.length,
              (index) {

                RestaurantProduct _productDetails = _con.vendorResProductList.elementAt(index);
                return ProductBox1Widget(productData:  _productDetails.productdetails, shopId:widget.shopDetails.shopId, shopName: widget.shopDetails.shopName,subtitle: widget.shopDetails.subtitle, km:widget.shopDetails.distance, shopTypeID: widget.shopTypeID,
                latitude: widget.shopDetails.latitude,longitude: widget.shopDetails.longitude, callback: this.callback,focusId: widget.focusId,);
          },
        ),
      ),
        ),
      ),
    );
  }
}


class TransitionAppBar extends StatefulWidget {

  final Widget avatar;
  final Widget title;
  final double extent;
  final double height;
  final double shopTitle;
  final Vendor shopDetails;
  final double subOpacity;
  final int shopTypeID;
  final int focusId;
  final Function callback;
  final List<RestaurantProduct> itemDetails;
  TransitionAppBar({this.avatar, this.title, this.extent = 250, this.height, this.shopTitle, this.shopDetails, this.subOpacity,this.shopTypeID,this.focusId,this.itemDetails,this.callback, Key key})
      : super(key: key);

  @override
  _TransitionAppBarState createState() => _TransitionAppBarState();
}

class _TransitionAppBarState extends State<TransitionAppBar> {

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
           shopTypeID: widget.shopTypeID,
          avatar: widget.avatar,
          title: widget.title,
          extent: widget.extent > 200 ? widget.extent : 91,
          height: widget.height,
          shopTitle: widget.shopTitle,
          shopDetails: widget.shopDetails,
          itemDetails: widget.itemDetails,
          callback: widget.callback,
          focusId: widget.focusId,
          subOpacity:widget.subOpacity, scrollController: null),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 40, bottom: 70, left: 30),
      end: EdgeInsets.only(
        left: 30,
        top: 30.0,
        bottom: 10,
      ));
  final _avatarAlignTween = AlignmentTween(begin: Alignment.topLeft, end: Alignment.bottomLeft);
  final double heights;
  final Widget avatar;
  final Widget title;
  final double extent;
  final double height;
  final double shopTitle;
  final Vendor shopDetails;
  final double subOpacity;
  final int shopTypeID;
  final Function callback;
  final int focusId;
  final List<RestaurantProduct> itemDetails;
  _TransitionAppBarDelegate({
    this.avatar,
    this.heights,
    this.title,
    this.extent = 250,
    this.height,
    this.shopTitle,
    this.shopDetails,
    this.subOpacity,
    this.shopTypeID,
    this.itemDetails,
    this.focusId,
    this.callback,
    @required ScrollController scrollController,
  })  : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  void offerDetail(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                  ),
                  child:Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(


                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200],
                                  width: 1,
                                ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                S.of(context).offer_details,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child:Container(
                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                //  OfferDetailsPart(pageType: 'vendor',shopId: shopDetails.shopId,),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                      ),

                    ],

                  )
              ),
            ),
          );
        });
  }

   deliveryMode(context, shopDetails) {
     showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                  ),
                  child:Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(

                            shape: BoxShape.rectangle,
                            border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[200],
                                  width: 1,
                                ))),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                S.of(context).pick_your_preference,
                                style: Theme.of(context).textTheme.headline1,
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ),
                      Expanded(
                          child:Container(
                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  DeliveryMode(shopDetails: shopDetails,),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          )
                      ),
                    ],

                  )
              ),
            ),
          );
        });

  }
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;

    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);


    return Stack(
      children: <Widget>[
        Image(image: shopDetails.cover =='no_image' && shopTypeID==2?AssetImage('assets/img/resturentdefaultbg.jpg',):NetworkImage(shopDetails.cover), height: 190, width: double.infinity, fit: BoxFit.cover),
        Padding(
          padding: EdgeInsets.only(top: 40, right: 20),
          child: Align(
              alignment: Alignment.topRight,
              child: Wrap(
                  children:[
                    Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color:Theme.of(context).colorScheme.secondary,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: IconButton(
                          icon: new Icon(Icons.chat,color:Theme.of(context).colorScheme.primary, size: 18),
                          onPressed: () {
                            if (currentUser.value.apiToken != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChatDetailPage(
                                      shopId:  shopDetails.shopId,
                                      shopName: shopDetails.shopName,
                                      shopMobile: '1')));
                            } else {
                              Navigator.of(context).pushNamed('/Login');
                            }

                          },
                        )),
                    SizedBox(width:20),
                    Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor, boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                          ),
                        ]),
                        child: IconButton(
                          icon: new Icon(Icons.close,size: 16),
                          onPressed: () {

                            Navigator.pop(context);
                          },
                        )),
                  ]
              )

          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child:Stack(
              clipBehavior: Clip.none, children:[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AnimatedContainer(
                    color: Colors.transparent,
                    duration: Duration(seconds: 0),
                    height: height,
                    width: double.infinity,
                    child: Card(
                      color: Theme.of(context).primaryColor,
                      elevation: 10.0,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: shopTitle, right: 10),
                              child: Row(children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(shopDetails.shopName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3),
                                    ],
                                  ),
                                ),

                                Wrap(
                                  children: [
                                    InkWell(
                                      onTap: (){

                                        showDialog(context: context,
                                            builder: (BuildContext context){
                                              return VendorFullDetailsPopWidget(shopId: shopDetails.shopId,);
                                            }
                                        );
                                      },
                                      child:Icon(Icons.help_outline),
                                    ),
                                    SizedBox(width:10),
                                    Container(
                                        child:InkWell(
                                            onTap: (){
                                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => RatingReviews(vendorid: int.parse(shopDetails.shopId),)));

                                            },
                                            child:Column(
                                                children:[
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 25,
                                                  ),

                                                  Text(shopDetails.ratingTotal, style: Theme.of(context).textTheme.caption.merge(TextStyle(height:1.0))),
                                                ]
                                            )
                                        )
                                    ),
                                  ],
                                )
                              ]),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                child: subOpacity == 1.0
                                    ? Text(
                                  shopDetails.subtitle,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                )
                                    : Text('')),
                            Padding(
                              padding: EdgeInsets.only(top:8,left: 10, right: 10,bottom:10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                        children:[
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  deliveryMode(context, shopDetails);
                                                  //setState(() => currentUser.value);

                                                },
                                                child:Row(
                                                    children:[
                                                      currentCheckout.value.deliverType ==1 ?Icon(Icons.delivery_dining): currentCheckout.value.deliverType ==2 ?Icon(Icons.lock_clock):Icon(Icons.takeout_dining),
                                                      SizedBox(width:5),
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:[
                                                            Wrap(
                                                                children:[
                                                                  Text(Helper.priceDistance(shopDetails.distance), style: TextStyle(fontSize:10,)),
                                                                  SizedBox(width:2),
                                                                  Icon(Icons.arrow_drop_down,size:15),
                                                                ]
                                                            ),


                                                            Text(S.of(context).distance,style: TextStyle(fontSize:10,fontWeight: FontWeight.w600)),
                                                          ]
                                                      )
                                                    ]
                                                ),
                                              ),

                                            ],
                                          ),

                                          SizedBox(width: 10),

                                          Column(
                                            children: [
                                              Row(
                                                  children:[
                                                    Icon(Icons.access_time,size:15),
                                                    SizedBox(width:5),
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:[


                                                          Text('${Helper.calculateTime(double.parse(shopDetails.distance.replaceAll(',','')),int.parse(shopDetails.handoverTime),false)}',
                                                              style: TextStyle(fontSize:10,)
                                                          ),
                                                          Text(S.of(context).delivery_time,
                                                            style: TextStyle(fontSize:10,fontWeight: FontWeight.w600),
                                                          ),
                                                        ]
                                                    )
                                                  ]
                                              ),



                                            ],
                                          ), SizedBox(width: 10),
                                   /*     Column(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  offerDetail(context);
                                                },
                                                child: Row(
                                                    children:[
                                                      Icon(Icons.local_offer_outlined,size:15),
                                                      SizedBox(width:5),
                                                      Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:[
                                                            Wrap(
                                                                children:[


                                                                  Text(S.of(context).offer,
                                                                      style: TextStyle(fontSize:10,fontWeight: FontWeight.w600)
                                                                  ),


                                                                  SizedBox(width:2),
                                                                  Icon(Icons.arrow_drop_down,size:15)
                                                                ]
                                                            ),


                                                          ]
                                                      )
                                                    ]
                                                ),
                                              ),

                                            ],
                                          ), */

                                        ]
                                    ),
                                  ),

                                  IconButton(
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                          SearchResultWidgetRe(itemDetails: itemDetails,shopId:shopDetails.shopId, shopName: shopDetails.shopName,subtitle:shopDetails.subtitle, km:shopDetails.distance, shopTypeID:shopTypeID,
                                            latitude:shopDetails.latitude,longitude:shopDetails.longitude, callback: this.callback,focusId:focusId,)));



                                    },
                                    icon: Icon(Icons.search),
                                  )

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            Positioned(
                    top:-30,left:30,
                    child: shopDetails.bestSeller? Shimmer(
                        duration: Duration(seconds: 3),
                        // This is NOT the default value. Default value: Duration(seconds: 0)
                        interval: Duration(seconds: 0),
                        // This is the default value
                        color: Theme.of(context).colorScheme.primary,
                        // This is the default value
                        colorOpacity: 0.5,
                        // This is the default value
                        enabled: true,
                        // This is the default value
                        direction: ShimmerDirection.fromLTRB(),
                        child:Stack(
                            children:[
                              Container(
                                  width:80,height:70,
                                  child:Image(image:AssetImage('assets/img/sellerlable.png'))
                              ),
                              Align(
                                alignment: Alignment.center,
                                child:Container(
                                    margin: EdgeInsets.only(top:28,left:5),
                                    alignment: Alignment.center,
                                    child:Center(
                                        child:Text(S.of(context).best_seller,
                                          style: TextStyle(color:Theme.of(context).colorScheme.primary,fontSize: 10,fontWeight: FontWeight.w700
                                          ),
                                        )
                                    )
                                ),)


                            ])):Container()
                ),
              ]
          ),

        ),
        Padding(
          padding: avatarMargin,
          child: Align(alignment: avatarAlign, child: Hero(tag: shopDetails.shopId, child: avatar)),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}







class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color:Theme.of(context).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}






class FancyFab extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;
  final List<RestaurantProduct> product;
  final Function moveSwap;

  FancyFab({this.onPressed, this.tooltip, this.icon, this.product, this.moveSwap});

  @override
  _FancyFabState createState() => _FancyFabState();
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      // _animationController.reverse();
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }
  bool openState = false;


  Widget toggle() {
    return Container(
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children:[
            Container(
                margin: EdgeInsets.only(bottom:60,right:10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.12,
                  color: Colors.transparent,

                  child: Card(
                    elevation: 5,
                    shape: StadiumBorder(),
                    color: Colors.blueAccent,
                    // ignore: deprecated_member_use
                    child: FlatButton(
                        onPressed: (){
                          setState(() {
                            if(openState) {
                              openState = false;
                              animate();
                            } else{
                              openState = true;
                              animate();
                            }
                          });
                        },
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                        color: Theme.of(context).primaryColorDark,
                        shape: StadiumBorder(),
                        child: Wrap(
                          children: [
                            openState ? Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColorLight,
                                size: 17,
                              ),
                            ):Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Icon(
                                Icons.local_dining,
                                color: Theme.of(context).primaryColorLight,
                                size: 17,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            openState ? Container(
                                padding: EdgeInsets.only(top:1),
                                child:Text(S.of(context).close,style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(height:1.0,color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w600)),
                                )
                            ) :Container(
                              padding: EdgeInsets.only(top:3),
                              child:Text(
                                S.of(context).browse_menu,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .merge(TextStyle(color: Theme.of(context).primaryColorLight,height:1.0, fontWeight: FontWeight.w600)),
                              ),),
                          ],
                        )),
                  ),

                )),
            BottomBarWidget(),
          ]
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Container(

        alignment: Alignment.bottomRight,
        width: size.width,
        color:  openState ? Colors.black12.withOpacity(0.4):null,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[

            Visibility(
              maintainState: openState,
              visible: openState,

              child:Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    _translateButton.value * 1.0,
                    0.0,
                  ),
                  child: Container(
                    height: size.height * 0.55,
                    width: size.width * 0.8,
                    margin: EdgeInsets.only(right:10),
                    decoration: BoxDecoration(
                        color:Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius:2.0,
                            spreadRadius: 1.0,
                          ),
                        ]
                    ),
                    child:SingleChildScrollView(
                        child:Column(
                            children:[
                              ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  itemCount:  widget.product.length,
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: EdgeInsets.only(top: 16),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, int index) {
                                    RestaurantProduct _product = widget.product.elementAt(index);
                          return    InkWell(
                                onTap: (){

                                  widget.moveSwap(index);
                                  setState(() {
                                    if(openState) {
                                      openState = false;
                                      animate();
                                    } else{
                                      openState = true;
                                      animate();
                                    }
                                  });
                                },
                                child:  ListTile(
                                  contentPadding: EdgeInsets.only(bottom:0,left:15,right:15),
                                  title: Container(
                                    child:Text(_product.category_name,style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(fontWeight: FontWeight.w300)),),
                                  ),
                                  trailing: Container(
                                      child:Text(_product.productdetails.length.toString(),style: Theme.of(context).textTheme.headline1,)
                                  ),
                                ),
                              );

    },  separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        }),
                            ]


                        )
                    ),
                  )
              ), ),



            toggle(),
          ],
        )
    );
  }
}