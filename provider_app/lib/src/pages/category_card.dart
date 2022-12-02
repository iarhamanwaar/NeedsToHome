import 'package:flutter/material.dart';
import 'constants.dart';

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String mainTitle;
  final String title;
  final Function press;
  const CategoryCard({
    Key key,
    this.svgSrc,
    this.title,
    this.mainTitle,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(1),
                    margin: EdgeInsets.only(right: 9),
                    width: 70.0,
                    height: 70.0,
                    child: Image(
                      image: AssetImage(svgSrc),
                      height: 10,
                      width: 10,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .merge(TextStyle(fontWeight: FontWeight.w400))),
                  SizedBox(height: 5),
                  Text(mainTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
