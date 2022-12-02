import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';


// ignore: must_be_immutable
class RatingCircleWidget extends StatefulWidget {
  int rate;
  RatingCircleWidget({Key key,this.rate});
  @override
  _RatingCircleWidgetState createState() => _RatingCircleWidgetState();
}

class _RatingCircleWidgetState extends State<RatingCircleWidget> {



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Div(
                colS:6,
                colM:6,
                colL:6,
                child:Container(
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          new CircularPercentIndicator(
                            radius: 80.0,
                            lineWidth: 5.0,
                            percent: 0.8,
                            reverse: true,
                            center: new Text("4.5",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            progressColor: Colors.green,
                          ),

                          Container(
                            padding: EdgeInsets.only(top:7,bottom:5),
                            child:SmoothStarRating(
                                allowHalfRating: false,
                                starCount: 5,
                                rating: 4,
                                size: 27.0,
                                color: Color(0xFFFEBF00),
                                borderColor: Color(0xFFFEBF00),
                                spacing: 0.0),
                          ),

                          Container(
                            child: Text('Based on 35 reviews',
                              style: Theme.of(context).textTheme.caption.merge(TextStyle(height:1.0,color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]
                    )

                )
            ),

          ],
        )
    );
  }
}


