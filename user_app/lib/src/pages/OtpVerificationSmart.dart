import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/user_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'dart:math' as math;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import '../../generated/l10n.dart';





// ignore: must_be_immutable
class OtpVerificationSmart extends StatefulWidget {
  String verificationId;
  String mobileNo;
  OtpVerificationSmart({
    Key key,
    this.verificationId,
    this.mobileNo,
  }) : super(key: key);

  @override
  _OtpVerificationSmartState createState() => _OtpVerificationSmartState();
}

class _OtpVerificationSmartState extends StateMVC<OtpVerificationSmart> with TickerProviderStateMixin {
  AnimationController controller1;
  final TextEditingController _controllerOTPPhone = TextEditingController();
  bool isPlaying = true;
  UserController _con;
  _OtpVerificationSmartState() : super(UserController()) {
    _con = controller;
  }
  String get timerString {
    Duration duration = controller1.duration * controller1.value;
    String timer = '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    if (timer == '0:00') {
      isPlaying = false;
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 300).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    controller1.reverse(from: controller1.value == 0.0 ? 1.0 : controller1.value);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text('OTP ${S.of(context).verification}',style: Theme.of(context).textTheme.headline1,),
      ),
      key: _con.scaffoldKey,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _con.loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Align(
                    alignment: FractionalOffset.center,
                    child:Image.asset('assets/img/cart_empty_ipmau1.png',
                      width: 150,height:150,fit: BoxFit.fill,
                    )
                ),
              ),

              Text(S.of(context).verification_code, style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.bold))),
              SizedBox(height: 10.0),
              Text("${S.of(context).we_have_sent_the_code_verification_to_your_mobile_number} ${widget.mobileNo}",
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center, ),

              SizedBox(height: 20),






              Container(
                padding: EdgeInsets.only(top:20,left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: OTPTextField(
                            length: 6,
                            width: MediaQuery.of(context).size.width,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 40,
                            style: TextStyle(fontSize: 20),
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              _controllerOTPPhone.text = pin;
                            },
                          ),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                ),
              ),

              SizedBox(height: 43.0),

              Container(
                margin: EdgeInsets.only(left:20,right:20),
                // ignore: deprecated_member_use
                child:RaisedButton(
                  onPressed: () {
                    // Navigator.of(context).pushNamed('/SignUp', );
                    PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.verificationId, smsCode: _controllerOTPPhone.text);

                    _con.signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(

                      constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(S.of(context).verify,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).primaryColorLight))),
                    ),
                  ),
                ),),
              SizedBox(height: 80.0),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value || color != old.color || backgroundColor != old.backgroundColor;
  }
}
