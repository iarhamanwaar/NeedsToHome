import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:multisuperstore/src/helpers/helper.dart';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import '../../generated/l10n.dart';
import 'package:multisuperstore/src/controllers/user_controller.dart';
import 'dart:math';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'OtpVerificationSmart.dart';


class MobileLogin extends StatefulWidget {

  @override
  _MobileLoginState createState() => _MobileLoginState();
}



class SmsAutoFill {
  static SmsAutoFill _singleton;
  static const MethodChannel _channel = const MethodChannel('sms_autofill');
  final StreamController<String> _code = StreamController.broadcast();

  factory SmsAutoFill() => _singleton ??= SmsAutoFill._();

  SmsAutoFill._() {
    _channel.setMethodCallHandler(_didReceive);
  }

  Future<void> _didReceive(MethodCall method) async {
    if (method.method == 'smscode') {
      _code.add(method.arguments);
    }
  }

  Stream<String> get code => _code.stream;

  Future<String> get hint async {
    final String hint = await _channel.invokeMethod('requestPhoneHint');
    print('number');

    return hint;
  }

  Future<void> get listenForCode async {
    await _channel.invokeMethod('listenForCode');
  }

  Future<void> unregisterListener() async {
    await _channel.invokeMethod('unregisterListener');
  }


}
class _MobileLoginState extends StateMVC<MobileLogin>  with SingleTickerProviderStateMixin {
  SmsAutoFill _autoFill = SmsAutoFill();
  final TextEditingController _controllerPhone = TextEditingController();
  String dailCode = setting.value.dailCode;
  String initialCountry = setting.value.isoCode;
  PhoneNumber number = PhoneNumber(isoCode: setting.value.isoCode);
  UserController _con;
  _MobileLoginState() : super(UserController()) {
    _con = controller;
  }
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  String verificationId;

