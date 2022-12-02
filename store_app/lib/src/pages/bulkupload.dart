import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:global_configuration/global_configuration.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:toast/toast.dart';
import 'package:universal_html/html.dart' as html;
import 'package:login_and_signup_web/generated/l10n.dart';
import 'newupdate_switch.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;

class BulkUpload extends StatefulWidget {
  @override
  _BulkUploadState createState() => _BulkUploadState();
}

class _BulkUploadState extends State<BulkUpload> {
  List<int> _selectedFile;
  List<int> _variantSelectedFile;
  Uint8List _bytesData;
  Uint8List _variantbytesData;
  bool productFileUpload = false;
  bool variantFileUpload = false;
  String uploadType = 'new';
  bool switcher = true;

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
    productFileUpload = true;
  }

  startWebVariantFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResultVaraint(reader.result);
      });
      reader.readAsDataUrl(file);
    });
    variantFileUpload = true;
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  void _handleResultVaraint(Object result) {
    setState(() {
      _variantbytesData =
          Base64Decoder().convert(result.toString().split(",").last);
      _variantSelectedFile = _variantbytesData;
    });
  }

  // ignore: missing_return
  Future<String> makeRequest(loader) async {
    Overlay.of(context).insert(loader);
    var url;
    final String _apiToken = 'api_token=${currentUser.value.apiToken}';
    if (switcher == true) {
      // ignore: deprecated_member_use
      (currentUser.value.shopTypeId==2)?
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/foodproduct_add/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken"):
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/product_add/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken");
    } else {
      // ignore: deprecated_member_use
      (currentUser.value.shopTypeId==2)?
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/foodproduct_update/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken"):
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/product_update/${currentUser.value.id}/${currentUser.value.shopTypeId}?$_apiToken");
    }

    print(url);
    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up.csv"));
    print(url);
    request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Helper.hideLoader(loader);
        showToast("upload Successfully",
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    });
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(
      msg,
      context,
      duration: duration,
      gravity: gravity,
    );
  }

  // ignore: missing_return
  Future<String> makeRequestVariant(loader) async {
    Overlay.of(context).insert(loader);
    var url;
    if (switcher == true) {
      // ignore: deprecated_member_use
      (currentUser.value.shopTypeId==2)?
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/foodvariant_add/${currentUser.value.id}/${currentUser.value.shopTypeId}"):
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/variant_2_add/${currentUser.value.id}/${currentUser.value.shopTypeId}");
    } else {
      // ignore: deprecated_member_use
      (currentUser.value.shopTypeId==2)?
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/foodvariant_update/${currentUser.value.id}/${currentUser.value.shopTypeId}"):
      url = Uri.parse(
          "${GlobalConfiguration().getValue('api_base_url')}api_vendor/csvimport/variant_2_update/${currentUser.value.id}/${currentUser.value.shopTypeId}");
    }
    Map<String, dynamic> _queryParams = {};

    _queryParams['api_token'] = currentUser.value.apiToken;
    url = url.replace(queryParameters: _queryParams);

    var request = new http.MultipartRequest("POST", url);
    request.files.add(http.MultipartFile.fromBytes('file', _variantSelectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: "file_up.csv"));
    print(url);
    request.send().then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Helper.hideLoader(loader);
        showToast("upload Successfully",
            gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OverlayEntry loader = Helper.overlayLoader(context);
    return Scrollbar(
        isAlwaysShown: true,
        child: ListView(scrollDirection: Axis.vertical, children: [
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0, top: 40.0, right: 20, bottom: 20.0),
              child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                Div(
                    colS: 12,
                    colM: 12,
                    colL: 12,
                    child: Wrap(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          S.of(context).file_upload,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      NewUpdateToggle(
                        activeColor: Colors.black,
                        value: switcher,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              switcher = true;
                            } else {
                              switcher = false;
                            }
                          });
                        },
                      ),
                    ])),
              ]),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            child: Container(
              margin: EdgeInsets.only(
                  left: 20.0,  right: 20, bottom: 20.0),
              child: Div(
                  colS: 12,
                  colM: 12,
                  colL: 12,
                  child:Container(
                      child:Wrap(
                          children: currentUser.value.shopTypeId!=2?[
                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child:ListTile(
                                dense:true,
                                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Text('1. Product_id should be correct',style: Theme.of(context).textTheme.subtitle2,),
                              ),
                            ),

                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child:ListTile(
                                dense:true,
                                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Text('2. Category_id should be your correct',style: Theme.of(context).textTheme.subtitle2,),
                              ),
                            ),
                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child:ListTile(
                                dense:true,
                                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Text('3. Sub_category_id should be your correct',style: Theme.of(context).textTheme.subtitle2,),
                              ),
                            ),

                            Div(
                              colS: 6,
                              colM: 6,
                              colL: 6,
                              child:ListTile(
                                dense:true,
                                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                                title: Text('4. Tax should be the taxes available in the dropdown in the add product page',style: Theme.of(context).textTheme.subtitle2,),
                              ),
                            ),

                          ]:[
                            Div(
                            colS: 6,
    colM: 6,
    colL: 6,
    child:ListTile(
    dense:true,
    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
    title: Text('1. Product_id should be correct',style: Theme.of(context).textTheme.subtitle2,),
    ),
    ),

    Div(
    colS: 6,
    colM: 6,
    colL: 6,
    child:ListTile(
    dense:true,
    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
    title: Text('2. Category_id should be your correct',style: Theme.of(context).textTheme.subtitle2,),
    ),
    ),
    Div(
    colS: 6,
    colM: 6,
    colL: 6,
    child:ListTile(
    dense:true,
    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
    title: Text('3. The spelling should be Veg or NON Veg',style: Theme.of(context).textTheme.subtitle2,),
    ),
    ),

    Div(
    colS: 6,
    colM: 6,
    colL: 6,
    child:ListTile(
    dense:true,
    contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
    title: Text('4. Tax should be the taxes available in the dropdown in the add product page',style: Theme.of(context).textTheme.subtitle2,),
    ),
    ),
                          ]
                      )

                  )
              ),

            ),
          ),
          Div(
              colS: 12,
              colM: 12,
              colL: 12,
              child: Container(
                  margin: EdgeInsets.only(
                      left: 15, right: 15, top: 20.0, bottom: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              )),
                        ),
                        child: switcher
                            ? Text(
                          S.of(context).products_add,
                          style: Theme.of(context).textTheme.headline5,
                        )
                            : Text(
                          S.of(context).products_update,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 5),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            switcher
                                ? Text(
                              S
                                  .of(context)
                                  .click_here_if_you_want_to_see_example_and_format_of_csv,
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.bodyText1,
                            )
                                : Text(
                              S
                                  .of(context)
                                  .if_you_want_download_your_product_list_of_csv,
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(width: 5),
                            InkWell(
                                onTap: () async {


                                  if (switcher == true) {


                                    if(currentUser.value.shopTypeId==2){


                                      int row =  1;
                                      int col = 4;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      twoDList[i][0] ='1';
                                      twoDList[i][1] = 'Amul dark chocolate';
                                      twoDList[i][2] = '9:30 AM';
                                      twoDList[i][3] = '10:30 PM';

                                      List<String> rowHeader = ["Category id","Product name","From available time", "To available time"];
                                      secondaryRepo.generateCSV(rowHeader,twoDList,'food_template','csv' );

                                    } else {
                                      // ignore: deprecated_member_use


                                      int row =  1;
                                      int col = 4;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      twoDList[i][0] ='1';
                                      twoDList[i][1] = '2';
                                      twoDList[i][2] = 'Amul dark chocolate';


                                      List<String> rowHeader = ["Category id","Subcategory id","Product name"];
                                      secondaryRepo.generateCSV(rowHeader,twoDList,'product_template','csv' );
                                    }
                                  } else {
                                    // ignore: deprecated_member_use


                                  }

                                },
                                child: Text(S.of(context).click_here,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .merge(TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ignore: deprecated_member_use
                                FlatButton(
                                  onPressed: () {
                                    if (GetPlatform.isWeb || GetPlatform.isMobile) {
                                      startWebFilePicker();
                                    } else {
                                      openPicker();
                                    }
                                  },
                                  shape: Border.all(
                                      width: 1.0, color: Colors.grey),
                                  padding: EdgeInsets.all(15),
                                  child: Text(S.of(context).choose_file,
                                      style:
                                      Theme.of(context).textTheme.caption),
                                ),
                                SizedBox(height: 20),
                                productFileUpload
                                    ? Text(S.of(context).your_file_selected,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2)
                                    : Text(''),
                                SizedBox(height: 20),

                                productFileUpload
                                // ignore: deprecated_member_use
                                    ? FlatButton(
                                  onPressed: () {
                                    makeRequest(loader);
                                  },
                                  padding: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      left: 40,
                                      right: 40),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    S.of(context).submit,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight)),
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
          Div(
              colS: 12,
              colM: 12,
              colL: 12,
              child: Container(
                  margin: EdgeInsets.only(
                      left: 15, right: 15, top: 20.0, bottom: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                                width: 1,
                              )),
                        ),
                        child: switcher
                            ? Text(
                          S.of(context).variants_add,
                          style: Theme.of(context).textTheme.headline5,
                        )
                            : Text(
                          S.of(context).variant_update,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 5),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            switcher
                                ? Text(
                              S
                                  .of(context)
                                  .click_here_if_you_want_to_see_example_and_format_of_csv,
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.bodyText1,
                            )
                                : Text(
                              S
                                  .of(context)
                                  .if_you_want_download_your_variant_list_of_csv,
                              textAlign: TextAlign.center,
                              style:
                              Theme.of(context).textTheme.bodyText1,
                            ),
                            SizedBox(width: 5),
                            InkWell(
                                onTap: () async {



                                  if (switcher == true) {
                                    // ignore: deprecated_member_use
                                    if(currentUser.value.shopTypeId==2){

                                      int row =  1;
                                      int col = 8;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      twoDList[i][0] ='25';
                                      twoDList[i][1] = '250';
                                      twoDList[i][2] = 'gm';
                                      twoDList[i][3] = 'Veg';
                                      twoDList[i][4] = '100';
                                      twoDList[i][5] = '5';
                                      twoDList[i][6] = '0';
                                      twoDList[i][7] = 'https://optimaprotech.com/restaurantproduct_104.png';

                                      List<String> rowHeader = ["Product id","Quantity","Unit", "Food type","Strike price","Discount","Tax percent", "Image"];
                                      secondaryRepo.generateCSV(rowHeader,twoDList,'foodvariant_template','csv' );
                                    } else {


                                      int row =  1;
                                      int col = 7;
                                      // ignore: deprecated_member_use
                                      var twoDList = List.generate(row, (i) => List(col), growable: false);
                                      int i = 0;
                                      twoDList[i][0] ='25';
                                      twoDList[i][1] = '250';
                                      twoDList[i][2] = 'gm';
                                      twoDList[i][3] = '100';
                                      twoDList[i][4] = '5';
                                      twoDList[i][5] = '0';
                                      twoDList[i][6] = 'https://optimaprotech.com/restaurantproduct_104.png';

                                      List<String> rowHeader = ["Product id","Quantity","Unit", "Strike price","Discount","Tax percent", "Image"];
                                      secondaryRepo.generateCSV(rowHeader,twoDList,'variant_template','csv' );
                                    }

                                  } else {

                                  }

                                },
                                child: Text('1click_here',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .merge(TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // ignore: deprecated_member_use
                                FlatButton(
                                  onPressed: () async {
                                    if (GetPlatform.isWeb || GetPlatform.isMobile) {
                                      startWebVariantFilePicker();
                                    }else {
                                      openPicker();
                                    }
                                  },
                                  shape: Border.all(
                                      width: 1.0, color: Colors.grey),
                                  padding: EdgeInsets.all(15),
                                  child: Text(S.of(context).choose_file,
                                      style:
                                      Theme.of(context).textTheme.caption),
                                ),

                                SizedBox(height: 20),
                                variantFileUpload
                                    ? Text(S.of(context).your_file_selected,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2)
                                    : Text(''),
                                SizedBox(height: 20),

                                variantFileUpload
                                // ignore: deprecated_member_use
                                    ? FlatButton(
                                  onPressed: () {
                                    makeRequestVariant(loader);
                                  },
                                  padding: EdgeInsets.only(
                                      top: 15,
                                      bottom: 15,
                                      left: 40,
                                      right: 40),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    S.of(context).submit,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                        color: Theme.of(context)
                                            .primaryColorLight)),
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))),
        ]));
  }

  openPicker() async {
    //FilePickerResult result = await FilePicker.platform.pickFiles();
   // _image = File(result.files.single.path);
    // _selectedFile = _image;
  }

  void downloadFile(String url) {
    html.AnchorElement anchorElement = new html.AnchorElement(href: url);
    anchorElement.download = url;
    anchorElement.click();
  }

  void sendFile(image) async {
    print('load');
    print(image);
    final String _apiToken = 'api_token=${currentUser.value.id}';
    // ignore: deprecated_member_use
    final uri = Uri.parse(
        "${GlobalConfiguration().getValue('base_url')}Api_vendor/bulkupload/${currentUser.value.id}?$_apiToken");
    var request = http.MultipartRequest('POST', uri);
    print(uri);

    if (image != null) {
      print('jack');

      var pic = http.MultipartFile.fromBytes('image', image);
      request.files.add(pic);
    }

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Navigator.of(context).pushReplacementNamed('/Success');

    } else {}
  }
}

