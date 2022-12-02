import 'package:flutter/material.dart';
import 'package:multisuperstore/src/models/shop_rating.dart';


// ignore: must_be_immutable
class ReviewBox1 extends StatefulWidget {
  ShopRatingModel review;
  ReviewBox1({Key key,this.review});
  @override
  _ReviewBox1State createState() => _ReviewBox1State();
}

class _ReviewBox1State extends State<ReviewBox1> {


  bool viewMore =true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          /*boxShadow: [
              BoxShadow(
                color: Theme.of(context).backgroundColor.withOpacity(0.1),
                blurRadius: 3.0,
                spreadRadius: 1.5,
              ),
            ]*/
        ),

        child:ClipRRect(
          //borderRadius: BorderRadius.all(Radius.circular(10)),
          borderRadius: BorderRadius.circular(15),
          child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),),
              child:Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 66,
                        width:66,
                        margin: EdgeInsets.only(top:10,),
                        alignment: Alignment.bottomRight,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:Theme.of(context).primaryColor,
                        ),
                        child:ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child:
                            (widget.review.image=='no_image')?
                            Image.asset('assets/img/userImage.png', height: 66,width:66,
                              fit: BoxFit.cover,):
                            Image.network(widget.review.image, height: 66,width:66,
                              fit: BoxFit.cover,
                            )
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left:10,right:10,top:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Container(
                                    padding: EdgeInsets.only(top:3),
                                    child:Text(
                                      widget.review.buyer,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),),

                                  Container(
                                    padding:EdgeInsets.only(top:4),
                                    child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children:[
                                          Container(
                                              padding:EdgeInsets.only(top:2,right:5),
                                              child:Wrap(
                                                  children:[
                                                    Container(
                                                      padding:EdgeInsets.only(top:3,right:5),
                                                      child: Text(widget.review.rate.toString(),
                                                          style:Theme.of(context).textTheme.caption.
                                                          merge(TextStyle(height:1.0,color:Theme.of(context).backgroundColor.withOpacity(0.6)))
                                                      ),
                                                    ),
                                                    Icon(Icons.star,color:Colors.orange,size:18),
                                                  ]
                                              )
                                          ),
                                          Container(
                                              padding:EdgeInsets.only(top:2,left:10),
                                              child:Text('1 weak ago',
                                                  style:Theme.of(context).textTheme.caption.
                                                  merge(TextStyle(height:1.0,color:Theme.of(context).backgroundColor.withOpacity(0.6)))
                                              )
                                          ),


                                        ]
                                    ),),

                                  SizedBox(height:size.height * 0.01),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(top:5,left:5,right:5,bottom:5),
                      child:Text(widget.review.message,
                          overflow: viewMore ? TextOverflow.ellipsis : TextOverflow.visible,maxLines:viewMore ?  4 : null,
                          style:Theme.of(context).textTheme.caption
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if(viewMore) {
                              viewMore = false;
                            } else{
                              viewMore = true;
                            }
                          });
                        },
                        child: Container(
                            padding: EdgeInsets.only(top:5,left:5,right:5,bottom:5),

                            child:Text(viewMore ?'View more': 'View Less',style: TextStyle(color: Theme.of(context).primaryColorDark),)
                        ),),
                    ],
                  ),



                ],
              )
          ),



        )
    );
  }
}
