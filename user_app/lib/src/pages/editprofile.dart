import 'dart:io';
import 'package:multisuperstore/src/repository/settings_repository.dart';
import '../repository/user_repository.dart' as userRepo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:multisuperstore/src/controllers/user_controller.dart';
import 'package:multisuperstore/src/elements/LocationWidget.dart';
import 'package:multisuperstore/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../Widget/custom_divider_view.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {


  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends StateMVC<EditProfile> {

  UserController _con;
  _EditProfileState() : super(UserController()) {
    _con = controller;

  }


  @override
  void initState() {
    // TODO: implement initState
    // _con.listenForVendorList(widget.storeType, widget.focusId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Stack(
          children:[
            CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: false,
                  delegate: SliverCustomHeaderDelegate(
                    collapsedHeight: 50,
                    expandedHeight: 150,
                    paddingTop: MediaQuery.of(context).padding.top,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    ProfileFormWidget(con: _con,),
                  ]),
                ),
              ],
            ),
            Column(
                children:[
                  Align(
                    alignment: Alignment.topLeft,
                    child:Padding(
                        padding: EdgeInsets.only(top:60,left:10),
                        child:Row(
    children:[
      Container(
        width:40,height:40,
        child:IconButton(
            onPressed: (){
              Navigator.pop(context, true);
            },
            icon:Icon(Icons.arrow_back_ios,),
            color:Colors.white
        ),
      ),

    ]
    )


                    ),
                  ),
                ]
            )
          ]
      ),
    );
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;


  String statusBarMode = 'dark';

  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,

  });

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if (shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 300).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/img/grocerydefaultbg.jpg',
            height: MediaQuery.of(context).size.height / 0.5,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  padding: EdgeInsets.only(top: 5),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children:[
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.arrow_back_ios,color: this.makeStickyHeaderTextColor(shrinkOffset, false),),
                            ),
                            Container(
                              padding: EdgeInsets.only(top:8),
                              child:Text(S.of(context).edit,
                              style: Theme.of(context).textTheme.headline3.merge(TextStyle(color: this.makeStickyHeaderTextColor(shrinkOffset, false),)),
                              )
                            )
                          ]
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






// ignore: must_be_immutable
class ProfileFormWidget extends StatefulWidget {
  UserController con;
  ProfileFormWidget({Key key, this.con}) : super(key: key);
  @override
  _ProfileFormWidgetState createState() => _ProfileFormWidgetState();
}

class _ProfileFormWidgetState extends StateMVC<ProfileFormWidget> {

@override
  void initState() {
   widget.con.emailController.text = currentUser.value.email;
   widget.con.phoneController.text = currentUser.value.phone;
    // TODO: implement initState
    super.initState();
  }

