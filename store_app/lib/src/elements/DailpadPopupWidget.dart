
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/light_color.dart';
import 'package:login_and_signup_web/src/controllers/wallet_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
// ignore: must_be_immutable
class DailpadPopup extends StatefulWidget{
  double balance;
  DailpadPopup({Key key, this.balance}) : super(key: key);
  @override
  _DailpadPopupState createState() => _DailpadPopupState();
}

class _DailpadPopupState extends StateMVC<DailpadPopup> {





  @override
  Widget build(BuildContext context) {
    return Container(

        alignment: Alignment.center,
        child: Div(
          colS: 12,
          colM: 8,
          colL: 5,


          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)
            ),

            elevation: 0,
            backgroundColor: LightColor.navyBlue1,

            insetPadding: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.1,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.09,
              right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.09,
              bottom: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: LightColor.navyBlue1,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  MoneyTransferPage(walletBalance: widget.balance,)

                ],
              ),
            ),
          ),

        )

    );
  }
}

// ignore: must_be_immutable
class MoneyTransferPage extends StatefulWidget {
   double walletBalance;
  MoneyTransferPage({Key key, this.walletBalance}) : super(key: key);

  @override
  _MoneyTransferPageState createState() => _MoneyTransferPageState();
}

class _MoneyTransferPageState extends StateMVC<MoneyTransferPage> {
  WalletController _con;

  _MoneyTransferPageState() : super(WalletController()) {
    _con = controller;
  }

  TextEditingController amount=new TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textBalanceController = TextEditingController();
  var _value = "";


  @override
  void initState() {
    super.initState();
    print('error part');

    textBalanceController.text = '10';


  }

  Align _buttonWidget() {
    var size = MediaQuery.of(context).size;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(top:size.width > 769 ? 70: 70),
          height: size.width > 769 ? 290 :380,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding:EdgeInsets.only(top:10),
                    child:SingleChildScrollView(child:Column(
                      children:[
                        Wrap(
                            runSpacing: 20,
                            children:List.generate(9, (index) {
                              return Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:Container(
                                      padding:EdgeInsets.all(8),
                                      child:_countButton((index+1).toString())
                                  )
                              );
                            })
                        ),
                        Container(
                            padding: EdgeInsets.only(top:10),
                          child:Wrap(
                              children:[
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:_icon(Icons.euro_symbol, true),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:Container(
                                    padding: EdgeInsets.only(top:20),
                                    child:_countButton("0"),
                                  ),
                                ),
                                Div(
                                  colS:4,
                                  colM:4,
                                  colL:4,
                                  child:_icon(Icons.backspace, false),
                                ),






                              ]
                          )
                        ),
                        Container(
                          padding:EdgeInsets.only(top:0),
                          child:InkWell(
                              onTap: (){

                                _con.requestAmount(textEditingController.text, widget.walletBalance);
                              },
                              child: _transferButton(
                            
                          )),
                        )

                      ]
                    ))
                  )
                ),

              ],
            ),
        )
    );
  }

  Widget _transferButton() {
    return Container(
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: LightColor.navyBlue2,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Wrap(
          children: <Widget>[
            Transform.rotate(
              angle: 70,
              child: Icon(
                Icons.swap_calls,
                color: Colors.white,size: 15,
              ),
            ),
            SizedBox(width: 10),
            Text(
               S.of(context).request,
                style:TextStyle(color:Colors.white,)
            ),
          ],
        ));
  }

  Widget _icon(IconData icon, bool isBackground) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
               onTap: (){
                 if (_value != null && _value.length > 0) {
                   setState(() {
                     _value = _value.substring(0, _value.length - 1);
                     textEditingController.text = _value;
                   });
                 }
               },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: isBackground
                        ? LightColor.lightGrey
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Icon(icon),
              ),
            ),
            !isBackground
                ? SizedBox()
                : Text(
              S.of(context).clear,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.navyBlue2),
            )
          ],
        ));
  }
  setText(String value) async {
    setState(() {
      _value += value;
      textEditingController.text = _value;
    });
  }
  Widget _countButton(String text) {
    // ignore: deprecated_member_use
    return FlatButton(

            color: Theme.of(context).primaryColor,
            hoverColor: Theme.of(context).primaryColor,
            onPressed: () {

                setText(text);

            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                  text,
                  style:TextStyle(color:Colors.black,fontWeight: FontWeight.w700)
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height:size.width > 769 ? size.height * 0.85 :size.height * 0.80,
        child:Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,

            children: <Widget>[
              Positioned(
                top: size.height * 0.07,
               child:Container(
                   margin: EdgeInsets.only(top:0),
                   child:Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children:[
                         Container(
                           margin: EdgeInsets.only(bottom:10),
                             width: 200,
                             padding:
                             EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                                 color: LightColor.navyBlue2,
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(15))),
                             child:Container(
                                 width: 200,
                                 child: TextFormField(
                                     textAlign: TextAlign.left,
                                     autocorrect: true,
                                     keyboardType: TextInputType.text,
                                     controller:textEditingController,
                                     //initialValue: widget.addonDetails.name,
                                     //onSaved: (input) => widget.con.addonData.name = input,
                                     validator: (input) =>  input.length < 1 ? 'Please enter the Value' : null,
                                     style: TextStyle(color:Theme.of(context).primaryColorLight),
                                     decoration: InputDecoration(
                                       labelText: S.of(context).amount,
                                       labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                       enabledBorder: UnderlineInputBorder(
                                         borderSide: BorderSide(
                                           color: Colors.grey,
                                           width: 1.0,
                                         ),
                                       ),
                                       focusedBorder: UnderlineInputBorder(
                                         borderSide: BorderSide(
                                           color:
                                           Theme.of(context).colorScheme.secondary,
                                           width: 1.0,
                                         ),
                                       ),
                                     )))
                         ),

                         Text(S.of(context).your_balance,
                             style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                         ),
                         Text(Helper.pricePrint( widget.walletBalance),style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight))),
                         SizedBox(height:15),



                       ]
                   )
               ),
              ),

              Positioned(
                top: size.height * .3,
                right: -150,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              Positioned(
                top: size.height * .3,
                right: -180,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              ),
              Positioned(
                  left: 0,
                  top: 15,
                  child: Row(
                    children: <Widget>[
                      BackButton(color: Colors.white,),
                      SizedBox(width: 20),
                      Text(
                          S.of(context).request,
                        style:TextStyle(color:Colors.white,)
                      )
                    ],
                  )),
              _buttonWidget(),

            ],
    ));

  }
}

