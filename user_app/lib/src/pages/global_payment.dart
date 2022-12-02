

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:multisuperstore/src/repository/order_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/payment_controller.dart';



// ignore: must_be_immutable
class GlobalPaymentWidget extends StatefulWidget {
  String pageTitle;
  GlobalPaymentWidget({Key key,this.pageTitle}) : super(key: key);
  @override
  _GlobalPaymentWidgetState createState() => _GlobalPaymentWidgetState();
}

class _GlobalPaymentWidgetState extends StateMVC<GlobalPaymentWidget> {
  PaymentController _con;
 String payUrl;
  _GlobalPaymentWidgetState() : super(PaymentController()) {
    _con = controller;
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.pageTitle=='Paystack') {
      payUrl = _con.payStackUrl;
      print(payUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(

        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: Theme.of(context).backgroundColor
        ),


        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.pageTitle,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
              initialUrl:payUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _con.webView = controller;
              },
              onPageStarted: (String url) {
                setState(() {
                  payUrl = url;
                });

                if(widget.pageTitle=='Paystack') {

                  if (url == "${GlobalConfiguration().getValue(
                      'base_upload')}payment/paystack_controller/success") {
                    _con.bookOrder(currentCheckout.value);
                  }
                }
              },
              onPageFinished: (String url) {
                setState(() {
                  _con.progress = 1;
                });
              }),
          _con.progress < 1
              ? SizedBox(
                  height: 3,
                  child: LinearProgressIndicator(
                    backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
