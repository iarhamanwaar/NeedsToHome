import 'package:flutter/material.dart';

class ServiceNotAvailableWidget extends StatefulWidget {
  const ServiceNotAvailableWidget({Key key}) : super(key: key);

  @override
  _ServiceNotAvailableWidgetState createState() => _ServiceNotAvailableWidgetState();
}

class _ServiceNotAvailableWidgetState extends State<ServiceNotAvailableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Stack(
            children:[
              Container(
                height:300,
                width:double.infinity,
                child: Image.asset('assets/img/location_nofound.png',fit: BoxFit.fill,),
              ),
              Container(
                  height:200,
                  width:double.infinity,
                  padding: EdgeInsets.only(left:20,right:20),
                  child:Center(
                      child: Text('We are not delivering here at the moment.Please try again different location or try again later',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.5))))
                  )
              )
            ]
        )
    );
  }
}
