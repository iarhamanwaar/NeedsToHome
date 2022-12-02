
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/models/taxmodel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

// ignore: must_be_immutable
class AETaxWidget extends StatefulWidget{
  AETaxWidget({Key key, this.con, this.taxDetails, this.pageType}) : super(key: key);
  SecondaryController con;
  TaxModel taxDetails;
  String pageType;
  @override
  _AETaxWidgetState createState() => _AETaxWidgetState();
}

class _AETaxWidgetState extends StateMVC<AETaxWidget> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.taxDetails);
    if(widget.pageType=='edit'){
      //widget.con.currencyData.uploadImage = widget.currencyDetails.uploadImage;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(key:widget.con.registerFormKey,
      child: Container(
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
                bottom:MediaQuery.of(context).size.height * 0.1,
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
                          child:Scrollbar(
                            isAlwaysShown: true,
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
                                    widget.pageType=='add'?Text(S.of(context).add_tax,
                                        style: Theme.of(context).textTheme.headline4
                                    ):Text('Edit Tax',
                                        style: Theme.of(context).textTheme.headline4),

                                    Padding(
                                      padding: const EdgeInsets.only(right: 40, left:40),
                                      child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children:[
                                            SizedBox(height:10),
                                            Container(
                                                width: double.infinity,

                                                child: TextFormField(
                                                    textAlign: TextAlign.left,
                                                    autocorrect: true,
                                                     initialValue: widget.taxDetails.tax,
                                                    validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_currency_symbol : null,
                                                    onSaved: (input) => widget.con.taxData.tax = input,
                                                    inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    decoration: InputDecoration(
                                                      labelText: S.of(context).tax,
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
                                            SizedBox(height:10),
                                          ]
                                      ),

                                    ),
                                  ]
                              ),
                            ),),
                        )
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:Container(
                        padding: EdgeInsets.only(bottom:10,right:10,left:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () {
                                //widget.pageType=='add'?widget.con.updateCurrency(context, 'do_add', ''):
                                //widget.con.updateCurrency(context, 'update', widget.currencyDetails.id);
                                widget.con.addEditTax(widget.pageType, widget.taxDetails.id, context);
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
                      ),

                    ),



                  ],
                ),
              ),
            ),

          )

      ),);



  }








}
