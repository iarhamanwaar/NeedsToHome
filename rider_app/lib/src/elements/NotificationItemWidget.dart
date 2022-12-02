import 'package:flutter/material.dart';
import '../helpers/swipe_widget.dart';


// ignore: must_be_immutable
class NotificationItemWidget extends StatelessWidget {
  VoidCallback onMarkAsRead;
  VoidCallback onMarkAsUnRead;
  VoidCallback onRemoved;

  NotificationItemWidget(
      {Key key, this.onMarkAsRead, this.onMarkAsUnRead, this.onRemoved})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return OnSlide(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      items: <ActionItems>[
        ActionItems(
            icon: new Icon(
              Icons.brightness_1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPress: () {},
            backgroudColor: Theme.of(context).scaffoldBackgroundColor),
        new ActionItems(
            icon: Padding(
              padding: const EdgeInsets.only(right: 10),
              child:
                  new Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
            ),
            onPress: () {
              onRemoved();
            },
            backgroudColor: Theme.of(context).scaffoldBackgroundColor),
      ],
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Theme.of(context).focusColor.withOpacity(0.7),
                            Theme.of(context).focusColor.withOpacity(0.05),
                          ])),
                  child: Icon(
                    Icons.notifications,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 40,
                  ),
                ),
                Positioned(
                  right: -30,
                  bottom: -50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
                Positioned(
                  left: -20,
                  top: -50,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'hhfg',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .merge(TextStyle(fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    '20-2-20',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
