import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends StateMVC<PushNotification>  with SingleTickerProviderStateMixin{
  bool isSwitched = false;
  int dropDownValue = 0;
  String _value = 'User';
  bool status = false;
  TabController _tabController;

   SecondaryController _con;
  _PushNotificationState() : super(SecondaryController()) {
    _con = controller;
  }


  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    super.initState();
    if(GetPlatform.isDesktop){
      Helper.fireBaseDeskTopCon();
    }

    _con.pushNotificationData.userType = 'User';
  }


  @override
  void dispose() {
    _con.controllerTitle.dispose();
    _con.controllerText.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child:ListView(
          scrollDirection: Axis.vertical,
          children: [

            Responsive(
                children:[
                  Form(
                    key: _con.generalFormKey,
                  child:Padding(
                      padding: EdgeInsets.all(0),
                      child: Div(
                          colS:12,
                          colM:12,
                          colL:12,
                          child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                             Wrap(
                               children: [
                                 Div(
                                   colS:12,
                                   colM:12,
                                   colL:6,
                                   child:Container(
                                     margin:EdgeInsets.only(left:20,top:20,right:20,bottom:20),
                                     padding: EdgeInsets.all(27),
                                     decoration:BoxDecoration(
                                         color:Theme.of(context).primaryColor,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                     child:Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                                             Text(S.of(context).push_notification,style:Theme.of(context).textTheme.headline4),
                                           ],
                                         ),
                                         SizedBox(height: 15),
                                         Padding(
                                           padding: EdgeInsets.only(top:10),
                                           child:Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(S.of(context).select_your_user,
                                                 style:  Theme.of(context).textTheme.bodyText1.merge(TextStyle(color:Colors.grey)),
                                               ),
                                               DropdownButton(
                                                   value: _value,
                                                   isExpanded: true,
                                                   focusColor: Theme.of(context).colorScheme.secondary,
                                                   style:Theme.of(context).textTheme.subtitle1,
                                                   underline: Container(

                                                     height: 1,
                                                     color: Colors.grey,
                                                   ),
                                                   items: [
                                                     DropdownMenuItem(
                                                       child: Text(S.of(context).users),
                                                       value: 'User',
                                                     ),
                                                     DropdownMenuItem(
                                                       child: Text("Vendors"),
                                                       value: 'Vendor',
                                                     ),
                                                     DropdownMenuItem(
                                                       child: Text(S.of(context).driver),
                                                       value: 'Driver',
                                                     ),


                                                   ],
                                                   onChanged: (value) {
                                                     setState(() {
                                                       _value = value;
                                                     });
                                                     _con.pushNotificationData.userType =_value;
                                                    
                                                   }),
                                             ],
                                           ),

                                         ),
                                         SizedBox(height:20),
                                         Container(
                                             width: double.infinity,

                                             child: TextFormField(
                                                 textAlign: TextAlign.left,
                                                 autocorrect: true,
                                                 onSaved: (input) =>_con.pushNotificationData.title = input,
                                                 validator: (input) =>  input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                                 keyboardType: TextInputType.text,
                                                 controller: _con.controllerTitle,
                                                 onChanged: (e){

                                                 },
                                                 decoration: InputDecoration(
                                                   labelText: S.of(context).notification_title,
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
                                         SizedBox(height: 20),

                                         Text(S.of(context).notification_text,style: Theme.of(context).textTheme.headline1,),
                                         SizedBox(height: 10),
                                         Container(
                                           decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(6),
                                             color: Theme.of(context).dividerColor,
                                           ),
                                           child: Padding(
                                             padding: const EdgeInsets.all(10.0),
                                             child: TextFormField(
                                               maxLines: 5,
                                               onSaved: (input) =>_con.pushNotificationData.message = input,
                                               validator: (input) =>  input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                                               controller: _con.controllerText,
                                               decoration: InputDecoration.collapsed(
                                                 hintText: S.of(context).notification_text,
                                                 hintStyle: Theme.of(context)
                                                     .textTheme
                                                     .bodyText2
                                                     .merge(TextStyle(color: Colors.grey)),
                                               ),
                                             ),
                                           ),
                                         ),
                                         SizedBox(height:20),
                                         Container(
                                           width: size.width > 670 ? 180:200,
                                           height: size.height > 670 ? 180: 200,
                                           child:  GestureDetector(
                                                   onTap: () {
                                                     Imagepickerbottomsheet();
                                                   },
                                                   child: _image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                   height: double.infinity,
                                                   width:double.infinity,
                                                   fit:BoxFit.fill
                                               ): GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                                         ), ),

                                         SizedBox(height: 40),
                                         InkWell(
                                             onTap: () {},
                                             child: Container(
                                               color: Theme.of(context).primaryColor,
                                               padding:EdgeInsets.only(left:size.width * 0.05,right:size.width * 0.05),
                                               child: Container(
                                                 width: double.infinity,
                                                 height: 45.0,
                                                 decoration: BoxDecoration(
                                                   color: Theme.of(context).colorScheme.secondary,
                                                   borderRadius: BorderRadius.circular(30),
                                                   /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                                 ),
                                                 // ignore: deprecated_member_use
                                                 child: FlatButton(
                                                   onPressed: () {
                                                       _con.sendPushNotification();
                                                   },
                                                   child: Center(
                                                       child: Text(
                                                         S.of(context).submit,
                                                         style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                       )),
                                                 ),
                                               ),
                                             ))




                                       ],
                                     ),

                                   ),
                                 ),

                                 Div(
                                     colS:12,
                                     colM:12,
                                     colL:6,
                                   child:Container(
                                     margin:EdgeInsets.only(top:20,bottom:20,left:20,right:20),
                                     padding: EdgeInsets.all(27),
                                     decoration:BoxDecoration(
                                         color:Theme.of(context).primaryColor,
                                         borderRadius: BorderRadius.circular(10)
                                     ),
                                       child: Column(

                                         children: [
                                           TabBar(
                                             controller: _tabController,
                                             indicatorColor: Color(0xFF5e078e),
                                             unselectedLabelColor: Colors.grey,
                                             //labelColor: Colors.black,
                                             labelStyle: Theme.of(context).textTheme.bodyText1,
                                             tabs: [
                                               Tab(
                                                 child: Text(S.of(context).initial_state),
                                               ),
                                               Tab(
                                                 child: Text(S.of(context).expanded_view),
                                               ),

                                             ],
                                           ),
                                           SizedBox(
                                             height: 500,
                                             child: TabBarView(
                                               controller: _tabController,
                                               physics: NeverScrollableScrollPhysics(),
                                               children: [
                                                 Container(
                                                   padding:EdgeInsets.only(left:20,right:20,top:20,bottom:20),
                                                   child:SingleChildScrollView(
                                                     child:Column(
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         children:[

                                                               Text(S.of(context).device_preview,style: Theme.of(context).textTheme.headline3,),
                                                                     SizedBox(height:20),

                                                                     Stack(
                                                                       alignment: Alignment.center,
                                                                       children: [
                                                                         Image(image:AssetImage('assets/img/android.png'),
                                                                             width:size.width,
                                                                             height:160,
                                                                             fit: BoxFit.fill,
                                                                         ),

                                                                           Container(
                                                                             margin: EdgeInsets.only(top:55,left:25,right:25),
                                                                               padding:EdgeInsets.all(8),
                                                                               width:size.width,
                                                                               height:95,
                                                                               decoration:BoxDecoration(
                                                                                   color:Theme.of(context).primaryColor,

                                                                               ),
                                                                               child:Column(
                                                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                                                 children:[

                                                                                   SizedBox(height:10),
                                                                                   Row(
                                                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                                                     children:[
                                                                                       Expanded(
                                                                                         child:Column(
                                                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                                                           children: [
                                                                                             Text(_con.controllerTitle.text,overflow:TextOverflow.ellipsis,maxLines: 1),
                                                                                             Text(_con.controllerText.text,overflow:TextOverflow.ellipsis,maxLines: 1),
                                                                                           ],
                                                                                         ),
                                                                                       ),
                                                                                       SizedBox(width:20),
                                                                                       Container(
                                                                                         width: size.width > 670 ? 60:60,
                                                                                         height: size.height > 670 ? 60: 60,
                                                                                         child: GestureDetector(
                                                                                             onTap: () {

                                                                                             },
                                                                                             child:_image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                                                                 height: double.infinity,
                                                                                                 width:double.infinity,
                                                                                                 fit:BoxFit.fill
                                                                                             ):GetPlatform.isWeb?Image.network(_image.path):Image.file(_image)),
                                                                                       ),
                                                                                     ]
                                                                                   ),



                                                                                 ]
                                                                               ),
                                                                           ),

                                                                       ],
                                                                     ),




                                                         ]
                                                     ),
                                                   ),
                                                 ),
                                                 Container(
                                                     padding:EdgeInsets.only(left:20,right:20,top:20,bottom:20),
                                                     child:SingleChildScrollView(
                                                         child:Column(
                                                             crossAxisAlignment: CrossAxisAlignment.start,
                                                             children:[
                                                               Text(S.of(context).device_preview,style: Theme.of(context).textTheme.headline3,),
                                                               SizedBox(height:20),

                                                               Stack(
                                                                 alignment: Alignment.center,
                                                                 children: [
                                                                   Column(
                                                                     mainAxisAlignment:MainAxisAlignment.end,
                                                                     children:[
                                                                       Image(image:AssetImage('assets/img/android.png'),
                                                                         width:size.width,
                                                                         height:280,
                                                                         fit: BoxFit.fill,
                                                                       ),
                                                                     ]
                                                                   ),


                                                                   Container(
                                                                     margin: EdgeInsets.only(top:105,left:26,right:26),
                                                                     padding:EdgeInsets.all(8),
                                                                     width:size.width,
                                                                     height:180,
                                                                     decoration:BoxDecoration(
                                                                       color:Theme.of(context).primaryColor,

                                                                     ),
                                                                     child:Column(
                                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                                         children:[
                                                                           Text(_con.controllerTitle.text,overflow:TextOverflow.ellipsis,maxLines: 1),
                                                                           Text(_con.controllerText.text,overflow:TextOverflow.ellipsis,maxLines: 1),
                                                                           SizedBox(height:10),
                                                                           Row(
                                                                               mainAxisAlignment: MainAxisAlignment.center,
                                                                               children:[
                                                                                 Container(
                                                                                   width: size.width > 670 ? 100:150,
                                                                                   height: size.height > 670 ? 80: 80,
                                                                                   child: GestureDetector(
                                                                                       onTap: () {

                                                                                       },
                                                                                       child:_image == null?Image(image:AssetImage('assets/img/image_placeholder.png'),
                                                                                           height: double.infinity,
                                                                                           width:double.infinity,
                                                                                           fit:BoxFit.fill
                                                                                       ):GetPlatform.isWeb?Image.network(_image.path):Image.file(_image)),
                                                                                 ),
                                                                               ]
                                                                           ),



                                                                         ]
                                                                     ),
                                                                   ),

                                                                 ],
                                                               ),


                                                             ]
                                                         )
                                                     )
                                                 ),

                                               ],
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),


                                 )
                               ],
                             ),






                              ]
                          )

                      )
                  ),
                  ),
                ]
            )
            // SideCard(),
          ],
        ));


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
                  onTap: () => getImage(),
                ),
                new ListTile(
                  leading: new Icon(Icons.image),
                  title: new Text(S.of(context).gallery),
                  onTap: () => getImagegaller(),
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
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          _con.pushNotificationData.uploadImage = pickedFile;
          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.pushNotificationData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
          _con.pushNotificationData.uploadImage = pickedFile;

          Navigator.of(context).pop();
        } else {
          print('No image selected.');
        }
      });
    }else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        _con.pushNotificationData.uploadImage = _image;
      });

      Navigator.of(context).pop();
    }
  }


}


