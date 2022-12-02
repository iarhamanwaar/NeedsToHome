import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:login_and_signup_web/src/components/custom_divider_view.dart';
import 'package:login_and_signup_web/src/controllers/secondary_controller.dart';
import 'package:login_and_signup_web/src/elements/AEVendorMembershipWidget.dart';
import 'package:login_and_signup_web/src/elements/EmptyOrdersWidget.dart';
import 'package:login_and_signup_web/src/models/vendor_membership.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_ui/responsive_ui.dart';

class Membership extends StatefulWidget {
  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends StateMVC<Membership>  {
  SecondaryController _con;
  _MembershipState() : super(SecondaryController()) {
    _con = controller;
  }

  @override
  // ignore: must_call_super
  void initState()  {
    _con.listenForMemberPlan();
  }

  callback(){
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
                                  colS: GetPlatform.isMobile?  12 :8,
                                  colM:GetPlatform.isMobile?  12 :8,
                                  colL:GetPlatform.isMobile?  12 :8,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                      children:[
                                        Expanded(
                                          child:Wrap(
                                      children:[
                                        Text(
                                          S.of(context).manage_membership,
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
                                        AddEdPopupHelper.exit(context, _con, VendorMembershipModel(), 'add');
                                      },
                                    ),
                                  ),
                                      ]
                                  )

                                        ),
                                        SizedBox(width:10),


                                      ]
                                  )
                              ),


                            ]
                        ),
                      ),
                      _con.MemberPlanList.isEmpty?EmptyOrdersWidget():Container(
                          margin: EdgeInsets.only(top:20,left:20, right: 20,bottom:30),
                          child:Wrap(runSpacing: 20,
                              children:List.generate(_con.MemberPlanList.length, (index) {
                                return Div(
                                    colS:12,
                                    colM:6,
                                    colL:4,
                                    child:InkWell(
                                      onTap: (){
                                        Imagepickerbottomsheet(_con.MemberPlanList[index].id, _con.MemberPlanList[index]);
                                      },
                                      child: Container(
                                        child:Container(
                                          width:double.infinity,
                                          decoration: BoxDecoration(
                                              color:Theme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 1.0,
                                                ),
                                              ]),
                                          margin: EdgeInsets.only(left:15,right:15, top: 10.0,bottom:20),

                                          child:Column(
                                              children:[


                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:[
                                                      Container(
                                                          padding:EdgeInsets.only(top:20,left:20,right:20),
                                                          child:Row(
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(10)
                                                                ),
                                                                width:60,height:60,
                                                                child:ClipRRect(
                                                                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                    borderRadius: BorderRadius.circular(10),

                                                                    child:
                                                                    Image(image:NetworkImage(_con.MemberPlanList[index].uploadImage),
                                                                      width: 70,height:70,fit: BoxFit.fitHeight,
                                                                    )),
                                                              ),
                                                              Expanded(
                                                                child: Container(
                                                                    padding: EdgeInsets.only(left:10,right:10),
                                                                    child:Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children:[
                                                                          Text(_con.MemberPlanList[index].planname,
                                                                              style:Theme.of(context).textTheme.headline1,
                                                                            overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                          ),
                                                                          RichText(
                                                                            text: new TextSpan(text: setting.value.defaultCurrency,
                                                                                style: Theme.of(context).textTheme.subtitle2
                                                                                    .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                                children: [
                                                                                  TextSpan(
                                                                                      text: _con.MemberPlanList[index].price,
                                                                                      style: Theme.of(context).textTheme.headline4
                                                                                  ),
                                                                                  /*TextSpan(
                                                                          text: ' /user',
                                                                          style: Theme.of(context).textTheme.subtitle2
                                                                              .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),))
                                                                      )*/
                                                                                ]),
                                                                          )
                                                                        ]
                                                                    )
                                                                ),
                                                              ),



                                                            ],
                                                          )
                                                      ),
                                                      SizedBox(height:20),
                                                      CustomDividerView(dividerHeight:1),
                                                      Container(
                                                          padding:EdgeInsets.only(top:10,left:20,right:20),
                                                          child:Row(
                                                            children: [
                                                              Icon(Icons.check),
                                                              SizedBox(width:10),
                                                              Expanded(
                                                                child:Container(

                                                                  child:RichText(
                                                                    text: new TextSpan(text: 'Get Commission Of',
                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: ' ${_con.MemberPlanList[index].commission}%',
                                                                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                          ),

                                                                        ]),
                                                                  ),
                                                                ),
                                                              )


                                                            ],
                                                          )
                                                      ),
                                                      Container(
                                                          padding:EdgeInsets.only(top:10,left:20,right:20),
                                                          child:Row(
                                                            children: [
                                                              Icon(Icons.check),
                                                              SizedBox(width:10),
                                                              Expanded(
                                                                child:Container(

                                                                  child:RichText(
                                                                    text: new TextSpan(text: 'Can Upload Products Upto ',
                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                        children: [
                                                                          TextSpan(
                                                                              text: _con.MemberPlanList[index].productlimit,
                                                                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                          ),

                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          )
                                                      ),

                                                      Container(
                                                          padding:EdgeInsets.only(top:10,bottom:20,left:20,right:20),
                                                          child:Row(
                                                            children: [
                                                              Icon(Icons.check),
                                                              SizedBox(width:10),
                                                              Expanded(
                                                                child:Container(

                                                                  child:RichText(
                                                                    text: new TextSpan(text:S.of(context).validity_days,
                                                                        style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black)),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:  _con.MemberPlanList[index].validity,

                                                                            style: Theme.of(context).textTheme.subtitle2
                                                                                .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                          ),

                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          )
                                                      ),



                                                      Container(
                                                          padding:EdgeInsets.only(top:10,left:20,right:20,bottom:20),
                                                          child:Row(
                                                            children: [
                                                              Icon(Icons.check),
                                                              SizedBox(width:10),
                                                              Expanded(
                                                                child:Container(

                                                                  child:RichText(
                                                                    text: new TextSpan(text: S.of(context).shop_type,
                                                                        style: Theme.of(context).textTheme.subtitle2
                                                                            .merge(TextStyle(color: Color(0xFF8c98a8).withOpacity(1.0),)),
                                                                        children: [
                                                                          TextSpan(
                                                                              text:  _con.MemberPlanList[index].typeName,
                                                                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Colors.black))
                                                                          ),

                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          )
                                                      ),



                                                    ]
                                                )
                                              ]
                                          ),
                                        ),
                                      ),
                                    )
                                );
                              })
                          )
                      ),


                      SizedBox(height: 20),
                    ])),
          ],
        ),
      ),
    );



  }

  // ignore: non_constant_identifier_names
  Imagepickerbottomsheet(id, Details) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new ListTile(
                  leading: new Icon(Icons.adjust_sharp),
                  title: new Text('ID: $id'),
                  onTap: () => {
                    Navigator.pop(context),

                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.edit),
                  title: new Text(S.of(context).edit),
                  onTap: () => {
                  AddEdPopupHelper.exit(context, _con, Details, 'edit'),
                    Navigator.pop(context),
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.delete),
                  title: new Text(S.of(context).delete),
                  onTap: ()  async{
                    await _con.delete('vendor_membership',id);

                    Navigator.pop(context);
                    setState(() {_con.MemberPlanList.clear();});

                  },
                ),
              ],
            ),
          );
        });
  }

}




class AddEdPopupHelper {
  static exit(context,con,details, pageType) => showDialog(context: context, builder: (context)=> StatefulBuilder(builder: (context, StateSetter setState) =>  AEVendorMembershipWidget(con: con,memberdetails: details,pageType: pageType,setState: setState, )));
}