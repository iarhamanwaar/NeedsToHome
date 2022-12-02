import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';


class PaypalPayment extends StatefulWidget {
  @override
  _PaypalPaymentState createState() => _PaypalPaymentState();
}

class _PaypalPaymentState extends State<PaypalPayment> {
// ignore: deprecated_member_use
  String src =
      '${GlobalConfiguration().getValue('api_base_url')}Paypal/index/${currentUser.value.id}/100';

  bool open = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Razor Pay',
            style: TextStyle(
                color: const Color(0xff379982),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: <Widget>[],
        ));
  }
}
