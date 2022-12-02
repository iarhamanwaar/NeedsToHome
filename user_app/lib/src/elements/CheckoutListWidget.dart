import 'package:multisuperstore/src/models/coupon.dart';
import '../models/tips.dart';
import '../pages/apply_coupon.dart';
import '../repository/settings_repository.dart';
import '../helpers/helper.dart';
import '../repository/order_repository.dart';
import '../models/cart_responce.dart';
import '../repository/product_repository.dart';
import '../repository/user_repository.dart';
import '../Widget/custom_divider_view.dart';
import 'package:flutter/material.dart';
import '../controllers/cart_controller.dart';
import 'DeliveryModeWidget.dart';
import 'LocationWidget.dart';
import 'Productbox3Widget.dart';
import '../repository/product_repository.dart' as cartRepo;
import '../../generated/l10n.dart';
import 'TimeSlot.dart';

// ignore: must_be_immutable
class CheckoutListWidget extends StatefulWidget {
  CheckoutListWidget({Key key, this.con, this.callback}) : super(key: key);
  CartController con;
  Function callback;
  @override
  _CheckoutListWidgetState createState() => _CheckoutListWidgetState();
}

class _CheckoutListWidgetState extends State<CheckoutListWidget> {
  bool ratingOne = false;
  int selectedRadio;
  CustomDividerView _buildDivider() => CustomDividerView(
    dividerHeight: 1.0,
    color: Theme.of(context).dividerColor,
  );

