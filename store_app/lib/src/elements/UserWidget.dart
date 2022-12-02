import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:http/http.dart' as http;


class UserAvatar extends StatefulWidget {
  final String username;
  final String userAvatar;
  final double width;
  final double height;
  final GlobalKey keyButton1;
  final Function showTutorial;
  UserAvatar(
      {Key key,
      this.keyButton1,
      this.username,
      this.userAvatar,
      this.width = 40,
      this.height = 40,
      this.showTutorial})
      : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.username != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.username,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(width: 15),
            ],
          ),
        Container(
          key: widget.keyButton1,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.black.withOpacity(.2),
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
              onTap: () {
                Imagepickerbottomsheet();
              },
              child: FadeInImage(
                image: currentUser.value.image == 'no_image'
                    ? AssetImage("assets/img/userImage.png")
                    : NetworkImage(currentUser.value.image),
                placeholder: currentUser.value.image == 'no_image'
                    ? AssetImage('assets/img/userImage.png')
                    : NetworkImage(currentUser.value.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
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


  int currStep = 0;
  final picker = ImagePicker();

  Future getImage() async {
    if (GetPlatform.isWeb || GetPlatform.isMobile) {
      final pickedFile = await picker.getImage(
          source: ImageSource.camera, maxHeight: 480, maxWidth: 640);
      setState(() {
        if (pickedFile != null) {
         // _image = File(pickedFile.path);
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
       // _image = File(result.files.single.path);

        register(result);
      });

      Navigator.of(context).pop();
    }
  }

  Future getImagegaller() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        //_image = File(pickedFile.path);
        register(pickedFile);
        // widget.con.categoryData.uploadImage = pickedFile;

        Navigator.of(context).pop();
      } else {
        print('No image selected.');
      }
    });
  }

  void register(image) async {
    // ignore: deprecated_member_use
    Uri uri = Uri.parse("${GlobalConfiguration().getString('base_url')}Api_vendor/profileimage/${currentUser.value.id}");
    Map<String, dynamic> _queryParams = {};

    _queryParams['api_token'] = currentUser.value.apiToken;
    uri = uri.replace(queryParameters: _queryParams);
    var request = http.MultipartRequest('POST', uri);

    if (image != null) {
      Uint8List data = await image.readAsBytes();
      List<int> list = data.cast();
      var pic =
          http.MultipartFile.fromBytes('image', list, filename: 'myFile.png');
      request.files.add(pic);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      response.stream.bytesToString().asStream().listen((event) {
        var parsedJson = json.decode(event);
        print(parsedJson);
        setState(() {
          // ignore: deprecated_member_use
          currentUser.value.image = '${GlobalConfiguration().getString('api_base_url')}uploads/vendor_image/vendor_${currentUser.value.id}.jpg';
        });
        setCurrentUserUpdate(currentUser.value);
        //It's done...
      });
    } else {}
  }
}
