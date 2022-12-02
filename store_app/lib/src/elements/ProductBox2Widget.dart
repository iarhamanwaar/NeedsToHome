import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';



class ProductBox2Widget extends StatefulWidget {
  @override
  _ProductBox2WidgetState createState() => _ProductBox2WidgetState();
}

class _ProductBox2WidgetState extends State<ProductBox2Widget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(
        left: size.width > 800 ? 10 : 10,
        top: 5,
        right: size.width > 800 ? 10 : 0,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          1,
              (index) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, right: 10),
                      child: Image(
                        image: AssetImage(
                          'assets/img/excel.png',
                        ),
                        fit: BoxFit.fitHeight,
                        width: 60,
                        height: 90,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 2, right: 5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        'Ariel Complete Detergent Powder',
                                        overflow: TextOverflow.fade,
                                        maxLines: 2,
                                        softWrap: true,
                                      )),
                                  Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      children: [
                                        Text('Rs.200',
                                            style: Theme.of(context).textTheme.headline3),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, top: 4),
                                          child: Text('Rs.250',
                                            style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(decoration: TextDecoration.lineThrough)),
                                          ),
                                        ),
                                      ]),
                                  SizedBox(height: 3),
                                  /*   Text(
                                    '${widget.choice..toString()} % ${S.of(context).offer}',
                                    style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(
                                    color: Theme.of(context).accentColor,
                                    )),
                                    ), */
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          AvailableQuantityHelper.exit(context);
                                        },
                                        child: Container(
                                            height: 30,
                                            width: 100,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[300],
                                                )),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text('ddf'),
                                                Icon(Icons.arrow_drop_down,
                                                    size: 19,
                                                    color: Colors.grey)
                                              ],
                                            )),
                                      ),
                                      InkWell(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 7),
                                            child: Container(
                                                alignment: Alignment.centerRight,
                                                height: 30,
                                                /*width: MediaQuery.of(context).size.width * 0.25,*/
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      S.of(context).add,
                                                      style: TextStyle(color: Colors.transparent),
                                                    ),
                                                    Text( S.of(context).add,
                                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).primaryColorLight, fontWeight: FontWeight.w600))),
                                                    SizedBox(width: 5),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                            bottomRight: Radius.circular(5),
                                                            topRight: Radius.circular(5)),
                                                        color: Theme.of(context).colorScheme.secondary,
                                                      ),
                                                      height: double.infinity,
                                                      width: 30,
                                                      child: IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(Icons.add),
                                                          iconSize: 18,
                                                          color: Theme.of(context).primaryColorLight),
                                                    )
                                                  ],
                                                )),
                                          ))
                                      /*InkWell(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Wrap(
                                              alignment: WrapAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                      Icons.remove_circle,
                                                      color: Theme.of(context).colorScheme.secondary,
                                                      size: 27),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.022,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 5),
                                                  child: Text('1',
                                                      style: Theme.of(context).textTheme.bodyText1),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.022,
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                      Icons.add_circle,
                                                      color: Theme.of(context).colorScheme.secondary,
                                                      size: 27),
                                                ),
                                              ]),
                                        ),
                                      ),*/
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: Text(
                                          'Customizable',
                                          style: Theme.of(context).textTheme.caption,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ]

                        /*       return _variantData.selected?*/

                      ),
                    ),
                  ),
                ]);
          },
        ),
      ),
    );
  }
}




















class AvailableQuantityHelper {
  static exit(context) => showDialog(
      context: context, builder: (context) => AvailableQuantityPopup());
}

// ignore: must_be_immutable
class AvailableQuantityPopup extends StatefulWidget {
  @override
  _AvailableQuantityPopupState createState() => _AvailableQuantityPopupState();
}

class _AvailableQuantityPopupState extends State<AvailableQuantityPopup> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, size),
      insetPadding: EdgeInsets.only(
        top: size.width > 769 ? size.height * 0.1 : size.height * 0.09,
        left: size.width > 769 ? size.width * 0.32 : size.width * 0.09,
        right: size.width > 769 ? size.width * 0.32 : size.width * 0.09,
        bottom: size.width > 769 ? size.height * 0.1 : size.width * 0.09,
      ),
    );
  }

  _buildChild(BuildContext context, Size size) => SingleChildScrollView(
    child: Container(
      height: size.width > 769 ? size.height * 0.3 : null,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Column(
        children: <Widget>[
          Padding(
            padding:
            EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Text('Available Quantity',
                style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.w500)),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  )),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
            child: Text(
              'gsg',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .merge(TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          ListView.separated(
            itemCount: 2,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                // ignore: deprecated_member_use
                child: FlatButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(10),
                  color: Theme.of(context).backgroundColor.withOpacity(0.8),
                  child: RichText(
                    text: new TextSpan(children: [
                      TextSpan(
                        text: '1',
                        style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.white,)),
                      ),
                      TextSpan(
                          text: 'ahg',
                          style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.white, decoration: TextDecoration.lineThrough))),
                      TextSpan(
                          text: 'dn',
                          style: Theme.of(context).textTheme.headline1.merge(TextStyle(color: Colors.white,)))
                    ]),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      )),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}
