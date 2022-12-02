
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';

import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/banner.dart';
import 'package:login_and_signup_web/src/repository/product_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

import '../components/constants.dart';
// ignore: must_be_immutable
class AEBannerWidget extends StatefulWidget{
  SecondaryController con;
  BannerModel details;
  String pageType;
  AEBannerWidget({Key key, this.con, this.details, this.pageType}) : super(key: key);
  @override
  _AEBannerWidgetState createState() => _AEBannerWidgetState();
}

class _AEBannerWidgetState extends StateMVC<AEBannerWidget> {

  // ignore: non_constant_identifier_names
  String _Type;
  String _typeDiscount='discount_upto';
  String _value;
  List<DropDownModel> dropDownList = <DropDownModel>[];
  List<DropDownModel> shopList = <DropDownModel>[];
  Future<void> listenForDropdown(table, select, column, para1) async {
    dropDownList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC(table, select, column, para1);

    stream.listen((DropDownModel _list) {
      setState(() => dropDownList.add(_list));

    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }
  @override
  void initState() {
    listenForDropdown('shop_focus', 'title', 'status', 'success');
    if(widget.pageType=='add'){
      _Type = '1';
      widget.con.bannerData.type = '1';
    } else{
      _Type = widget.details.type;
      _value=widget.details.shopType;
      widget.con.bannerData.type = widget.details.type;
      widget.con.bannerData.uploadImage = null;
      widget.con.bannerData.shopType = widget.details.shopType;
    }
    widget.con.bannerData.redirectType = 'discount_upto';

    super.initState();
  }

  Future<void> listenForShop(id) async {
    shopList.clear();
    final Stream<DropDownModel> stream = await getDropdownDataSC('vendor', 'display_name','focus_id',id);
    stream.listen((DropDownModel _list) {
      setState(() => shopList.add(_list));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      if(widget.pageType!='add') {
      //  setState(() =>  widget.con.couponData.shopId = widget.couponDetails.shopId);
        print('Shop${widget.con.couponData.shopId}');
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
        child:Div(
                     colS:12,
                     colM:8,
                     colL:6,


                       child:Dialog(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(16)
                         ),

                         elevation: 0,
                         backgroundColor: Colors.transparent,

                         insetPadding: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1,
                           left:MediaQuery.of(context).size.width * 0.09,
                           right:MediaQuery.of(context).size.width * 0.09,
                           bottom:MediaQuery.of(context).size.height * 0.05,
                         ),
                         child:Container(
                           width: double.infinity,
                           decoration: BoxDecoration(
                               color:Theme.of(context).primaryColor,
                               shape: BoxShape.rectangle,
                               borderRadius: BorderRadius.all(Radius.circular(12))
                           ),

                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Expanded(
                                 child:Container(
                               child: SingleChildScrollView(
                               child: Column(
                               children: [
                                 Row(
                                     mainAxisAlignment: MainAxisAlignment.end,
                                     children:[
                                       IconButton(
                                         icon: Icon(Icons.close),
                                         onPressed: (){
                                           Navigator.pop(context);
                                         },
                                       )

                                     ]
                                 ),


                                 SizedBox(height:10),

                                 widget.pageType=='add'?Text(S.of(context).add_banner,
                                     style: Theme.of(context).textTheme.headline4
                                 ):Text(S.of(context).edit_banner,
                                     style: Theme.of(context).textTheme.headline4
                                 ),

                                 Form(
                                     key: widget.con.bannerFormKey,
                                     child: Padding(
                                       padding: const EdgeInsets.only(right: 18, left:18),
                                       child:Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:[
                                             (widget.pageType=='edit' && widget.details.type=='3')?
                                             Padding(
                                               padding: EdgeInsets.only(top: 10),
                                               child: Container(
                                                   width: double.infinity,
                                                   child: TextFormField(
                                                     //onSaved: (input) => widget.con.userData.email = input,
                                                     //controller: controllerEmail,
                                                     //validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: 'Fixed Banner',
                                                       keyboardType: TextInputType.text,
                                                       enabled: false,
                                                       decoration: InputDecoration(
                                                         labelText: S.of(context).banner,
                                                         labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.grey)),
                                                         enabledBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color: Theme.of(context).colorScheme.secondary,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                         focusedBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color: Theme.of(context).colorScheme.secondary,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                       ))),
                                             ):
                                             Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child:Container(
                                                 width: double.infinity,
                                                 child: DropdownButton(
                                                     value: _Type,
                                                     isExpanded: true,
                                                     focusColor: transparent,
                                                     underline: Container(
                                                       color: Colors.grey[300],
                                                       height: 1.0,
                                                     ),
                                                     items: [
                                                       DropdownMenuItem(
                                                         child: Text(S.of(context).top_banner),
                                                         value: '1',
                                                       ),
                                                       DropdownMenuItem(
                                                         child: Text(S.of(context).offer_banner),
                                                         value: '2',
                                                       ),
                                                      // DropdownMenuItem(child: Text("Bottom Banner"), value: '3'),
                                                     ],
                                                     onChanged: (value) {
                                                       setState(() {
                                                         _Type = value;
                                                         widget.con.bannerData.type = value;
                                                       });
                                                     }),
                                               ),
                                             ),

                                             Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child:Container(
                                                 width: double.infinity,
                                                 child: DropdownButton(
                                                     value: _typeDiscount,
                                                     isExpanded: true,
                                                     focusColor: transparent,
                                                     underline: Container(
                                                       color: Colors.grey[300],
                                                       height: 1.0,
                                                     ),
                                                     items: [
                                                       /** DropdownMenuItem(
                                                           child: Text("Offer Upto"),
                                                           value: 'offers_upto',
                                                           ), */
                                                       DropdownMenuItem(
                                                         child: Text(S.of(context).discount_upto),
                                                         value: 'discount_upto',
                                                       ),
                                                       DropdownMenuItem(
                                                         child: Text('Link to shop'),
                                                         value: 'link_to_shop',
                                                       ),
                                                       DropdownMenuItem(
                                                         child: Text('Link to item'),
                                                         value: 'link_to_item',
                                                       ),
                                                       /**DropdownMenuItem(child: Text("Bottom Banner"), value: '3'), */
                                                     ],
                                                     onChanged: (value) {
                                                       setState(() {
                                                         _typeDiscount = value;
                                                         widget.con.bannerData.redirectType = value;
                                                       });
                                                     }),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child: Column(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text(S.of(context).shop_type,style: Theme.of(context).textTheme.headline1,),
                                                   SizedBox(height:10),
                                                   Container(
                                                     width: double.infinity,
                                                     child: DropdownButton(
                                                         value: _value, //
                                                         isExpanded: true,
                                                         focusColor:transparent,
                                                         underline: Container(
                                                           color: Colors.grey[300],
                                                           height: 0.8,
                                                         ),
                                                         items: dropDownList
                                                             .map((DropDownModel map) {
                                                           return new DropdownMenuItem(
                                                             value: map.id,
                                                             child: new Text(map.name,
                                                                 style: new TextStyle(
                                                                     color: Colors.black)),
                                                           );
                                                         }).toList(),
                                                         onChanged: (value) {
                                                           setState(() {
                                                             //  _con.subcategoryData.categoryId = value;
                                                             widget.con.bannerData..shopType = value;
                                                             _value = value;
                                                           });
                                                           listenForShop(_value);
                                                         }),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top:10),


                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: widget.details.title,
                                                       onSaved: (input) =>  widget.con.bannerData.title = input,
                                                       validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: S.of(context).title,
                                                         labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                         enabledBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color: Colors.grey,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                         focusedBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color:
                                                             Theme.of(context).colorScheme.secondary,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                       ))),
                                             ),

                                             SizedBox(height: 10),

                                             _typeDiscount=='discount_upto'?Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: widget.details.para,
                                                       onSaved: (input) =>  widget.con.bannerData.para = input,
                                                       validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: '${S.of(context).discount} (%)',
                                                         labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                         enabledBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color: Colors.grey,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                         focusedBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color:
                                                             Theme.of(context).colorScheme.secondary,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                       ))),
                                             ):_typeDiscount=='link_to_item'?Padding(
                                               padding: EdgeInsets.only(top:10),
                                               child: Container(
                                                   width: double.infinity,

                                                   child: TextFormField(
                                                       textAlign: TextAlign.left,
                                                       autocorrect: true,
                                                       initialValue: widget.details.para,
                                                       onSaved: (input) =>  widget.con.bannerData.para = input,
                                                       validator: (input) => input.length < 1 ? S.of(context).please_enter_your_category : null,
                                                       keyboardType: TextInputType.text,
                                                       decoration: InputDecoration(
                                                         labelText: 'Item Name',
                                                         labelStyle: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color:Colors.grey)),
                                                         enabledBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color: Colors.grey,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                         focusedBorder: UnderlineInputBorder(
                                                           borderSide: BorderSide(
                                                             color:
                                                             Theme.of(context).colorScheme.secondary,
                                                             width: 1.0,
                                                           ),
                                                         ),
                                                       ))),
                                             ):_typeDiscount=='link_to_shop'?

                                                       Container(
                                                         padding: EdgeInsets.only(top:10),
                                                         child:Container(
                                                           width: double.infinity,
                                                           child: DropdownButtonFormField(
                                                             value:  widget.con.couponData.shopId,
                                                             isExpanded: true,
                                                             onChanged: (value) {
                                                               setState(() {
                                                                 widget.con.couponData.shopId = value;
                                                               });
                                                               widget.con.bannerData.para = value;
                                                             },
                                                             focusColor:transparent,
                                                             hint: Text('Select your shop'),

                                                             items:  shopList.map((DropDownModel map) {
                                                               return new DropdownMenuItem(
                                                                 value: map.id,
                                                                 child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                               );
                                                             }).toList(),

                                                           ),
                                                         ),
                                                       )
                                            :Container(),

                                             SizedBox(height: 20),

                                             Text(
                                               S.of(context).select_your_banner,
                                               style: Theme.of(context).textTheme.bodyText1,
                                             ),
                                             SizedBox(height: 10),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 widget.pageType=='add'?Container(
                                                   alignment: Alignment.center,
                                                   width: 150,
                                                   height: 150,
                                                   child: GestureDetector(
                                                     onTap: () {
                                                       Imagepickerbottomsheet();
                                                     },
                                                     child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                       height: double.infinity,
                                                       width:double.infinity,
                                                       fit: BoxFit.fill,
                                                     ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),),
                                                 ):Container(
                                                   color: Theme.of(context).primaryColor,
                                                   alignment: Alignment.center,
                                                   width: 150,
                                                   height: 150,
                                                   child: GestureDetector(
                                                     onTap: () {
                                                       Imagepickerbottomsheet();
                                                     },
                                                     child: _image == null?Image(image:NetworkImage(widget.details.uploadImage),
                                                       height: double.infinity,
                                                       width:double.infinity,
                                                       fit: BoxFit.fill,
                                                     ):GetPlatform.isWeb? Image.network(_image.path):Image.file(_image),),
                                                 ),
                                               ],
                                             ),

                                             SizedBox(height:20),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                               children: [
                                                 // ignore: deprecated_member_use
                                                 FlatButton(
                                                   onPressed: () {
                                                     widget.pageType=='add'?widget.con.addBanner(context,'do_add','null'):widget.con.addBanner(context,'update',widget.details.id);
                                                   },
                                                   padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                                   color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                                   shape: StadiumBorder(),
                                                   child: Text(
                                                       S.of(context).submit,
                                                     style: Theme.of(context).textTheme.headline6.merge(
                                                         TextStyle(
                                                             color: Theme.of(context)
                                                                 .primaryColorLight)),
                                                   ),
                                                 ),
                                               ],
                                             ),

