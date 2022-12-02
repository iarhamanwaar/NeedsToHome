import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/controllers/primaryuser_controller.dart';
import 'package:login_and_signup_web/src/elements/AEDriverWidget.dart';
import 'package:login_and_signup_web/src/elements/DriverBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/driverregistermodel.dart';
import 'package:login_and_signup_web/src/pages/searchbox_driver.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:login_and_signup_web/src/repository/secondary_repository.dart' as secondaryRepo;
import '../elements/DriverRegisterPopupWidget.dart';
import '../models/excel_export.dart';

class DeliveryBoy extends StatefulWidget {
  @override
  _DeliveryBoyState createState() => _DeliveryBoyState();
}

class _DeliveryBoyState extends StateMVC<DeliveryBoy> {
  PrimaryUserController _con;

  _DeliveryBoyState() : super(PrimaryUserController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listenForDrivers();
  }

  @override
  Widget build(BuildContext context) {
    List<ExcelExportModel> excelProperty = <ExcelExportModel>[
      ExcelExportModel(title: 'id', columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).user_name, columnWidth: 20.82, bold: true),
      ExcelExportModel(title: 'dob', columnWidth: 25.82, bold: true),
      ExcelExportModel(title: S.of(context).gender, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).email, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).mobile, columnWidth: 15.82, bold: true),
      ExcelExportModel(title: S.of(context).address, columnWidth: 30.82, bold: true),
      ExcelExportModel(title: S.of(context).status, columnWidth: 12.82, bold: true),
      ExcelExportModel(title: S.of(context).date, columnWidth: 12.82, bold: true),


    ];
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Div(
                colS: 12,
                colM: 12,
                colL: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 30.0, top: 25.0, right: 30, bottom: 10.0),
                      child: Wrap(alignment: WrapAlignment.spaceBetween, children: [
                        Div(
                            colS: 6,
                            colM: 6,
                            colL: 6,
                            child: Wrap(children: [
                              Text(
                                S.of(context).manage_delivery_boy,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(width: 10),
                              InkWell(
                                onTap: () async {
                                  int row =  _con.driverList.length;
                                  int col = excelProperty.length;
                                  // ignore: deprecated_member_use
                                  var twoDList = List.generate(row, (i) => List(col), growable: false);
                                  int i = 0;
                                  _con.driverList.forEach((element) {
                                    twoDList[i][0] = element.id;
                                    twoDList[i][1] = element.firstname;
                                    twoDList[i][2] = element.dob;
                                    twoDList[i][3] = element.gender;
                                    twoDList[i][4] = element.email;
                                    twoDList[i][5] = element.mobile;
                                    twoDList[i][6] = '${element.address1},${element.address2},${element.city} ${element.state}' ;
                                    twoDList[i][8] = element.status;
                                    twoDList[i][10] = element.date;
                                    i++;
                                  });


                                  secondaryRepo.createExcel(excelProperty, twoDList,'provider');
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(left: 8, top: 5),
                                    child: Image(image: AssetImage('assets/img/excel.png'), width: 25, height: 25)),
                              ),
                              SizedBox(width: 10),
                            /*  Container(
                                height: 30.0,
                                width: 30.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  color: Theme.of(context).primaryColorLight,
                                  icon: const Icon(Icons.add),
                                  iconSize: 30.0,
                                  //color: Palette.facebookBlue,
                                  onPressed: () {
                                   /* AddDriverHelper.exit(context, _con, DriverRegistermodel(), 'add');*/
                                    AddDriverRegisterHelper.exit(context);
                                  },
                                ),
                              ) */
                            ])),
                        Div(
                          colS: 6,
                          colM: 6,
                          colL: 6,
                          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: IconButton(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SearchBoxDriver(
                                        searchType: 'category',
                                        userList: _con.driverList,
                                      )));
                                },
                                icon: Icon(Icons.search, color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                          ]),
                        ),
                      ]),
                    ),
                    SizedBox(height: 20),
                    _con.driverList.isEmpty
                        ? EmptyOrdersWidget()
                        : Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Wrap(
                        children: List.generate(_con.driverList.length, (index) {
                          DriverRegistermodel _driverData = _con.driverList.elementAt(index);
                          return InkWell(
                              onTap: () {
                                imagePickerBottomSheet(_driverData.id, _con, _driverData, context);
                                print('DriverImage:${_driverData.image}');
                              },
                              child: DriverBoxWidget(driverData: _driverData));
                        }),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  imagePickerBottomSheet(id,PrimaryUserController con, details, context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /**new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    AddDriverHelper.exit(context, con, details, 'edit'),
                    // AddCategoryHelper.exit(context,widget.con, categoryDetails,'edit'),
                  },
                ), **/
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: () async {

                    await con.delete('driver',id);

                    Navigator.pop(context);
                    setState(() {con.driverList.clear();});


                  },
                ),
              ],
            ),
          );
        });
  }
}



class AddDriverHelper {
  static exit(context, con, driverdata, pageType) => showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, StateSetter setState) => AEDriverWidget(
            con: con,
            setState: setState,
            driverData: driverdata,
            pageType: pageType,
          )));
}


class AddDriverRegisterHelper {
  static exit(context) => showDialog(context: context, builder: (context) => DriverRegisterPopupWidget());
}


