import 'dart:io';
import 'package:handy/src/repository/order_repository.dart';
import 'package:handy/generated/l10n.dart';
import '/src/controllers/order_controller.dart';
import '/src/models/miscellaneous.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class TakePhoto extends StatefulWidget {
  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends StateMVC<TakePhoto> {
  File _image;
  final picker = ImagePicker();
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  OrderController _con;

  _TakePhotoState() : super(OrderController()) {
    _con = controller;
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark
        ),
        child: Form(
          key: _con.miscellaneousFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(top: 27.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                       color:Theme.of(context).primaryColorLight,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30.0),
                    Text(S.of(context).take_photo,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4.merge(TextStyle(color:Theme.of(context).primaryColorLight))),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                print('camera');
                                getImage();
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: _image == null
                                        ? IconButton(
                                            iconSize: 50,
                                            color: Theme.of(context).backgroundColor,
                                            icon: Icon(Icons.camera_alt),
                                            onPressed: () {
                                              getImage();
                                            },
                                          )
                                        : Image.file(
                                            _image,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                               padding: EdgeInsets.only(left:23,right: 15,bottom:10),
                               child:Text('Miscellaneous item',
                                 style: Theme.of(context).textTheme.headline3,
                               )
                           ),
                         ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Container(
                                width: size.width * 0.45,
                                child: Text(S.of(context).name,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: Text(S.of(context).price,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                          ],
                        ),
                        // dynamic wiget

                        new Row(children: <Widget>[
                          Expanded(
                            child: SizedBox(
                              height: 500.0,
                              child: ListView.builder(
                                itemCount: _con.miscellaneousData.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                primary: false,
                                itemBuilder: (context, index) {
                                  Miscellaneous _miscellaneousdata =
                                      _con.miscellaneousData.elementAt(index);
                                  return Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: size.width * 0.05),
                                        child: Container(
                                          width:size.width * 0.45,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              onSaved: (input) =>
                                                  _miscellaneousdata.name =
                                                      input,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_the_item_name
                                                  : null,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).item_name,
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.05),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left:5,),
                                        child: Container(
                                          width: size.width * 0.25,
                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              onSaved: (input) =>
                                                  _miscellaneousdata.price =
                                                      double.parse(input),
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_enter_the_price_amount
                                                  : null,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              decoration: InputDecoration(
                                                hintText: S.of(context).amount,
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme.secondary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(right: 17, top: 30),
                                        child: Container(
                                          child: IconButton(
                                            icon: new Icon(Icons.close),
                                            highlightColor: Colors.red,
                                            onPressed: () {
                                              print(index);
                                              _con.removeMiscellaneous(index);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    color:Theme.of(context).primaryColor,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        FloatingActionButton(
                          // first FAB to perform decrement
                          onPressed: () {
                            _con.addMiscellaneous();
                          },
                          child: Icon(Icons.add),
                          backgroundColor: Colors.blueAccent,
                        ),
                        SizedBox(height: 15),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            if (_image != null) {
                              _con.uploadServiceImage('after',
                                  currentPayment.value.bookingId, _image);
                            }
                            _con.miscellaneousCatch();
                          },
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 70),
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
                        SizedBox(height: 15),
                        /**   GestureDetector(
                            onTap: () {
                              if (_image != null) {
                                _con.uploadServiceImage('after', currentPayment.value.bookingId, _image);
                              }
                              _con.miscellaneousCatch();
                            },
                            child: new Text(
                              'Skip',
                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).accentColor)),
                            ),
                          ), */
                        SizedBox(height: 25),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