                                         SizedBox(height:30),
                                       ]
                                   ),

                                 ),
                                 ),
                               ]
                               ),
                               ),
                                 )
                               ),




                             ],
                           ),
                       ),
                       ),

                   )

    );


  }





  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.camera),
                  title: new Text(S.of(context).camera),
                  onTap: () =>  getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () =>getImagegaller(),
                ),
              ],
            ),
          );
        });
  }

  File _image;
  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    if(GetPlatform.isWeb || GetPlatform.isMobile){
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          if (GetPlatform.isMobile) {
            widget.con.bannerData.uploadImage = _image;
          } else if (GetPlatform.isWeb) {
            widget.con.bannerData.uploadImage = pickedFile;
          }
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }  else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.bannerData.uploadImage = _image;
      });
      print(_image);
      Navigator.of(context).pop();

    }
  }

  Future getImagegaller() async {
    if(GetPlatform.isWeb || GetPlatform.isMobile){
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          if (GetPlatform.isMobile) {
            widget.con.bannerData.uploadImage = _image;
          } else if (GetPlatform.isWeb) {
            widget.con.bannerData.uploadImage = pickedFile;
          }

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }  else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        widget.con.bannerData.uploadImage = _image;
      });
      Navigator.of(context).pop();
    }
  }





}
