
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/subcategory_List.dart';


// ignore: must_be_immutable
class SubCategoryBoxWidget extends StatelessWidget {
  SubCategoryListModel categoryData;
  SubCategoryBoxWidget({Key key, this.categoryData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(categoryData.image);
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image(
            image: NetworkImage(categoryData.image),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
            top: 8.0,
            right: 5.0,
            child: Icon(Icons.more_vert, color: Colors.white)),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
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
            categoryData.subcategoryName,
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
