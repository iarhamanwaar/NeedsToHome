import 'package:flutter/material.dart';



Widget getMap(double lat,double long) {
  //A unique id to name the div element
  String htmlId = "6";
  //creates a webview in dart
  //ignore: undefined_prefixed_name
  /**ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
    // ignore: unnecessary_statements
    List<LatLng> langList=<LatLng>[];
    final latLang = LatLng(lat,long);
    final latLang1 = LatLng(12.9557616, 77.7568832);
    //class to create a div element
    langList.add(latLang);
    langList.add(latLang1);
    final mapOptions = MapOptions()
      ..zoom = 11
      ..tilt = 90
      ..center = latLang;
    final elem = DivElement()
      ..id = htmlId
      ..style.width = "100%"
      ..style.height = "100%"
      ..style.border = "none";

    final map = GMap(elem, mapOptions);
    Marker(MarkerOptions()
      ..position = latLang
      ..map = map
      ..title = 'My position');
    /*Marker(MarkerOptions()
      ..position = LatLng(12.9557616, 77.7568832)
      ..map = map
      ..title = 'My position');
    Polyline(PolylineOptions()
    ..path=langList
    ..map=map
    ..strokeColor='red'
    ..strokeOpacity=90);*/
    return elem;
  }); */
  //creates a platform view for Flutter Web
  return HtmlElementView(
    viewType: htmlId,
  );
}