
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/category_List.dart';




// ignore: must_be_immutable
class CategoryBoxWidget extends StatefulWidget {
  CategoryListModel categoryData;
  CategoryBoxWidget({Key key, this.categoryData}) : super(key: key);
  @override
  _CategoryBoxWidgetState createState() => _CategoryBoxWidgetState();
}

class _CategoryBoxWidgetState extends State<CategoryBoxWidget> {


  @override
  void initState() {
    imageCache.clear();

    super.initState();

  }



  @override
  Widget build(BuildContext context) {

    return Stack(

      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
          onTap: () {

          },

          child:  FadeInImage.assetNetwork(
            placeholder: 'assets/img/loading_trend.gif',
            image: widget.categoryData.image,
            height: 120, width: 150, fit: BoxFit.cover,
            imageErrorBuilder: (c, o, s) => Image.asset('assets/img/loading_trend.gif', height: 120, width: 150, fit: BoxFit.cover),
          ),




          )

        ),
        Positioned(
            top: 8.0,
            right: 5.0,


            child:Icon(Icons.more_vert,color:Colors.white)
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),

          child:Container(
            alignment: Alignment.bottomCenter,

            /* background black light to dark gradient color */

            child: Stack(
              children: [

                Container(
                  alignment: Alignment.bottomCenter,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      begin: const Alignment(0.0, -1.0),
                      end: const Alignment(0.0, 0.6),
                      colors: <Color>[
                        const Color(0x8A000000).withOpacity(0.0),

                        const Color(0x8A000000).withOpacity(0.9),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
            //gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),

        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            widget.categoryData.categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],


    );


  }



}



