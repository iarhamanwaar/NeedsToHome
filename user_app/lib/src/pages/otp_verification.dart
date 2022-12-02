import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OtpVerification extends StatefulWidget {
  OtpVerification({
    Key key,
  }) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends StateMVC<OtpVerification> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text('OTP VERIFICATION',style: Theme.of(context).textTheme.headline1,),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
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

            Text("Verification Code", style: Theme.of(context).textTheme.headline1.merge(TextStyle(fontWeight: FontWeight.bold))),
            SizedBox(height: 10.0),
            Text("We have sent the code verification to your mobile number +81 96466 78905",
              style: Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center, ),

            SizedBox(height: 20),

            Wrap(
                children:[
                  Container(
                    padding: EdgeInsets.only(top:10,right:10),
                    child:Text("+81 96466 78905",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:8,),
                    height: 28,width:28,
                    decoration: BoxDecoration(
                        color: Colors.brown,
                        shape: BoxShape.circle
                    ),
                    child: Center(
                        child:IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.edit,color:Colors.white,size:15),
                        )
                    ),
                  ),

                ]
            ),
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
                          onCompleted: (pin) {},
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
                },
                shape: StadiumBorder(),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFc8019), Color(0xFFFc8019)],
                        begin: Alignment(-2.0, -2.0),
                        end: Alignment(1.0, 1.0),
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Container(

                    constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("VERIFY",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).primaryColorLight))),
                  ),
                ),
              ),),
            SizedBox(height: 80.0),
          ],
        ),

      ),
    );
  }
}

