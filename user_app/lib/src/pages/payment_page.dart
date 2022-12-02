import 'package:flutter/material.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:toast/toast.dart';
import '../../generated/l10n.dart';
import '../controllers/cart_controller.dart';
import '../helpers/helper.dart';
import '../repository/product_repository.dart';
import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import 'Widget/custom_divider_view.dart';

class PaymentPages extends StatefulWidget {
  @override
  _PaymentPagesState createState() => _PaymentPagesState();
}

class _PaymentPagesState extends StateMVC<PaymentPages> {

  CartController _con;

  _PaymentPagesState() : super(CartController()) {
    _con = controller;
  }
  // ignore: deprecated_member_use

  @override
  void initState() {
    super.initState();


  }

  setSelectedRadio(int val, type, url) {
    setState(() {
      if (val == 1) {
        currentCheckout.value.payment.method = 'cash on delivery';
      } else {
        currentCheckout.value.payment.method = 'online';
      }
    });
    currentCheckout.value.payment.paymentType = type;
    currentUser.value.paymentType = type;
    currentUser.value.paymentImage = url;
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    currentCart.notifyListeners();
    Navigator.pop(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).backgroundColor
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.5,
        title: Text('${S.of(context).bill_total}  ${Helper.pricePrint(currentCheckout.value.grand_total)}',
        style: Theme.of(context).textTheme.headline2,
        ),
      ),
        body: Container(
            child:Column(
                children:[
              Expanded(
                child: Container(
                    width:double.infinity,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[



                              Container(
                                padding: EdgeInsets.only(top:20,left:15,bottom:15),
                                child:Text('Payment Gateways',
                                    style: Theme.of(context).textTheme.subtitle1
                                ),
                              ),

                              setting.value.rayzorPay?Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'RayzorPay','assets/img/razorpay.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:10,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:40,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/razorpay.png',
                                            ),
                                              width:40,height:40,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('RayzorPay',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                              Container(
                                padding: EdgeInsets.only(top:5,left:15,right:15,),
                                child:CustomDividerView(dividerHeight: 1,color: Theme.of(context).dividerColor,),
                              ),
                              setting.value.upi? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'UPI','assets/img/upi.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/upi.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('UPI',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                             Container(
                                padding: EdgeInsets.only(top:5,left:15,right:15,),
                                child:CustomDividerView(dividerHeight: 1,color: Theme.of(context).dividerColor,),
                              ),
                              setting.value.paypal? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'Paypal','assets/img/paypal.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/paypal.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(S.of(context).paypal,style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                             Container(
                                padding: EdgeInsets.only(top:5,left:15,right:15,),
                                child:CustomDividerView(dividerHeight: 1,color: Theme.of(context).dividerColor,),
                              ),
                              setting.value.stripe? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'Stripe','assets/img/stripe.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/stripe.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(S.of(context).stripe,style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                              Container(
                                padding: EdgeInsets.only(top:5,left:15,right:15,),
                                child:CustomDividerView(dividerHeight: 1,color: Theme.of(context).dividerColor,),
                              ),
                              setting.value.flutterWave? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'flutterwave','assets/img/flutterwave.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/flutterwave.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(S.of(context).flutterwave,style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),

                              setting.value.mpesa? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'mpesa','assets/img/M-pesa-logo.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/M-pesa-logo.png',
                                            ),
                                              width:40,height:38,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('M-pesa',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),

                              setting.value.payStack?  Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(2,'Paystack','assets/img/Paystack_Logo.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:15,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/Paystack_Logo.png',
                                            ),
                                              width:40,height:38,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Paystack',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                              CustomDividerView(dividerHeight: 8,color: Theme.of(context).dividerColor,),
                              setting.value.codMode?Container(
                                padding: EdgeInsets.only(top:20,left:15,bottom:15),
                                child:Text(S.of(context).pay_cash_on_delivery,
                                    style: Theme.of(context).textTheme.subtitle1
                                ),
                              ):Container(),

                              setting.value.codMode? Container(

                                child:InkWell(
                                  onTap: (){
                                    setSelectedRadio(1,'COD','assets/img/cod.png');
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:10,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/cod.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('COD',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){},
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ):Container(),
                              CustomDividerView(dividerHeight: 8,color: Theme.of(context).dividerColor,),
                              Container(
                                padding: EdgeInsets.only(top:20,left:15,bottom:15),
                                child:Text(S.of(context).wallet,
                                    style: Theme.of(context).textTheme.subtitle1
                                ),
                              ),

                              Container(

                                child:InkWell(
                                  onTap: (){

                                    if(currentUser.value.walletAmount!='0') {

                                      if(int.parse(currentUser.value.walletAmount)>currentCheckout.value.grand_total) {
                                        print(currentUser.value.walletAmount);
                                        setSelectedRadio(1,'wallet','assets/img/wallet.png');

                                      } else{
                                        _con.showToast(S.of(context).low_balance_please_recharge, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                                      }
                                    } else{
                                      _con.showToast(S.of(context).your_wallet_balance_is_0_please_recharge, gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.only(top:10,left:15,bottom:10,right:15),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width:50,height:30,
                                            padding: EdgeInsets.only(left:3,right:3,top: 3,bottom:3),
                                            decoration: BoxDecoration(
                                                border:Border.all(
                                                    width: 1,color:Theme.of(context).dividerColor
                                                ),
                                                borderRadius: BorderRadius.circular(4)
                                            ),
                                            child: Image(image:AssetImage('assets/img/wallet.png',
                                            ),
                                              width:40,height:28,
                                              fit: BoxFit.fill,
                                            ),
                                          ),

                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('${S.of(context).wallet} (${S.of(context).balance} ${Helper.pricePrint(currentUser.value.walletAmount)}) ',style: Theme.of(context).textTheme.subtitle2),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Align(
                                            child: Container(
                                                padding: EdgeInsets.only(left:10),
                                                child:InkWell(
                                                  onTap: (){


                                                  },
                                                  child: Icon(Icons.arrow_forward_ios,size: 20,),
                                                )
                                            ),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            ]
                        )
                    )
                )
            ),


                ]
            ),

        )
    );
  }
}
