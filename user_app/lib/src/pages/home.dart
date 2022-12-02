
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:multisuperstore/src/elements/ButtonShimmerWidget.dart';
import 'package:multisuperstore/src/elements/ControllPanelWidget.dart';
import 'package:multisuperstore/src/elements/FixedBannerWidget.dart';
import 'package:multisuperstore/src/elements/HandyManCard.dart';
import 'package:multisuperstore/src/elements/MyRecommendedTypeWidge.dart';
import 'package:multisuperstore/src/elements/SearchBarWidget.dart';
import 'package:multisuperstore/src/elements/SearchResultsWidget.dart';
import 'package:multisuperstore/src/elements/ServiceNotAvailableWidget.dart';
import 'package:multisuperstore/src/elements/Spotlight.dart';
import 'package:multisuperstore/src/elements/VendorDetailsPopup.dart';
import 'package:multisuperstore/src/models/main_category.dart';
import 'package:multisuperstore/src/models/searchisresult.dart';
import 'package:multisuperstore/src/pages/product_list.dart';
import 'package:multisuperstore/src/repository/home_repository.dart';
import '../elements/AddCartSliderWidget.dart';
import '../elements/AddRestaurantSliderWidget.dart';
import '../elements/BottomLiveStatusWidget.dart';
import '../elements/CategoryLoaderWidget.dart';
import '../elements/HandyServiceStatus.dart';
import '../elements/MiddleSliderWidget.dart';
import '../elements/CategoryshopType.dart';
import '../elements/ShopTypesSlider.dart';
import '../elements/LocationWidget.dart';
import '../controllers/home_controller.dart';
import '../elements/HomeSliderWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
import 'featured_product.dart';



