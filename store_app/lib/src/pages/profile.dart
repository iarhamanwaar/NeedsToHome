import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/elements/CardWidget.dart';
import 'package:login_and_signup_web/src/elements/widget.dart';
import 'package:login_and_signup_web/src/pages/user_card.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

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
    _con.getProfileDetailData();
    initTargets();
    // ignore: unnecessary_statements
   // currentUser.value.profileStatus ? null : showTutorial();
    super.initState();

  }

  TutorialCoachMark tutorialCoachMark;
  @override
  void dispose() {
    print('page dispose');
   // tutorialCoachMark..finish();
    super.dispose();
  }

  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.red,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onSkip: () {
        print("skip");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
    )..show();
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      S.of(context).upload_logo,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        S.of(context).please_upload_your_logo,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                        onTap: () {
                          controller.next();
                        },
                        child: Text(S.of(context).next,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight)))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: keyButton2,
        contents: [
          TargetContent(
            align: ContentAlign.left,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      S.of(context).cover_image,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        S.of(context).you_can_change_your_cover_image,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                        onTap: () {
                          controller.next();
                        },
                        child: Text(S.of(context).next,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorLight)))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "Target 2",
        keyTarget: keyButton3,
        color: Colors.purple,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      S.of(context).profile_details,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text( S.of(context).complete_your_profile_details,

                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      InkWell(
                          onTap: () {
                            controller.previous();
                          },
                          child: Text(S.of(context).previous,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight))),
                      SizedBox(width: 50),
                      InkWell(
                          onTap: () {
                            controller.skip();
                          },
                          child: Text( S.of(context).finish,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight)))
                    ]),
                  ],
                ),
              );
            },
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scrollbar(
        isAlwaysShown: true,
        child: Stack(
          children: [
            CustomScrollView(
              reverse: false,
              physics: NeverScrollableScrollPhysics(),
              controller: _customScrollViewController,
              slivers: [
                SliverAppBar(
                  pinned: false,
                  automaticallyImplyLeading: false,
                  expandedHeight: _sliverAppBarExpandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _image == null &&
                            currentUser.value.coverImage == 'no_image' &&
                            currentUser.value.shopTypeId == 1
                        ? Image.asset('assets/img/grocerydefaultbg.jpg',
                            fit: BoxFit.cover, height: 200)
                        : _image == null &&
                                currentUser.value.coverImage == 'no_image' &&
                                currentUser.value.shopTypeId == 2
                            ? Image.asset('assets/img/resturentdefaultbg.jpg',
                                fit: BoxFit.cover, height: 200)
                            : _image == null &&
                                    currentUser.value.coverImage ==
                                        'no_image' &&
                                    currentUser.value.shopTypeId == 3
                                ? Image.asset(
                                    'assets/img/pharmacydefaultbg.jpg',
                                    fit: BoxFit.cover,
                                    height: 200)
                                : currentUser.value.coverImage != 'no_image'
                                    ? Image.network(
                                        currentUser.value.coverImage,
                                        fit: BoxFit.cover,
                                        height: 200)
                                    : GetPlatform.isWeb
                                        ? Image.network(_image.path)
                                        : Image.file(_image),
                  ),
                ),
                SliverFillRemaining(),
              ],
            ),
            SingleChildScrollView(
              reverse: false,
              //controller: _singleChildScrollViewController,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                        right: 40,
                      ),
                      child: Container(
                        width: 40,
                        height: 40,
                        key: keyButton2,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.1)),
                        child: IconButton(
                          onPressed: () {
                            Imagepickerbottomsheet();
                          },
                          icon: Icon(Icons.edit),
                        ),
                      )),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: _sliverAppBarExpandedHeight - 170),
                  padding: EdgeInsets.symmetric(horizontal: size.width > 769 ? 20 :10),
                  child: Align(
                    child: Responsive(children: [
                      Wrap(children: [
                        Div(
                            colS: 12,
                            colM: 6,
                            colL: 4,
                            child: Column(children: [
                              UserCard(
                                  gap: _gap,
                                  con: _con,
                                  keyButton1: keyButton1,
                                  showTutorial: this.showTutorial),
                              SizedBox(
                                height: 15,
                              ),
                            ])),
                        Div(
                            colS: 12,
                            colM: 6,
                            colL: 8,
                            child: Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: _con.loaderData
                                  ? Container(
                                      key: keyButton3,
                                      child: ProfileTweets(con: _con))
                                  : EmptyOrdersWidget(),
                            )),
                      ]),
                    ]),
                  ),
                ),
              ]),
            ),
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

  void register(image) async {
    final String _apiToken = 'api_token=${currentUser.value.id}';
    // ignore: deprecated_member_use
    Uri uri = Uri.parse(
        "${GlobalConfiguration().getValue('base_url')}Api_vendor/coverimage/${currentUser.value.id}?$_apiToken");
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
      // Navigator.of(context).pushReplacementNamed('/Success');
      setState(() {
        // ignore: deprecated_member_use
        currentUser.value.coverImage =
            '${GlobalConfiguration().getValue('base_upload')}uploads/cover_image/cover_${currentUser.value.id}.jpg';
        PaintingBinding.instance.imageCache.clear();
        currentUser.value;
        setCurrentUserUpdate(currentUser.value);
      });
    } else {}
  }
}

class ProfileItems extends StatelessWidget {
  final _cardHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ActivityItem(
                  label: 'Activities',
                  icon: Icons.ten_k,
                  height: _cardHeight,
                  isSelected: true,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ActivityItem(
                  label: 'Moments',
                  icon: Icons.ten_k,
                  height: _cardHeight,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ActivityItem(
                  label: 'Friends',
                  icon: Icons.ten_k,
                  height: _cardHeight,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ActivityItem(
                  label: 'Edit profile',
                  icon: Icons.ten_k,
                  height: _cardHeight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final double height;
  final bool isSelected;

  ActivityItem({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.height,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AppCard(
        height: height,
        style: isSelected ? AppCardStyle.Normal : AppCardStyle.Outlined,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            SizedBox(height: 15),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Theme.of(context).primaryColor : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
