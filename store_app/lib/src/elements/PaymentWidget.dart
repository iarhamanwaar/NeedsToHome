import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({Key key}) : super(key: key);

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {


  bool _isLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController controllerGlobal;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        //appBar: CustomAppBar(title: 'payment'.tr, onBackPressed: () => _exitApp(context)),
        body: Center(
          child: Container(

            child: Stack(
              children: [
              WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'https://www.youtube.com/',
              gestureNavigationEnabled: true,
              userAgent: 'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
              onWebViewCreated: (WebViewController webViewController) {
                _controller.future.then((value) => controllerGlobal = value);
                _controller.complete(webViewController);
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
                setState(() {
                  _isLoading = true;
                });
                // _redirect(url);
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                setState(() {
                  _isLoading = false;
                });
                //_redirect(url);
              },
            ),
              _isLoading ? Center(
              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
    ) : SizedBox.shrink(),
              ],
            ),
          ),
        ),
    );
  }
}