class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;
 final Function selectTab;
  HomeWidget({Key key,  this.iconColor,
    this.labelColor,this.parentScaffoldKey, this.selectTab}) : super(key: key);
  final Color iconColor;
  final Color labelColor;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends StateMVC<HomeWidget> {

  HomeController _con;
  bool loader = false;
  String qrCodeResult = "Not Yet Scanned";

  _HomeWidgetState() : super(HomeController()) {
    _con = controller;

  }




  @override
  void initState() {

    // TODO: implement initState
    super.initState();
     _con.listenForZone();
    if(currentUser.value.recommendation!='load') {
      _con.listenForMyRecommendation();
    }
    _con.listenForDealOfDay('first');
    _con.listenForInter_sort_view();


  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (barcodeScanRes!='-1') {
      setState(() {
        qrCodeResult = barcodeScanRes;
      });
      showDialog(context: context,
          builder: (BuildContext context) {
            return VendorFullDetailsPopWidget(shopId: qrCodeResult,);
          });
    }
  }

// ignore: non_constant_identifier_names

  void controllPanel() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.92,
              color: Color(0xff737373),
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:  Radius.circular(15)),
                  ),
                  child:Column(
                    children: [

                      Expanded(
                          child:Container(
                            child:SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ControlPanel(),
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
  Widget build(BuildContext context) {


    return Container(

        child:RefreshIndicator(
        onRefresh: _con.refreshHome,
        child: Scaffold(

            backgroundColor: Theme.of(context).primaryColor,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
           floatingActionButton : BottomLiveStatusWidget(),

            appBar: AppBar(

              leading: Wrap(

                  children:[
                    Container(
                      padding: EdgeInsets.only(left:5,top:15),
                      child:InkWell(
                        onTap: () => widget.parentScaffoldKey.currentState.openDrawer(),
                        child: Icon(Icons.menu, color:Theme.of(context).backgroundColor.withOpacity(0.5)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top:18),
                      child:InkWell(
                          onTap: (){
                            showModal();
                          },
                          child: Icon(Icons.location_on_outlined,
                            size:19,
                            color:Theme.of(context).hintColor,
                          )
                      ),
                    ),
                  ]
              ),

              actions: <Widget>[

                loader
                    ? SizedBox(
                  width: 60,
                  height: 60,
                  child: RefreshProgressIndicator(),
                )
                    : ShoppingCartButtonWidget(iconColor: Theme.of(context).backgroundColor.withOpacity(0.5), labelColor: Theme.of(context).splashColor),
              ],
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 0,

              title: GestureDetector(
                  onTap: () {
                    //DeliveryAddressDialog(context: context);

                    showModal();
                  },
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                    currentUser.value.latitude== null || currentUser.value.longitude == null
                        ? Text(S.of(context).select_your_address, style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(fontWeight: FontWeight.w800)))
                        : Text(currentUser.value.selected_address, style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(fontWeight: FontWeight.w800))),

                  ])),
            ),
            body: !_con.pageLoader?CustomScrollView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: <Widget>[
                  SliverList(

                    delegate: SliverChildListDelegate(

                        <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Row(
                                children:[
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(

                                            width:35,height:35,
                                            child:InkWell(
                                              onTap: () async {

                                                if (currentUser.value.apiToken != null) {

                                                  scanQR();
                                                  /** showDialog(context: context,
                                                      builder: (BuildContext context){
                                                      return VendorFullDetailsPopWidget(shopId: qrCodeResult,);
                                                      }); */
                                                } else {
                                                  Navigator.of(context).pushNamed('/Login');
                                                }

                                              },
                                              child: Image(
                                                image: AssetImage('assets/img/qrcode.png'),
                                              ),
                                            )
                                        ),
                                      ]
                                  ),
                                  SizedBox(width:15),
                                  Expanded(
                                    child:SearchBarWidget(
                                      parentScaffoldKey: widget.parentScaffoldKey,
                                      onClickFilter: (event) {
                                        widget.parentScaffoldKey.currentState.openEndDrawer();
                                      },
                                    ),
                                  ),
                                  SizedBox(width:10),
                                  InkWell(
                                    onTap: (){

                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                        return SearchResultWidget(parentScaffoldKey:widget.parentScaffoldKey,pageType: 'bottom');
                                      }));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFaeaeae).withOpacity(0.1),

                                            borderRadius: BorderRadius.circular(4)),
                                        child: Icon(Icons.keyboard_voice_outlined,
                                          color:Theme.of(context).hintColor,
                                        )
                                    ),
                                  ),

                                ]
                            ),
                          ),
                          Stack(
                              children:[
                                Container(
                                  // Here the height of the container is 45% of our total height
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                HomeSliderWidget(slides: _con.slides),
                              ]
                          ),

                          HandyServiceStatus(),
                          SizedBox(height: 20,),


                          // StopTypeWidget(TypeDate: _con.shopTypeList),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children:[
                                  Icon(Icons.favorite,color:Colors.red),
                                  SizedBox(width:7),
                                  Text(S.of(context).my_Recommended,
                                      style: Theme.of(context).textTheme.headline3
                                  ),

                                ]
                            ),
                          ),
                          SizedBox(height: 20),
                          currentRecommendation.value.isEmpty ? CategoryLoaderWidget() :  MyRecommendedTypeWidge(shopType: currentRecommendation.value,),


                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Expanded(
                                    child:Text(S.of(context).shop_categories,
                                        style: Theme.of(context).textTheme.headline3
                                    ),),
                                  Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child:Material(  //Wrap with Material
                                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                        //elevation:_category.selected?3:1,
                                        color: Theme.of(context).primaryColorDark,
                                        clipBehavior: Clip.antiAlias, // Add This
                                        child: MaterialButton(
                                          child: Center(
                                            child:   Container(
                                                child:Wrap(
                                                    children:[
                                                      Icon(
                                                          Icons.shopping_bag_outlined,
                                                          color:Theme.of(context).primaryColorLight

                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(top:3,left:10,right:5),
                                                          child:Text(S.of(context).see_all,
                                                              textAlign: TextAlign.center,
                                                              style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,color: Theme.of(context).primaryColorLight)
                                                          )
                                                      ),

                                                    ]
                                                )

                                            ),
                                          ),
                                          onPressed: () {
                                        controllPanel();


                                          },
                                        ),)
                                  ),


                                ]
                            ),
                          ),

                          SizedBox(height: 15),

                          _con.mainShopCategories.isEmpty? ButtonShimmerWidget():
                          Container(
                            height:67,
                            child:ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _con.mainShopCategories.length,
                                physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                padding: EdgeInsets.only(right:10),
                                itemBuilder: (context, index) {
                                  MainCategoryModel _category = _con.mainShopCategories.elementAt(index);

                                  return Container(
                                    padding: EdgeInsets.only(top:15,bottom:12,left:12,),
                                    child:Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12.withOpacity(0.2),
                                              blurRadius: _category.selected?3:1,
                                              spreadRadius: _category.selected?3:0.3,
                                            ),
                                          ],
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child:Material(  //Wrap with Material
                                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                                          //elevation:_category.selected?3:1,
                                          color:  _category.selected?Theme.of(context).colorScheme.secondary:Theme.of(context).primaryColor,
                                          clipBehavior: Clip.antiAlias, // Add This
                                          child: MaterialButton(
                                            /* shape: RoundedRectangleBorder(side: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 1,
                                                  style: BorderStyle.solid
                                              ),
                                                  borderRadius: BorderRadius.circular(22)
                                              ),*/
                                            height: 55,
                                            color:  _category.selected?Theme.of(context).colorScheme.secondary:Theme.of(context).primaryColor,
                                            child: Center(
                                              child:   Container(
                                                  child:Wrap(
                                                      children:[
                                                        Icon(
                                                            Icons.ac_unit_sharp,
                                                            color: _category.selected?Theme.of(context).primaryColorLight:Theme.of(context).hintColor
                                                        ),
                                                        Container(
                                                            padding: EdgeInsets.only(top:3,left:10,right:5),
                                                            child:Text(_category.name,
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: FontWeight.w100,color: _category.selected?Theme.of(context).primaryColorLight:Theme.of(context).hintColor)
                                                            )
                                                        ),

                                                      ]
                                                  )

                                              ),
                                            ),
                                            onPressed: () {
                                              _con.mainShopCategories.forEach((_l) {
                                                setState(() {
                                                  _l.selected = false;
                                                });
                                              });
                                              _category.selected = true;
                                              _con.listenForDealOfDay(_category.id);
                                            },
                                          ),)
                                    ),

                                  );
                                }
                            ),
                          ),

                          _con.shopTypeList.isEmpty ? CategoryLoaderWidget() :  CategoryShopType(shopType: _con.shopTypeList,),


                          SizedBox(height:40),
                          currentUser.value.zoneId!="no_matched"?HandyManCard():ServiceNotAvailableWidget(),

                          SizedBox(height: 20),
                          currentUser.value.zoneId!="no_matched"?FixedBannerWidget(fixedSlider: _con.fixedSlider,):Container(),
                          SizedBox(height: 20),
                          Container(
                            color:Color(0xFFfbeee7),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                currentUser.value.zoneId!="no_matched"?ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                  onTap: (){

                                  },
                                  title: Text(setting.value.featuredText??'',
                                    style: Theme.of(context).textTheme.headline3.merge(TextStyle(color:Color(0xFFd65e2e))),
                                  ),
                                  trailing: InkWell(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeaturedProduct(focusId:_con.focusId,shopType: _con.shopType,)));
                                    },
                                    child:Text('View More',
                                      style:TextStyle(color: Color(0xFFd65e2e))
                                    )
                                  ),


                                ):Container(),
                                currentUser.value.zoneId!="no_matched" &&  _con.shopType==2?
                                Container(
                                    height:200,
                                    child:ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:  _con.featuredData.length,
                                        scrollDirection: Axis.horizontal,
                                         physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                         itemBuilder: (context, index) {
                                           ItemDetails _itemData = _con.featuredData.elementAt(index);
                                            return Container(
                                              margin: EdgeInsets.only(bottom: 15),

                                              child:AddRestaurantSliderWidget(itemData: _itemData,homeLock: true,));
                                        }
                                    ))
                                    :
                                currentUser.value.zoneId!="no_matched" && _con.shopType==1 ||_con.shopType==3 ?
                                Container(
                                    height:270,
                                    child:ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:  _con.featuredData.length,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                                        itemBuilder: (context, index) {
                                          ItemDetails _itemData = _con.featuredData.elementAt(index);
                                          return AddCartSliderWidget(productList: _itemData.productList, shopId: _itemData.vendor.shopId,
                                            shopName:_itemData.vendor.shopName ,subtitle:_itemData.vendor.subtitle,
                                            km:_itemData.vendor.distance,latitude: _itemData.vendor.latitude,
                                            longitude: _itemData.vendor.longitude,focusId: int.parse(_itemData.vendor.focusType),searchType: 'search',
                                            itemData: _itemData,homeLock: true,) ;
                                        }
                                    )
                                )
                                    :Container(),

                              ],
                            ),
                          ),



                          SizedBox(height: 20),
                          currentUser.value.zoneId!="no_matched"?ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),

                            title: Text(
                              S.of(context).nearest_shop,
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            subtitle: Text(
                              S.of(context).nearest_for_you,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ):Container(),

                          currentUser.value.zoneId!="no_matched"?ShopTopSlider(vendorList: _con.vendorList, key: null,):Container(),
                          SizedBox(height: 20),
                          currentUser.value.zoneId!="no_matched"?MiddleSliderWidget(slides: _con.middleSlides):Container(),
                          SizedBox(height: 15),
                          currentUser.value.zoneId!="no_matched"?ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),

                            title: Text('Top products',
                              style: Theme.of(context).textTheme.headline3,
                            ),

                          ):Container(),
                          SizedBox(height: 15),
                          currentUser.value.zoneId!="no_matched" &&  _con.shopType==2?
                          Container(
                              height:170,
                              child:ListView.builder(
                              shrinkWrap: true,
                              itemCount:  _con.itemData.length,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
          ItemDetails _itemData = _con.itemData.elementAt(index);
                                return AddRestaurantSliderWidget(itemData: _itemData,homeLock: true,);
        }
                              ))



                              :
                           currentUser.value.zoneId!="no_matched" && _con.shopType==1 ||_con.shopType==3 ?
                           Container(
                               height:250,
                               child:ListView.builder(
                               shrinkWrap: true,
                               itemCount:  _con.itemData.length,
                               scrollDirection: Axis.horizontal,
                                   physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) {
                                 ItemDetails _itemData = _con.itemData.elementAt(index);
             return AddCartSliderWidget(productList: _itemData.productList, shopId: _itemData.vendor.shopId,
               shopName:_itemData.vendor.shopName ,subtitle:_itemData.vendor.subtitle,
               km:_itemData.vendor.distance,latitude: _itemData.vendor.latitude,
               longitude: _itemData.vendor.longitude,focusId: int.parse(_itemData.vendor.focusType),searchType: 'search',
               itemData: _itemData,homeLock: true,) ;
        }
        )
                           )



                               :Container(),


                          SizedBox(height: 20),
                          currentUser.value.zoneId!="no_matched"?Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child:Text(S.of(context).best_recommended_shop,style:Theme.of(context).textTheme.headline3),
                          ):Container(),
                            Container(
                            child:  currentUser.value.zoneId!="no_matched"?SpotlightWidget():Container(),
                          ),
                          //TopProductWidget(),




                        ]),),




                ]):Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  CircularProgressIndicator(color:  Theme.of(context).primaryColorDark,),
                  Container(
                    padding: EdgeInsets.only(top:10),
                    child:Text('${S.of(context).changing_your_location}.',
                    style: Theme.of(context).textTheme.caption,
                    )
                  )
                ]
              ),

            )),));



  }


  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          LocationModalPart(),
                        ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () {
                              setState(() => currentUser.value);
                              Navigator.pop(context);
                              _con.listenForZone();

                            },
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                            child: Text(
                              S.of(context).proceed_and_close,
                              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                            )),
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