  @override
  void initState() {

    widget.con.getOriginalDistance();
    widget.con.getTimeSlot();

    if(currentCheckout.value.uploadImage==null){
      currentCheckout.value.uploadImage ='no';
    }

    if(currentCheckout.value.couponStatus){
      currentCheckout.value.couponStatus = false;
      currentCheckout.value.couponCode = '';
      currentCheckout.value.couponData = new CouponModel();
    }
    super.initState();
    selectedRadio = 1;

  }
  setDeliveryType(int val) {
    setState(() {
      selectedRadio = val;
      currentCheckout.value.deliverType = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Container(
      child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ValueListenableBuilder(
                valueListenable: cartRepo.currentCart,
                builder: (context, _setting, _) {
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: currentCart.value.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(top: 10),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, int index) {
                      CartResponce _cartresponce = currentCart.value.elementAt(index);
                      return ProductBox3Widget(con: widget.con, productDetails: _cartresponce);
                    },
                    separatorBuilder: (context, index) {
                      return CustomDividerView(dividerHeight: 1.0, color: Theme.of(context).dividerColor);
                    },
                  );
                }),


            currentCheckout.value.uploadImage=='no'?Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.library_books, color: Colors.grey[500]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: TextField(
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.left,
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: S.of(context).notes_to_shop,
                                    hintStyle: Theme.of(context).textTheme.subtitle2,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1.0,
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ):Container(),/**
            CustomDividerView(dividerHeight: 10.0),
           

            CustomDividerView(dividerHeight: 10.0),
            SizedBox(height: 10),

            Container(
              margin: const EdgeInsets.only(right: 10.0, left: 10, top: 20),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.orange[50],
                border: Border.all(color: Colors.brown[200], width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: <Widget>[
                  /*ClipOval(
                      child: Image.asset(
                        'assets/images/food3.jpg',
                        height: 90.0,
                        width: 90.0,
                      ),
                    ),*/
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Wrap(
                          children: [
                            Theme(
                              data: ThemeData(unselectedWidgetColor: Colors.deepOrange),
                              child: Checkbox(
                                checkColor: Theme.of(context).scaffoldBackgroundColor,
                                activeColor: Colors.deepOrange,
                                value: this.ratingOne,
                                onChanged: (bool value) {
                                  setState(() {
                                    this.ratingOne = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 2),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Text(
                                S.of(context).opt_in_for_no_contact_delivery,
                                style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                S.of(context).our_delivery_partner_will_after_reaching_and_leave_the_order_at_your_door_gate_not_applicable_for_cod,
                                style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Colors.brown, fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ), */
            setting.value.deliveryTips &&  currentCheckout.value.deliverType!=3 &&  currentCheckout.value.uploadImage=='no' ?Container(
              margin: const EdgeInsets.only(right: 10.0, left: 10, top: 10),
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                          Container(child: Icon(Icons.monetization_on)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              S.of(context).tip_your_delivery_partner,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                         // Text(S.of(context).how_it_works, style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.blue)))
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 6),
                              Text(
                                S.of(context).thank_your_delivery_partner_for_helping_you_stay_safe_indoors_support_them_through_these_toug_times_wit_a_trip,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              SizedBox(height: 20),
                              Wrap(spacing: 10,
                                  children: List.generate(  currentTips.value.length, (index){
                                    Tips _tipsData =   currentTips.value.elementAt(index);

                                    return     GestureDetector(
                                        onTap: () => {
                                          currentTips.value.forEach((_l) {
                                            setState(() {
                                              _l.selected = false;

                                            });
                                          }),


                                          if(_tipsData.amount.toDouble()!=currentCheckout.value.delivery_tips){

                                            _tipsData.selected = true,
                                            currentCheckout.value.delivery_tips = _tipsData.amount.toDouble(),
                                            widget.callback(true),
                                            Future.delayed(const Duration(milliseconds: 2500), () {
                                              widget.callback(false);
                                            }),
                                          }else{

                                            _tipsData.selected = false,
                                            currentCheckout.value.delivery_tips = 0,
                                          },

                                          widget.con.grandSummary(),

                                        },
                                        child:Container(
                                            width: 65,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ],
                                              color: _tipsData.selected?Colors.deepPurpleAccent:Theme.of(context).primaryColor,
                                            ),
                                            child: Center(child: Text(Helper.pricePrint(_tipsData.amount)))));


                                  })





                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ):Container(),
            SizedBox(height: 20),
            CustomDividerView(dividerHeight: 15.0),
            !widget.con.couponStatus
                ? InkWell(
              onTap: () async {
                var result = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>  ApplyCoupon(),
                      fullscreenDialog: true,
                    ));

                setState(() {
                  if (result != null) {
                    widget.con.couponStatus = result;
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.local_offer, size: 20.0, color: Colors.grey[700]),
                    SizedBox(width: 10),
                    Text(S.of(context).apply_coupons, style: Theme.of(context).textTheme.bodyText1),
                    Spacer(),
                    Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                  ],
                ),
              ),
            )
                : GestureDetector(
              onTap: () {
                widget.con.removeCoupon();
              },
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check_circle, size: 20.0, color: Colors.green),
                    SizedBox(width: 10),
                    Text('Code ${currentCheckout.value.couponCode} is applied!', style: Theme.of(context).textTheme.bodyText1),
                    Spacer(),
                    Icon(Icons.cancel, color: Colors.grey),
                  ],
                ),
              ),
            ),
            CustomDividerView(dividerHeight: 15.0),
            ValueListenableBuilder(
                valueListenable: cartRepo.currentCart,
                builder: (context, _setting, _) {
                  //widget.con.grandSummary();
                  return Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(S.of(context).bill_details, style: Theme.of(context).textTheme.bodyText1),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(S.of(context).item_total, style: Theme.of(context).textTheme.subtitle2),
                            Text(Helper.pricePrint(currentCheckout.value.sub_total), style: Theme.of(context).textTheme.subtitle2),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[


                                  currentCheckout.value.deliverType!=3? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('${S.of(context).delivery_fee} ${Helper.priceDistance(currentCheckout.value.km)}' , style: TextStyle(color: Colors.blue)),
                                      currentCheckout.value.delivery_fees  != 0
                                          ? Text('${Helper.pricePrint(currentCheckout.value.delivery_fees)}',
                                          style: Theme.of(context).textTheme.subtitle2)
                                          : Text(S.of(context).free, style: Theme.of(context).textTheme.subtitle2),
                                    ],
                                  ):Container(),

                                  SizedBox(height: 5),
                                  currentCheckout.value.deliverType!=3?  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(S.of(context).delivery_tip, style: Theme.of(context).textTheme.subtitle2),
                                      Text(Helper.pricePrint(currentCheckout.value.delivery_tips), style: Theme.of(context).textTheme.subtitle2),
                                    ],
                                  ):Container(),



                                  Container(
                                    child:Theme(
                                      data: theme,
                                      child:ExpansionTile(
                                        initiallyExpanded: false,
                                        tilePadding: EdgeInsets.all(0),
                                        childrenPadding: EdgeInsets.all(0),
                                        trailing: Container(
                                            child:Text(Helper.pricePrint(currentCheckout.value.packingCharge+currentCheckout.value.tax),
                                              style: Theme.of(context).textTheme.subtitle2,
                                            )
                                        ),
                                        title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:[

                                              Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                        padding:EdgeInsets.only(right:5),
                                                        child: Text('${S.of(context).taxes} & ${S.of(context).charges}',
                                                          overflow: TextOverflow.ellipsis,maxLines: 1,
                                                          style: Theme.of(context).textTheme.subtitle2,
                                                        ),
                                                      )
                                                  ),
                                                    Icon(Icons.arrow_drop_down,)

                                                ],
                                              )





                                            ]
                                        ),
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(left:0),
                                            child:Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(bottom:10),
                                                    child: currentCheckout.value.shopTypeID==2?  Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Text(S.of(context).packaging_charge, style: Theme.of(context).textTheme.caption),
                                                            Text(Helper.pricePrint(currentCheckout.value.packingCharge), style: Theme.of(context).textTheme.caption),
                                                          ],
                                                        ):Container(),

                                                  ),
                                                  Container(
                                                    child:Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                            child:Text(S.of(context).tax,
                                                              style: Theme.of(context).textTheme.caption,
                                                            )
                                                        ),
                                                        Container(
                                                            child:Text('${Helper.pricePrint(currentCheckout.value.tax)}',
                                                              style: Theme.of(context).textTheme.caption,
                                                            )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]
                                            ),)
                                        ],
                                      ),
                                    ),

                                  ),


                                  SizedBox(height: 5),
                                  Text('${S.of(context).you_save} ${Helper.pricePrint(currentCheckout.value.discount)}  ${S.of(context).on_this_order}',
                                      style: Theme.of(context).textTheme.caption),
                                  SizedBox(height: 10),
                                  _buildDivider(),
                                  SizedBox(height: 10),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(S.of(context).discount, style: TextStyle(color: Colors.green)),
                                      Text('${Helper.pricePrint(currentCheckout.value.discount)}',
                                          style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Colors.green))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        _buildDivider(),
                        Container(
                          alignment: Alignment.center,
                          height: 60.0,
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).to_pay,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Spacer(),
                              Text(
                                '${Helper.pricePrint(currentCheckout.value.grand_total)}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            CustomDividerView(dividerHeight: 15.0),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.receipt, color: Colors.grey[500]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                child: Text(S.of(context).review_your_order_and_address_details_to_avoid_cancellation, style: Theme.of(context).textTheme.caption)),
                          )
                        ],
                      )),
                  SizedBox(height: 17),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.timer, color: Colors.deepOrangeAccent[200]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                child: Text(S.of(context).if_you_choose_to_cancel_you_can_do_it_with_60_seconds_after_placing_the_order,
                                    style: Theme.of(context).textTheme.caption)),
                          )
                        ],
                      )),
                  SizedBox(height: 17),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.assignment, color: Colors.deepOrangeAccent[200]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                child: Text(S.of(context).post_60_seconds_you_will_be_charged_a_100_cancellation_fess_, style: Theme.of(context).textTheme.caption)),
                          )
                        ],
                      )),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.pan_tool, color: Colors.deepOrangeAccent[200]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(S.of(context).however_in_the_event_of_an_unusual_delay_of_your_order_you_will_not_be_charged_a_cancellation_fees,
                                    style: Theme.of(context).textTheme.caption)),
                          )
                        ],
                      )),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.thumb_up, color: Colors.deepOrangeAccent[200]),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(S.of(context).this_policy_helps_us_avoid_food_wastage_and_compensate_restaurant_delivey_partners_for_their_reports,
                                    style: Theme.of(context).textTheme.caption)),

                          )],
                      )),
                  SizedBox(height: 20),
                  Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 7, right: 10),
                            child: Icon(Icons.thumb_up, color: Colors.transparent),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed('/policy',arguments: 'Return Policy');
                              },
                              child: Container(
                                child: Text(S.of(context).read_policy, style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.blue))),
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomDividerView(dividerHeight: 18.0),

            Container(
                padding: EdgeInsets.only(top:10,left:20, right: 20),
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Row(
                          mainAxisAlignment:MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[


                            Container(
                                height: 35,
                                width:130,
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
                                      child:Container(

                                          child:Text( S.of(context).change_mode,
                                              textAlign: TextAlign.center,
                                              style:Theme.of(context).textTheme.caption.merge(TextStyle(height:1.2,color: Theme.of(context).primaryColorLight))
                                          )
                                      ),

                                    ),
                                    onPressed: () {

 deliveryMode(context,currentCheckout.value.vendor);

                                    },
                                  ),)
                            ),

                          ]
                      ),

                    ]
                )

            ),
            currentCheckout.value.deliverType==1?Container(
                padding: EdgeInsets.only(left:20, right: 20),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Container(
                                width:60,
                                child:Image(
                                  image:AssetImage('assets/img/onthway.gif'),
                                )
                            ),
                            Container(
                                child:Text(S.of(context).instant_delivery)
                            ),
                          ]
                      ),

                      Expanded(
                          child:Container(
                              padding: EdgeInsets.only(left:20,),
                              child:Text(S.of(context).instant_delivery,
                                  style:Theme.of(context).textTheme.subtitle2
                              )
                          )
                      )
                    ]
                )
            ):
            currentCheckout.value.deliverType==2?Container(
                padding: EdgeInsets.only(left:20, right: 20),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Container(
                                width:60,
                                child:Image(
                                  image:AssetImage('assets/img/onthway.gif'),
                                )
                            ),
                            Container(
                                child:Text(S.of(context).takeaway)
                            ),
                          ]
                      ),

                      Expanded(
                          child:Container(
                              padding: EdgeInsets.only(left:20,),
                              child:Text('Scheduled Delivery',
                                  style:Theme.of(context).textTheme.subtitle2
                              )
                          )
                      )
                    ]
                )
            ):
            currentCheckout.value.deliverType==3?Container(
                padding: EdgeInsets.only(left:20, right: 20),
                child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Container(
                                width:60,
                                child:Image(
                                  image:AssetImage('assets/img/onthway.gif'),
                                )
                            ),
                            Container(
                                child:Text(S.of(context).delivery_mode)
                            ),
                          ]
                      ),

                      Expanded(
                          child:Container(
                              padding: EdgeInsets.only(left:20,),
                              child:Text('Takeaway',
                                  style:Theme.of(context).textTheme.subtitle2
                              )
                          )
                      )
                    ]
                )
            ):Container(),




            currentCheckout.value.deliverType==2?Container(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.lock_clock, size: 20.0, color: Colors.grey[700]),
                  SizedBox(width: 10),
                  Text(S.of(context).delivery_time_slot, style: Theme.of(context).textTheme.subtitle2),
                  Spacer(),
                  InkWell(
                    onTap: showSlot,
                    child: currentCheckout.value.deliveryTimeSlot != null
                        ? Text(S.of(context).change,
                        style:
                        Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w600)))
                        : Text(S.of(context).add,
                        style:
                        Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).backgroundColor, fontWeight: FontWeight.w600))),
                  )
                ],
              ),
            ):Container(),
            currentCheckout.value.deliverType==2? Padding(
                padding: EdgeInsets.only(left: 18, right: 18, top: 10),
                child: currentCheckout.value.deliveryTimeSlot != null
                    ? Text(
                  '${S.of(context).your_order_delivery_time_slot_is} ${currentCheckout.value.deliveryTimeSlot}',
                  style: Theme.of(context).textTheme.subtitle2,
                )
                    : Text(
                  S.of(context).please_select_your_delivery_slot,
                  style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Colors.red)),
                )):Container(),
            SizedBox(height: 20),
            CustomDividerView(dividerHeight: 18.0),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 20.0, left: 18, right: 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: Icon(Icons.add_location, color: Colors.grey[500], size: 30.0),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Icon(Icons.check_circle, color: Colors.green, size: 18),
                      )
                    ],
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(S.of(context).delivery_location, style: Theme.of(context).textTheme.subtitle2),
                      SizedBox(height: 10),
                    ],
                  ),
                  Spacer(),
                  Container(
                      height: 35,
                      width:130,
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
                            child:Container(

                                child: currentUser.value.selected_address != null
                                    ? Text(S.of(context).change_address,
                                    textAlign: TextAlign.center,
                                    style:Theme.of(context).textTheme.caption.merge(TextStyle(height:1.2,color: Theme.of(context).primaryColorLight))
                                ):Text(S.of(context).add_address,
                                    style:Theme.of(context).textTheme.caption.merge(TextStyle(height:1.2,color: Theme.of(context).primaryColorLight))
                                )
                            ),

                          ),
                          onPressed: () {

                           showModal();

                          },
                        ),)
                  ),

                  SizedBox(height: 5),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18, right: 18, top: 10),
              child: currentUser.value.selected_address != null
                  ? Text(
                currentUser.value.selected_address,
                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),
              )
                  : Text(
                S.of(context).please_add_your_location,
                style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            SizedBox(height: 100)
          ])),
    );
  }

  void showModal() {
    Future<void> future =  showModalBottomSheet(
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
                              widget.con.calculateDistance(currentUser.value.latitude, currentUser.value.longitude, currentCheckout.value.shopLatitude, currentCheckout.value.shopLongitude);
                              setState(() => currentUser.value);
                              Navigator.pop(context);
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

    future.then((void value) => {
      widget.con.calculateDeliveryFees(),

    });
  }

  void showSlot() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
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
                        child: widget.con.timeSlot.isNotEmpty
                            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[TimeSlotWidget(choice: widget.con.timeSlot)])
                            : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.con.timeSlot.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () {
                              setState(() => currentUser.value);
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                            child: Text(
                              S.of(context).proceed_and_close,
                              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                            )),
                      ),
                    )
                        : Container(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void deliveryMode(context, shopDetails) {
    Future<void> future = showModalBottomSheet(
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

    future.then((void value) => {
      setState((){
    setState(() => currentUser.value);
    widget.con.grandSummary();
    if(    currentCheckout.value.deliverType!=3) {
      widget.con.calculateDeliveryFees();
    }


      }),

    });
  }
}
