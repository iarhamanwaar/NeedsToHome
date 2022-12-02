
import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/models/topproducts.dart';


// ignore: must_be_immutable
class ProductBoxWidget extends StatefulWidget {
  ProductBoxWidget({Key key, this.topProduct}) : super(key: key);
  TopProduct topProduct;
  @override
  _ProductBoxWidgetState createState() => _ProductBoxWidgetState();
}

class _ProductBoxWidgetState extends State<ProductBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.only(left:0),
        height: 200.0,
        child:Padding(
          padding: const EdgeInsets.only(left: 20, right: 10),
          child: AspectRatio(
            aspectRatio: 0.8,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 5.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      image: widget.topProduct.image=='no_image'?AssetImage('assets/img/grocerydefaultbg.jpg'):
                      NetworkImage(widget.topProduct.image),
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

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
                      top: 8.0,
                      left: 8.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Text(widget.topProduct.count,style: TextStyle(color: Colors.white),),
                      )),
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    right: 8.0,
                    child: Text(
                      widget.topProduct.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );



  }

}


class ProfileAvatar extends StatelessWidget {
  final bool isActive;
  final bool hasBorder;
  final String imageUrl;
  const ProfileAvatar({
    Key key,
    @required this.imageUrl,
    this.isActive = false,
    this.hasBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 20.0,
            //backgroundColor: Palette.facebookBlue,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image(
                image: NetworkImage(imageUrl),
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            /*child: CircleAvatar(
            radius: hasBorder ? 17.0 : 20.0,
            backgroundColor: Colors.grey[200],
            backgroundImage: CachedNetworkImageProvider(imageUrl),
            //backgroundImage:
          ),*/
          ),
        ),
        Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 2.0,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
