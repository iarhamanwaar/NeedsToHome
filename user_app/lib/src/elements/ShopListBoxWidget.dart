import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/elements/NoShopFoundWidget.dart';
import 'package:multisuperstore/src/elements/RectangularLoaderWidget.dart';
import '../controllers/vendor_controller.dart';
import '../Widget/custom_divider_view.dart';
import 'ShopListWidget.dart';

// ignore: must_be_immutable
class ShopListBoxWidget extends StatefulWidget {
  VendorController con;
  String pageTitle;
  int shopType;
  int focusId;
  String previewImage;
  ShopListBoxWidget({Key key,  this.con, this.pageTitle,this.shopType, this.focusId, this.previewImage}) : super(key: key);
  @override
  _ShopListBoxWidgetState createState() => _ShopListBoxWidgetState();
}

class _ShopListBoxWidgetState extends State<ShopListBoxWidget> with AfterLayoutMixin<ShopListBoxWidget>{
  bool ratingOne = false;

  List<ShopFilter> superFilter;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {


    return widget.con.vendorList.isEmpty?RectangularLoaderWidget():Container(
      child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                child: Text(widget.pageTitle, style: Theme.of(context).textTheme.headline1)),
            Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                child: Text('${S.of(context).fast_on_authentic} ${widget.pageTitle}', style: Theme.of(context).textTheme.caption)),
            CustomDividerView(dividerHeight: 1.0, color: Theme.of(context).dividerColor),

          Container(
              height:50,
              child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: superFilter.length,
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.only(right:10),
                  itemBuilder: (context, index) {
                    ShopFilter _filterData = superFilter.elementAt(index);

                    return  Container(
                          margin:EdgeInsets.only(left:3),
                          padding: EdgeInsets.only(top:10,bottom:5,left:4,),
                          child:Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.grey[300],
                                      width: 1,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              height: 40,
                              elevation: 0,
                              color: _filterData.selected?Colors.red:Colors.white38,
                              child: Center(
                               child:  Container(
                                   padding: EdgeInsets.only(right:5,left:5),
                                   child:Text(_filterData.type,
                                       textAlign: TextAlign.center,
                                       style:TextStyle(fontFamily:'Touche W03 Regular',fontWeight: _filterData.selected?FontWeight.bold:FontWeight.w500,color:_filterData.selected?Colors.white:Theme.of(context).backgroundColor)
                                   )
                               ),
                              ),
                              onPressed: () {

                                superFilter.forEach((_l) {
                                  setState(() {
                                    _l.selected = false;
                                  });
                                });
                                _filterData.selected = true;
                                   print( _filterData.selected);
                                setState(() {

                                 widget.con.tempVendorList = widget.con.shopFilter(widget.con.vendorList,_filterData.value);
                                });

                              },
                            ),)

                    );
                  }
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.con.notFound? Text(''): Expanded(
                      child: Text('${ widget.con.tempVendorList.length} ${S.of(context).stores_near_by}',
                          style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).backgroundColor))),
                    ),
                    /**  Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Icon(Icons.filter_list, size: 19),
                        ),
                        SizedBox(width: 8),
                        Text('SORT/FILTER', style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).backgroundColor))) */
                  ],
                ),
              ),
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: widget.con.tempVendorList.length,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, int index) {

                return  widget.con.tempVendorList[index].shopId=='no_data'?NoShopFoundWidget():ShopList(choice: widget.con.tempVendorList[index], shopType: widget.shopType,focusId: widget.focusId,previewImage: widget.previewImage,);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 0);
              },
            ),
            SizedBox(height: 50)
          ])),
    );
  }


  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
          superFilter   = <ShopFilter>[
      ShopFilter( type: 'All', selected: true, value: 'All'),
      ShopFilter( type: 'Opened Shop', selected: false, value: 'Opened Shop'),
      ShopFilter( type: S.of(context).rating, selected: false, value:'Rating'),
      ShopFilter( type: S.of(context).takeaway, selected: false, value: 'Takeaway'),
      ShopFilter( type: S.of(context).distance, selected: false, value: 'Distance'),
      ShopFilter( type: S.of(context).delivery_time, selected: false, value: 'Delivery Time'),
    ];

  }
}




class ShopFilter  {
  ShopFilter({this.type, this.selected, this.value});
  String type;
  bool selected;
  String value;
}