  final userData = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(

          child: Form(
            key: widget.con.loginFormKey,
             child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top:20,left:20,right:20),
                  child: Text('Profile Photo',
                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).backgroundColor.withOpacity(0.6)))
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:10,left:20,right:20,bottom:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          margin:EdgeInsets.only(),
                          width: 55,height:55,
                          decoration:BoxDecoration(
                              color:Colors.teal.withOpacity(0.2),
                              shape: BoxShape.circle
                          ),
                          child:ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                              child: currentUser.value.loginVia=='GMail' ?
                              Image.network(userData.photoURL,
                                  width: 30,height:30,fit: BoxFit.cover,
                              ):currentUser.value.image != 'no_image' &&  currentUser.value.image != null?
                              Image.network(currentUser.value.image,
                                  width: 30,height:30,fit: BoxFit.cover,
                              ):InkWell(
                                onTap: (){
                                  Imagepickerbottomsheet();
                                },
                                child: Image.asset('assets/img/userImage.png',
                                    width: 30,height:30,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                         
                      ),


                    ],
                  ),
                ),
                CustomDividerView(dividerHeight: 1.0, color: Theme.of(context).dividerColor),
                Container(
                    margin: EdgeInsets.only(top:20,left: 20, right: 20),
                    width: double.infinity,
                    child: TextFormField(
                        textAlign: TextAlign.left,
                        initialValue: currentUser.value.name,
                        enabled: currentUser.value.loginVia=='GMail' || currentUser.value.loginVia=='Fb'?false:true ,
                        style: Theme.of(context).textTheme.subtitle2,
                        onSaved: (input) => widget.con.register_data.name = input,
                        validator: (input) => input.length < 3 ? S.of(context).should_be_more_than_3_characters : null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Feather.user,size: 18,),
                          hintText: 'Name',
                          hintStyle: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                        ))
                ),

                Container(
                    padding: EdgeInsets.only(top:20,left: 20, right: 20),
                    child:Text(S.of(context).phone,
                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                    )
                ),
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child:ListTile(
                      contentPadding: EdgeInsets.all(0),
                      minLeadingWidth: 30,
                      leading: Container(
                          padding: EdgeInsets.only(top:3),
                          child: Wrap(
                            children: [
                              /* Container(
                                  child:Image.asset('assets/img/china.png',
                                    width:20,height:20,
                                  )
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      border:Border(
                                          right:BorderSide(
                                              width: 1,
                                              color:Colors.grey
                                          )
                                      )
                                  ),
                                  padding: EdgeInsets.only(left:8,right:5),
                                  child:Text('+91',
                                      style: Theme.of(context).textTheme.subtitle2
                                  )
                              ) */
                            ],
                          )
                      ),
                      title: Container(
                        padding: EdgeInsets.only(top:1),
                        child: TextFormField(

                          keyboardType: TextInputType.number,
                          controller: widget.con.phoneController,
                          onSaved: (input) => widget.con.register_data.phone = input,
                          validator: (input) => input.length <= 0 ? S.of(context).invalid_mobile_number : null,
                          enabled: currentUser.value.loginVia=='GMail' || currentUser.value.loginVia=='Fb'?true:false ,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: Theme.of(context).textTheme.subtitle2,
                          decoration: InputDecoration(
                            hintText: "${setting.value.dailCode} 9892888xxx",
                            hintStyle:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Color(0xff7f8c99),)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.transparent)
                            ),
                            contentPadding: EdgeInsets.all(0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                            filled: false,
                          ),
                        ),
                      ),

                    )
                ),
                Container(
                  margin: EdgeInsets.only(top:20,left:0, right: 0),
                  width: double.infinity,
                  child: ListTile(
                    title:TextFormField(
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle2,
                        keyboardType: TextInputType.emailAddress,

                        controller: widget.con.emailController,

                        onChanged: (e){
                          widget.con.listenForCheckValue('user','email', e,'Email');
                        },
                        onSaved: (input) => widget.con.register_data.email_id = input,
                        validator: (input) => !input.contains('@') ? S.of(context).invalid_email_format : null,
                        enabled: currentUser.value.loginVia=='GMail' || currentUser.value.loginVia=='Fb'?false:true ,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                        )),

                  ),

                ),

                Container(
                    margin: EdgeInsets.only(top:20,left: 20, right: 20),
                    width: double.infinity,
                    child: ListTile(
                        title: TextFormField(
                        textAlign: TextAlign.left,
                        initialValue: currentUser.value.selected_address,
                        style: Theme.of(context).textTheme.subtitle2,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(

                          hintText: 'Selected Address',
                          hintStyle: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).backgroundColor.withOpacity(0.6))),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: 1.0,
                            ),
                          ),
                        )
                        ),
                        trailing:Container(
                            padding: EdgeInsets.only(top:7),
                            child:InkWell(
                                onTap: (){
                                  showModal();
                                },
                                child:Text(S.of(context).change,
                                  style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.redAccent)),
                                )
                            ),
                    ),
                    ),
                ),
                Container(
                    padding: EdgeInsets.only(top:10,left: 20, right: 20),
                    child:Text(S.of(context).description,
                      style: Theme.of(context).textTheme.caption,
                    )
                ),
                Container(
                  margin: EdgeInsets.only(top:5,left: 20, right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      maxLines: 5,
                      initialValue: currentUser.value.description,
                      onSaved: (input) => widget.con.register_data.description = input,
                      decoration: InputDecoration.collapsed(
                        hintText: S.of(context).description,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .merge(TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:20,left: 20, right: 20),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  // ignore: deprecated_member_use
                  child:RaisedButton(
                    color:Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      widget.con.register();
                    },
                    child:Center(
                      child:Text(
                          "Save Changes",
                          style: Theme.of(context).textTheme.headline1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50)
              ]),)),
    );
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            color: Color(0xff737373),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                          LocationModalPart(),
                        ]),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                      child: Container(
                        width: double.infinity,
                        // ignore: deprecated_member_use
                        child: FlatButton(
                            onPressed: () {
                              setState(() => currentUser.value);
                              Navigator.pop(context);
                             // _con.listenForZone();

                            },
                            padding: EdgeInsets.all(15),
                            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                            child: Text(
                              S.of(context).proceed_and_close,
                              style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Colors.white)),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
                title: new Text('Camera'),
                onTap: () => getImage(),
              ),
              new ListTile(
                leading: new Icon(Icons.image),
                title: new Text('Gallery'),
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
  final pickedFile = await picker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      register(_image);
      Navigator.of(context).pop();
    } else {
      print('No image selected.');
    }
  });
}

Future getImagegaller() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      register(_image);

      Navigator.of(context).pop();
    } else {
      print('No image selected.');
    }
  });
}

void register(File image) async {
  UserLocal _user = userRepo.currentUser.value;

  final String _apiToken = 'api_token=${_user.apiToken}';
  // ignore: deprecated_member_use
  final uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api/profileimage/${currentUser.value.id}?$_apiToken");
  var request = http.MultipartRequest('POST', uri);
  var pic = await http.MultipartFile.fromPath('image', image.path);
  request.files.add(pic);
  var response = await request.send();
  if (response.statusCode == 200) {
    // Navigator.of(context).pushReplacementNamed('/Success');

    setState(() {
      currentUser.value.image = 'no_image';
      // ignore: deprecated_member_use
      currentUser.value.image = '${GlobalConfiguration().getString('base_upload')}uploads/user_image/user_${currentUser.value.id}.jpg';
    });
    setCurrentUserUpdate(currentUser.value);

  } else {}
}
}

