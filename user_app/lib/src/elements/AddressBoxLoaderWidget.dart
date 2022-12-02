import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class AddressBoxLoaderWidget extends StatelessWidget {
   AddressBoxLoaderWidget({Key key}) : super(key: key);
  var shimmerColor = Colors.grey[300];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left:10,right:10,top:15),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('SELECT DELIVERY LOCATION',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
              SizedBox(height:20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Align(
                        alignment:Alignment.topLeft,
                        child:Icon(Icons.location_on_outlined,size:30)
                    ),
                    Expanded(
                        child:Container(
                            padding: EdgeInsets.only(left:10),
                            child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  Text('Please Wait...',style:Theme.of(context).textTheme.headline3),

                                ]
                            )

                        )
                    )
                  ]
              ),
              SizedBox(height:20),
              Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: shimmerColor,
                period: Duration(seconds: 2),
                child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Container(
                          decoration: BoxDecoration(
                              color: shimmerColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          height: 10,
                          width: double.infinity,
                          padding: EdgeInsets.only(right:30),
                          child:Text('',
                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(top:10),
                          decoration: BoxDecoration(
                              color: shimmerColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          height: 10,
                          width: 200,
                          padding: EdgeInsets.only(right:30),
                          child:Text('',
                          )
                      ),
                      Container(
                        margin: EdgeInsets.only(top:15),
                        width: double.infinity,
                        height:45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: shimmerColor,
                        ),

                      )
                    ]),
              )
            ]
        )

    );
  }
}