  AnimationController animationController;
  void initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 10),
    );

    animationController.repeat();
    if(GetPlatform.isAndroid){
      _askPhoneHint();
    }

  }
  @override
  void dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }



  Future<void> _askPhoneHint() async {
    String hint = await _autoFill.hint;

    try {

      var prefix = hint.split(setting.value.dailCode);
      _controllerPhone.text = prefix[1];
    } catch (e){
      print('error nu');
      print(e);
      // ignore: deprecated_member_use
      _con.scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
        content: Text('Please check your country code'),
      ));
    }

    print( _controllerPhone.value.text);
  }



  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _con.scaffoldKeyState,
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/img/loginbg1.jpg'), fit: BoxFit.cover)),
            ),

            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.transparent,
                    /*Colors.transparent,*/
                    Color(0xff161d27).withOpacity(0.9),
                    Color(0xff161d27),
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Positioned(
              top: 50.0,
              right: size.width * -0.24,
              child:Container(
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: animationController,
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/img/plate-food2.png'),

                      height:size.width * 0.5,
                      fit: BoxFit.fill,

                    ),
                  ),
                  builder: (BuildContext context, Widget _widget) {
                    return Transform.rotate(
                      angle: animationController.value * 2 * pi,
                      child: _widget,
                    );
                  },
                ),


              ),
            ),

            Form(
              key: _con.loginFormKey,
              child:   Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      S.of(context).welcome,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "to ${setting.value.appName}, let's Login in",
                        style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Colors.grey))
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Theme(
                      data: new ThemeData(

                        primarySwatch: Colors.grey,
                      ),
                      child:Container(
                        margin: EdgeInsets.only(left: 40, right: 40),
                        width: double.infinity,
                        child:InternationalPhoneNumberInput(
                          textFieldController:  _controllerPhone,
                          onInputChanged: (PhoneNumber number) {

                            setState(() {
                              dailCode = number.dialCode;
                            });
                          },
                          initialValue: number,
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,

                          inputDecoration: InputDecoration(
                            focusColor: Theme.of(context).colorScheme.secondary,

                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 1.0,
                              ),
                            ),
                          ),

                          textStyle: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Theme.of(context).primaryColorLight)),
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color: Colors.white)),
                          // initialValue: number,
                          // textFieldController: controller,
                          formatInput: false,

                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Container(
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 40, right: 40),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () async {
                          if(_controllerPhone.text!='') {
                            //_con.login();
                            Overlay.of(context).insert(_con.loader);
                            await _auth.verifyPhoneNumber(
                              phoneNumber: '$dailCode${_controllerPhone.text}',
                              verificationCompleted: (
                                  phoneAuthCredential) async {
                                Helper.hideLoader(_con.loader);
                              },
                              verificationFailed: (verificationFailed) async {
                                Helper.hideLoader(_con.loader);
                                // ignore: deprecated_member_use
                                _con.scaffoldKeyState?.currentState?.showSnackBar(
                                    SnackBar(content: Text(
                                        verificationFailed.message)));
                              },
                              codeSent: (verificationId, resendingToken) async {
                                this.verificationId = verificationId;
                                Helper.hideLoader(_con.loader);
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        OtpVerificationSmart(
                                          verificationId: verificationId,
                                          mobileNo: '$dailCode${_controllerPhone
                                              .text}',)));
                              },
                              codeAutoRetrievalTimeout: (
                                  verificationId) async {},
                            );
                          }
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                            S.of(context).login,
                            style:Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight,fontWeight: FontWeight.bold,))

                        ),
                      ),
                    ),
                    SizedBox(height:30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              child: Divider(
                                color: Theme.of(context).dividerColor,
                                thickness: 1.2,
                              )),
                          Text(
                            " ${S.of(context).or}  ",
                            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                          ),
                          Expanded(
                              child: Divider(
                                color: Theme.of(context).dividerColor,
                                thickness: 1.2,
                              )),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 25,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            padding: EdgeInsets.only(left:10,right:10),
                            child:Wrap(
                                children:[
                                /*  Div(
                                    colS:4,
                                    colM:4,
                                    colL:4,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        //  _con.googleLogin();
                                      },
                                      elevation: 5.0,
                                      fillColor: Theme.of(context).primaryColor,
                                      child: Icon(Icons.email,size:32),
                                      padding: EdgeInsets.all(7.0),
                                      shape: CircleBorder(),
                                    ),

                                  ), */
                                  Div(
                                    colS:4,
                                    colM:4,
                                    colL:4,
                                    child:RawMaterialButton(
                                        onPressed: () {
                                          _con.handleLogin();

                                        },
                                        elevation: 5.0,
                                        fillColor: Theme.of(context).primaryColor,
                                        child: Image.asset('assets/img/facebook.png',
                                        width:40,height:40,
                                        ),
                                        padding: EdgeInsets.all(3.0),
                                        shape: CircleBorder(),
                                      ),

                                  ),
                                  Div(
                                    colS:4,
                                    colM:4,
                                    colL:4,
                                    child:RawMaterialButton(
                                      onPressed: () {
                                        _con.googleLogin();
                                      },
                                      elevation: 5.0,
                                      fillColor: Theme.of(context).primaryColor,
                                      child: Image.asset('assets/img/g_logo.png',
                                        width:30,height:30,
                                      ),
                                      padding: EdgeInsets.all(8.0),
                                      shape: CircleBorder(),
                                    ),

                                  ),


                                ]
                            ),
                          ),

                        ]
                    ),
                    SizedBox(height:10),
                    Container(
                        padding: EdgeInsets.only(top:20),
                      child:Column(
                        children:[
                          Text(S.of(context).by_continuing_you_agree_to_our,
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight)),
                          ),
                          Wrap(
                            children:[
                              InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/policy',arguments: 'Terms and Conditions');
                                  },
                                  child:Container(
                                    padding: EdgeInsets.only(right:3),
                                    child:Text('${S.of(context).terms_and_conditions},',
                                      style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                    ),
                                  )
                              ),

                              InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/policy',arguments: 'Privacy Policy');

                                  },
                                  child:Container(
                                    child:Text('${S.of(context).privacy_policy},',
                                        style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                    ),
                                  )
                              ),
                              InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed('/policy',arguments: 'Return Policy');
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(right:3),
                                    child:Text('${S.of(context).return_policy},',style:Theme.of(context).textTheme.caption.merge(TextStyle(color:Theme.of(context).primaryColorLight))),
                                  )
                              ),
                            ]
                          ),

                        ]
                      )
                    ),





                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }





}

