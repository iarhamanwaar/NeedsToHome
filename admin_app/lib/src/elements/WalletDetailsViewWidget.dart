
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

import '../components/constants.dart';

// ignore: must_be_immutable
class WalletDetailsViewWidget extends StatefulWidget {
  SecondaryController con;
  VendorWallet wallet;
  String type;
  WalletDetailsViewWidget({Key key, this.con,this.wallet,this.type}) : super(key: key);

  @override
  _WalletDetailsViewWidgetState createState() => _WalletDetailsViewWidgetState();
}

class _WalletDetailsViewWidgetState extends StateMVC<WalletDetailsViewWidget> {
  // ignore: non_constant_identifier_names
  String _Type='Success';
  String id;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    var size = MediaQuery.of(context).size;
    return         Container(
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

            insetPadding: EdgeInsets.only(top:GetPlatform.isMobile? size.height * 0.15 : size.height * 0.1,
              left:GetPlatform.isMobile? size.width * 0.005 : size.width * 0.09,
              right:GetPlatform.isMobile? size.width * 0.005 : size.width * 0.09,
              bottom:GetPlatform.isMobile? size.height * 0.15 : size.height * 0.1,
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
                        padding: EdgeInsets.only(left:18,right:10),
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


                                SizedBox(height:5),

                               Text(S.of(context).add_banner,
                                    style: Theme.of(context).textTheme.headline4
                                ),
                                SizedBox(height:10),
                                Wrap(
                                   alignment: WrapAlignment.spaceBetween,
                                    children:[
                                      Div(
                                        colS:6,
                                        colM:6,
                                        colL:6,
                                        child:Container(
                                          child:Text('vendor Id',style:Theme.of(context).textTheme.subtitle1),
                                        )
                                      ),
                                      Div(
                                          colS:6,
                                          colM:6,
                                          colL:6,
                                        child:Container(

                                          alignment: Alignment.topRight,
                                          child:Text(widget.wallet.vendorId??'',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:Theme.of(context).textTheme.subtitle1)
                                      ),
                                      ),


                                    ]
                                ),
                                SizedBox(height:5),
                                Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children:[
                                      Div(
                                          colS:6,
                                          colM:6,
                                          colL:6,
                                          child:Container(
                                            child: Text('Vendor Name',style:Theme.of(context).textTheme.subtitle1),
                                          )
                                      ),
                                      Div(
                                        colS:6,
                                        colM:6,
                                        colL:6,
                                        child: Container(
                                            alignment: Alignment.topRight,
                                            child:Text('23',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style:Theme.of(context).textTheme.subtitle1)
                                        ),
                                      ),


                                    ]
                                ),
                                SizedBox(height: 5,),
                                Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children:[
                                      Div(
                                          colS:6,
                                          colM:6,
                                          colL:6,
                                          child:Container(
                                            child: Text(S.of(context).amount,style:Theme.of(context).textTheme.subtitle1),
                                          )
                                      ),
                                      Div(
                                        colS:6,
                                        colM:6,
                                        colL:6,
                                        child: Container(
                                            alignment: Alignment.topRight,
                                            child:Text(Helper.pricePrint(widget.wallet.amount),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style:Theme.of(context).textTheme.subtitle1)
                                        ),
                                      ),


                                    ]
                                ),
                                       SizedBox(height: 5,),
                                Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children:[
                                      Div(
                                          colS:6,
                                          colM:6,
                                          colL:6,
                                          child:Container(
                                            child:    Text(S.of(context).requested_date,style:Theme.of(context).textTheme.subtitle1),
                                          )
                                      ),
                                      Div(
                                        colS:6,
                                        colM:6,
                                        colL:6,
                                        child:Container(
                                            alignment: Alignment.topRight,
                                            child:Text(widget.wallet.reqDate,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                                maxLines: 1,
                                                style:Theme.of(context).textTheme.subtitle1)
                                        ),
                                      ),


                                    ]
                                ),



















                                SizedBox(height:10),


                                Padding(
                                  padding: EdgeInsets.only(top:10),
                                  child:Container(
                                    width: double.infinity,
                                    child: DropdownButton(
                                        value: _Type,
                                        isExpanded: true,
                                        focusColor: transparent,
                                        underline: Container(
                                          color: Colors.grey[300],
                                          height: 1.0,
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(S.of(context).success),
                                            value: 'Success',
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Under Process"),
                                            value: 'UnderProcess',
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Rejected"),
                                            value: 'Rejected',
                                          ),

                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _Type = value;

                                          });
                                        }),
                                  ),
                                ),
                                SizedBox(height:10),
                                Padding(
                                  padding: EdgeInsets.only(top:10),


                                  child: Container(
                                      width: double.infinity,

                                      child: TextField(
                                          textAlign: TextAlign.left,
                                          autocorrect: true,
                                          onChanged: (e){
                                            id = e;
                                          },
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            labelText: S.of(context).transaction_id,
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
                                ),
                                SizedBox(height:35),
                                Align(
                                  alignment: Alignment.center,
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () {
                                      //print(widget.payment.invoiceID);
                                      widget.con.walletStatsUpdate(_Type,widget.wallet.id,widget.wallet.vendorId,widget.wallet.amount,widget.type);
                                    },
                                    padding: EdgeInsets.only(top:15,bottom:15,left:40,right:40),
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(1),
                                    shape: StadiumBorder(),
                                    child: Text(
                                      S.of(context).update,
                                      style: Theme.of(context).textTheme.headline6.merge(
                                          TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        ),
                      )
                  ),




                ],
              ),
            ),
          ),

        )

    );
  }
}
