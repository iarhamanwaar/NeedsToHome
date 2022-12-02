
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';

import 'package:login_and_signup_web/src/elements/WidgetAdmin.dart';
import 'package:login_and_signup_web/src/pages/profileuser_card.dart';

import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends StateMVC<ProfileView> {
  ScrollController _customScrollViewController;
  ScrollController _singleChildScrollViewController;
  final _sliverAppBarExpandedHeight = 300.0;
  final _gap = 20.0;
  UserController _con;

  _ProfileViewState() : super(UserController()) {
    _con = controller;
  }
  @override
  void initState() {
    _customScrollViewController = ScrollController();
    _singleChildScrollViewController = ScrollController();
    _singleChildScrollViewController.addListener(() {
      if (_singleChildScrollViewController.offset <
          _sliverAppBarExpandedHeight) {
        _customScrollViewController
            .jumpTo(_singleChildScrollViewController.offset);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
      Scrollbar(
          isAlwaysShown: true,
      child:Stack(
        children: [


          CustomScrollView(
            reverse: false,
            physics: NeverScrollableScrollPhysics(),
            controller: _customScrollViewController,
            slivers: [
              SliverAppBar(
                pinned:false,
                automaticallyImplyLeading: false,
                expandedHeight: _sliverAppBarExpandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  background: _image == null?Image.network(
                    currentUser.value.coverImage,
                    fit: BoxFit.cover,
                    height:200
                  ):  GetPlatform.isWeb?Image.network(_image.path):Image.file(_image),
                ),
              ),
              SliverFillRemaining(),
            ],
          ),

          SingleChildScrollView(
            reverse: false,
            //controller: _singleChildScrollViewController,
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Align(
                  alignment: Alignment.topRight,
                  child:Padding(
                      padding: EdgeInsets.only(top:40,right:40,),
                      child:  Container(
                        width:40,height:40,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            color:Colors.black.withOpacity(0.1)
                        ),
                        child:IconButton(
                          onPressed: (){
                            Imagepickerbottomsheet();
                          },
                          icon:Icon(Icons.edit),
                        ),
                      )

                  ),



                ),
                Container(
                  margin: EdgeInsets.only(top: _sliverAppBarExpandedHeight - 110),
                  padding: EdgeInsets.symmetric(horizontal: size.width > 769 ? 20 :10),
                  child: Align(

                    child:Responsive(
                        children:[
                          Wrap(
                              children:[
                                Div(
                                    colS: 12,
                                    colM:6,
                                    colL:4,
                                    child: Column(
                                        children:[
                                          ProfileUserCard(gap: _gap),
                                          SizedBox(
                                            height: 15,
                                          ),

                                        ]
                                    )
                                ),
                                Div(
                                    colS: 12,
                                    colM:6,
                                    colL:8,
                                    child: Padding(
                                      padding: EdgeInsets.only(top:0),
                                      child:ProfileTweetsAdmin(con: _con),
                                    )
                                ),

                              ]
                          ),



                        ]
                    ),


                  ),
                ),
              ]
            ),

          ),

        ],
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
    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      // widget.con.categoryData.uploadImage = pickedFile;

        register(pickedFile);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
    } else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        register(result);
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
       // widget.con.categoryData.uploadImage = pickedFile;
        register(pickedFile);
        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });} else {
      FilePickerResult result = await FilePicker.platform.pickFiles();
      setState(() {
        _image = File(result.files.single.path);
        register(result);
      });

      Navigator.of(context).pop();
    }
  }

  void register( image) async {



    // ignore: deprecated_member_use
    var uri = Uri.parse("${GlobalConfiguration().getString('api_base_url')}Api_admin/coverimage/${currentUser.value.id}");
    Map<String, dynamic> _queryParams = {};

    _queryParams['api_token'] = currentUser.value.apiToken;
    uri = uri.replace(queryParameters: _queryParams);
    var request = http.MultipartRequest('POST', uri);



    if(image!=null) {

      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      var pic = http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Navigator.of(context).pushReplacementNamed('/Success');
      setState(() {
        // ignore: deprecated_member_use
        currentUser.value.coverImage = '${GlobalConfiguration().getString('base_upload')}uploads/cover_image/cover_${currentUser.value.id}.jpg';
          print( currentUser.value.coverImage);
        currentUser.value;
      });
    } else {}
  }

}


