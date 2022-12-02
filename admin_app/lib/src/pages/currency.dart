import 'package:flutter/material.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEcurrencyWidget.dart';
import 'package:login_and_signup_web/src/elements/CurrencyBoxWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/currency.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';


class CurrencyPage extends StatefulWidget {
  @override
  _CurrencyPageState createState() => _CurrencyPageState();
}

class _CurrencyPageState extends StateMVC<CurrencyPage> {
  SecondaryController _con;
  _CurrencyPageState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _con.listenForCurrency();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Theme.of(context).primaryColor.withOpacity(0.6),
      child: SingleChildScrollView(
        child:Column(
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
                      child:Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          children:[
                            Div(
                                colS:12,
                                colM:12,
                                colL:12,
                                child:Wrap(
                                    children:[
                                      Text(
                                        S.of(context).manage_currency,
                                        style: Theme.of(context).textTheme.headline4,
                                      ),
                                      SizedBox(width:10),
                                      Container(
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
                                            AddCurrencyPopupHelper.exit(context,_con,Currency(), 'add');
                                          },
                                        ),
                                      ),


                                    ]
                                )
                            ),


                          ]
                      ),
                    ),

                    SizedBox(height: 40),
                    _con.currencyList.isEmpty ? EmptyOrdersWidget(): Container(
                      margin: EdgeInsets.only(left:20, right: 20,bottom:30),
                      child: Wrap(
                        children: List.generate(_con.currencyList.length, (index) {
                          Currency _currency = _con.currencyList.elementAt(index);

                          return InkWell(onTap: () {
                            Imagepickerbottomsheet(_con.currencyList[index].id, _con.currencyList[index]);
                          },child: CurrencyBoxWidget(con:_con,currencyDetails: _currency, ));
                        }
                        ),
                      ),
                    ),


                  ],
                )),
          ],
        ),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                    Navigator.pop(context),
                    AddCurrencyPopupHelper.exit(context,_con, details,'edit'),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('currency_method',id);
                    setState(() => _con.currencyList.clear());
                    Navigator.pop(context);


                  },
                ),
              ],
            ),
          );
        });
  }
}











class AddCurrencyPopupHelper {

  static exit(context, con, details, pageType) => showDialog(context: context, builder: (context) =>  AEcurrencyWidget(con: con, currencyDetails: details, pageType: pageType,));
}










