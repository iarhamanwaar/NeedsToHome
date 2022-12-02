import 'package:easy_web_view/easy_web_view.dart';

import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:vrouter/vrouter.dart';

class Zone extends StatefulWidget {
  final String pageType;
  final String id;
  const Zone({Key key, this.pageType, this.id}) : super(key: key);

  @override
  _ZoneState createState() => _ZoneState();
}

class _ZoneState extends State<Zone> {

  String url;
  @override
  void initState() {
    if(widget.pageType=='Edit'){
      url =  '${GlobalConfiguration().getValue('api_base_url')}zone/zoneEdit/${widget.id}';
    } else{
      url =  '${GlobalConfiguration().getValue('api_base_url')}zone/';
    }

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,

        leading: IconButton(
          onPressed: (){
          if(widget.pageType=='Edit') {
            Navigator.pop(context);
          } else{
            VRouter.of(context).to('/managezone');
          }

          },
          icon: Icon(Icons.arrow_back,color:Colors.black),
        ),
      ),
      body: EasyWebView(
          src: url,//'http://192.168.0.102/google-maps-polygon-coordinates-tool/dist/index.html',
        // Try to convert to flutter widgets
        // width: 100,
        // height: 100,
      ),
    );
  }
}
