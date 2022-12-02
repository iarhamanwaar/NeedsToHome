import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/src/models/language.dart';
import 'package:login_and_signup_web/src/models/timezone.dart';
import 'package:login_and_signup_web/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login_and_signup_web/generated/l10n.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:vrouter/vrouter.dart';

import '../components/constants.dart';




// ignore: must_be_immutable
class GeneralSettingsTabWidget extends StatefulWidget {
  GeneralSettingsTabWidget({Key key, this.con}) : super(key: key);
  UserController con;
  @override
  _GeneralSettingsTabWidgetState createState() => _GeneralSettingsTabWidgetState();
}


class _GeneralSettingsTabWidgetState extends StateMVC<GeneralSettingsTabWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  String value;
  bool status = false;
  String langDefault;
  LanguagesList languagesList;


  // ignore: non_constant_identifier_names
  bool smtp_status = false;
  String distancetype;
  @override
  void initState() {
    super.initState();
    languagesList = new LanguagesList();
    langDefault = setting.value.language;

    widget.con.listenForTimeZone(widget.con.settingDetails.general.timeZone);
    _tabController = TabController(vsync: this, length: 4);

    widget.con.listenForDropdownNC('currency_method', 'currency_name');

    widget.con.adminPayment.currencyPosition = widget.con.settingDetails.payment.currencyPosition;
    widget.con.adminGeneral.defaultLang = widget.con.settingDetails.general.defaultLang;
    widget.con.adminGeneral.timeZone = widget.con.settingDetails.general.timeZone;
    widget.con.delivery.instantDelivery = widget.con.settingDetails.delivery.instantDelivery;
    widget.con.delivery.autoassing = widget.con.settingDetails.delivery.autoassing;
    widget.con.delivery.deliveryTips = widget.con.settingDetails.delivery.deliveryTips;
    widget.con.delivery.deliverType = widget.con.settingDetails.delivery.deliverType;
    widget.con.delivery.scheduleCancellation = widget.con.settingDetails.delivery.scheduleCancellation;
    widget.con.delivery.takeawayCancellation = widget.con.settingDetails.delivery.takeawayCancellation;
    setState(() {
      distancetype = widget.con.settingDetails.delivery.deliverType;
    widget.con.adminPayment.currency = widget.con.settingDetails.payment.currency;
    });

  }




  int checkedItem = 0;
  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          children: [
            Checkbox(
              value: boolValue,
              onChanged: (bool value) {
                /// manage the state of each value
                setState(() {
                  switch (title) {
                    case "Smtp Status":
                      smtp_status = value;
                      break;


                  }
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top:13),
              child: Text(title,style:Theme.of(context).textTheme.bodyText1),
            ),

          ],
        )


      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:BoxDecoration(
        color:Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight:Radius.circular(8)
        )
      ),
      
      margin:EdgeInsets.only(bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [
          TabBar(
            controller: _tabController,
            isScrollable:true,
            indicatorColor: Color(0xFF5e078e),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text(S.of(context).general_settings),
              ),
              Tab(
                child: Text(S.of(context).payment_settings),
              ),
              Tab(
                child: Text(S.of(context).smtp_settings),
              ),
              Tab(
                child: Text(S.of(context).delivery_settings),
              )

            ],
          ),
          SizedBox(
            height: 550,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [

                Container(
                    child:Form(key:widget.con.adminGeneralFormKey,
                      child:SingleChildScrollView(
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[

                              Wrap(
                                  children:[
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                initialValue: widget.con.settingDetails.general.systemName,
                                                onSaved: (input) => widget.con.adminGeneral.systemName = input,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_system_name : null,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).system_name,
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.emailAddress,
                                                validator: (input) => !input.contains('@') ? S.of(context).should_be_valid_email : null,
                                                onSaved: (input) => widget.con.adminGeneral.email = input,
                                                initialValue: widget.con.settingDetails.general.email,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).system_email,

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
                                    ),

                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_system_title : null,
                                                onSaved: (input) => widget.con.adminGeneral.systemTitle = input,
                                                initialValue: widget.con.settingDetails.general.systemTitle,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).context_system_title,
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_api : null,
                                                onSaved: (input) => widget.con.adminGeneral.api = input,
                                                initialValue: widget.con.settingDetails.general.api,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).google_map_api,
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_api : null,
                                                onSaved: (input) => widget.con.adminGeneral.countryCode = input,
                                                initialValue: widget.con.settingDetails.general.countryCode,
                                                decoration: InputDecoration(
                                                  labelText: 'Country ISO CODE',
                                                  hintText:'EX:IN',
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.phone,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_phone_number : null,
                                                onSaved: (input) => widget.con.adminGeneral.dialCode = input,
                                                initialValue: widget.con.settingDetails.general.dialCode,
                                                decoration: InputDecoration(
                                                  labelText: 'Dial Code',
                                                  hintText:'EX:+91',
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
                                    ),

                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_phone_number : null,
                                                onSaved: (input) => widget.con.adminGeneral.phone = input,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter.digitsOnly
                                                ],
                                                initialValue: widget.con.settingDetails.general.phone,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).phone,
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_phone_number : null,
                                                onSaved: (input) => widget.con.adminGeneral.customerSupport = input,
                                                
                                                initialValue: widget.con.settingDetails.general.customerSupport,
                                                decoration: InputDecoration(
                                                  labelText: 'Customer Support (Whatsapp chat )',
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
                                    ),

                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(S.of(context).time_zone,style: TextStyle(fontSize: 10,color: Colors.grey),),
                                              DropdownButtonFormField(
                                                  value: widget.con.timezone, //
                                                  isExpanded: true,
                                                  focusColor:transparent,
                                                  validator: (value) => value == null ? S.of(context).please_select : null,
                                                  items: widget.con.timezoneList.map((TimeZone map) {
                                                    return new DropdownMenuItem(
                                                      value: map.id,
                                                      child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.con.timezone = value;
                                                    });
                                                    widget.con.adminGeneral.timeZone = value;
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(S.of(context).default_language,style: TextStyle(fontSize: 10,color: Colors.grey),),
                                              DropdownButton(
                                                  value: langDefault,
                                                  isExpanded: true,
                                                  focusColor: transparent,
                                                  underline: Container(
                                                    color: Colors.grey[300],
                                                    height: 1.0,
                                                  ),
                                                  items: languagesList.languages.map((Language map) {
                                                    return new DropdownMenuItem(
                                                      value: map.localName,
                                                      child: new Text(map.englishName, style: new TextStyle(color: Colors.black)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    var code;
                                                    languagesList.languages.forEach((_l) {
                                                      if(_l.localName==value){
                                                        code = _l.code;
                                                      }
                                                    });
                                                    var _lang = code.split("_");

                                                    setState(() {
                                                      setting.value.language = value;
                                                      langDefault = value;

                                                    });
                                                    widget.con.adminGeneral.defaultLang = code;

                                                    if (_lang.length > 1)
                                                     setting.value.mobileLanguage.value = new Locale(_lang.elementAt(0), _lang.elementAt(1));
                                                    else
                                                      setting.value.mobileLanguage.value = new Locale(_lang.elementAt(0));
                                                    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                                    setting.notifyListeners();

                                                       print( setting.value.language);
                                                    setting.value.language = value;
                                                   setDefaultLanguage(code);
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_phone_number : null,
                                                onSaved: (input) => widget.con.adminGeneral.featuredText = input,

                                                initialValue: widget.con.settingDetails.general.featuredText,
                                                decoration: InputDecoration(
                                                  labelText: 'Featured Text',
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
                                    ),


                                   /* Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(

                                              maxLines: 5,
                                              validator: (input) =>  input.length < 1 ? S.of(context).please_enter_addres : null,
                                              onSaved: (input) => widget.con.adminGeneral.address = input,
                                              initialValue: widget.con.settingDetails.general.address,
                                              decoration: InputDecoration.collapsed(
                                                hintText: S.of(context).address,

                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ), */
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:20,left:20,right:20),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: Theme.of(context).dividerColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: TextFormField(
                                              onSaved: (input) => widget.con.adminGeneral.description = input,
                                              initialValue: widget.con.settingDetails.general.description,
                                              maxLines: 5,
                                              decoration: InputDecoration.collapsed(
                                                hintText: S.of(context).description,
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(color: Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),




                                  ]
                              ),

                              SizedBox(height:40),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {

                                      },
                                      child: Container(

                                        padding:EdgeInsets.only(left:20),
                                        child: Container(
                                          width: 200,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(30),
                                            /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                          ),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            onPressed: () {
                                             widget.con.generalDetailsUpdate();


                                            },
                                            child: Center(
                                                child: Text(
                                                  S.of(context).submit,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ]
                        ),
                      ),)

                ),
                Container(child:Form( key:widget.con.paymentFormKey,child:SingleChildScrollView(
                    child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Wrap(
                              children:[
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children:[

                                          Text(S.of(context).currency),
                                          Container(
                                            width: double.infinity,

                                            child: DropdownButton(
                                                value: widget.con.settingDetails.payment.currency,
                                                isExpanded: true,
                                                focusColor: transparent,
                                                underline: Container(
                                                  color: Colors.grey[300],
                                                  height: 1.0,
                                                ),
                                                items: widget.con.dropDownList.map((DropDownModel map) {
                                                  return new DropdownMenuItem(
                                                    value: map.id,
                                                    child: new Text(map.name, style: new TextStyle(color: Colors.black)),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.con.settingDetails.payment.currency = value;
                                                    widget.con.adminPayment.currency = value;
                                                  });
                                                }),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                                Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Container(
                                      padding:EdgeInsets.only(top:10,left:20,right:20),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Padding(
                                            padding:EdgeInsets.only(top:20,),
                                            child:Wrap(
                                              children: [

                                                Padding(
                                                  padding:EdgeInsets.only(top:10,),
                                                  child:Text(S.of(context).show_currency_in_the_right_of_price),
                                                ),
                                                SizedBox(width:10),
                                                Container(
                                                  width:65,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Switch(
                                                      value:  widget.con.settingDetails.payment.currencyPosition,
                                                      onChanged: (value){
                                                        setState(() {
                                                          widget.con.settingDetails.payment.currencyPosition = value;
                                                          widget.con.adminPayment.currencyPosition = value;
                                                        });
                                                      },
                                                      activeTrackColor: Colors.lightGreenAccent,
                                                      activeColor: Colors.green,

                                                    ),
                                                  ),),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    )
                                ),


                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.minimumPurchase = input,
                                           initialValue: widget.con.settingDetails.payment.minimumPurchase,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).minimum_purchase,

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
                                ),
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.decimalPoints = input,
                                            initialValue: widget.con.settingDetails.payment.decimalPoints,
                                            decoration: InputDecoration(
                                              labelText: 'Number of decimal point',

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
                                ),
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.driverCommission = input,
                                            initialValue: widget.con.settingDetails.payment.driverCommission,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).delivery_boy_commission,

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
                                ),

                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.cancelTimer = input,
                                            initialValue: widget.con.settingDetails.payment.cancelTimer,
                                            decoration: InputDecoration(
                                              labelText: S.of(context).cancellation_time_limit_minutes,

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
                                ),
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,

                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.handyServiceTax = input,
                                            initialValue: widget.con.settingDetails.payment.handyServiceTax,
                                            decoration: InputDecoration(
                                              labelText: 'Handy Service Tax',
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
                                ),
                                Div(
                                  colS: 12,
                                  colM:6,
                                  colL:6,
                                  child:Padding(
                                    padding: EdgeInsets.only(top:10,left:20,right:20),
                                    child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                            onSaved: (input) => widget.con.adminPayment.handyServiceCommission = input,
                                            initialValue: widget.con.settingDetails.payment.handyServiceCommission,
                                            decoration: InputDecoration(
                                              labelText: "Handy  Service Commission",
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
                                ),
                                Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Container(
                                      padding:EdgeInsets.only(top:10,left:20,right:20),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Padding(
                                            padding:EdgeInsets.only(top:20,),
                                            child:Wrap(
                                              children: [

                                                Padding(
                                                  padding:EdgeInsets.only(top:10,),
                                                  child:Text('COD Gateway'),
                                                ),
                                                SizedBox(width:10),
                                                Container(
                                                  width:65,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Switch(
                                                      value:  widget.con.settingDetails.payment.codMode,
                                                      onChanged: (value){
                                                        setState(() {
                                                          widget.con.settingDetails.payment.codMode = value;
                                                          widget.con.adminPayment.codMode = value;
                                                        });
                                                      },
                                                      activeTrackColor: Colors.lightGreenAccent,
                                                      activeColor: Colors.green,

                                                    ),
                                                  ),),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    )
                                ),
                               /* Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Container(
                                      padding:EdgeInsets.only(top:10,left:20,right:20),
                                      child:Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Padding(
                                            padding:EdgeInsets.only(top:20,),
                                            child:Wrap(
                                              children: [

                                                Padding(
                                                  padding:EdgeInsets.only(top:10,),
                                                  child:Text('B2B'),
                                                ),
                                                SizedBox(width:10),
                                                Container(
                                                  width:65,
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Switch(
                                                      value:  widget.con.settingDetails.payment.codMode,
                                                      onChanged: (value){
                                                        setState(() {
                                                          widget.con.settingDetails.payment.codMode = value;
                                                          widget.con.adminPayment.codMode = value;
                                                        });
                                                      },
                                                      activeTrackColor: Colors.lightGreenAccent,
                                                      activeColor: Colors.green,

                                                    ),
                                                  ),),
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    )
                                ), */

                    Div(
                        colS: 4,
                        colM:4,
                        colL:4,
                        child:Padding(
                            padding: EdgeInsets.only(top:30,left:20,right:20),
                                child:InkWell(
                                    onTap: () {},
                                    child: Container(

                                      padding:EdgeInsets.only(left:20),
                                      child: Container(
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(30),
                                          /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                        ),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          onPressed: () {
                                            VRouter.of(context).to('/payment_gateway');

                                          },
                                          child: Center(
                                              child: Wrap(
                                                alignment: WrapAlignment.spaceBetween,
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children:[
                                                Text('goto payment gateway',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width:10),
                                                Icon(Icons.arrow_forward_outlined,color:Theme.of(context).primaryColorLight)
                                              ])),
                                        ),
                                      ),
                                    ))))








                              ]
                          ),
                          SizedBox(height:40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: () {},
                                  child: Container(

                                    padding:EdgeInsets.only(left:20),
                                    child: Container(
                                      width: 200,
                                      height: 45.0,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondary,
                                        borderRadius: BorderRadius.circular(30),
                                        /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                      ),
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                        onPressed: () {
                                            widget.con.paymentDetailsUpdate();

                                        },
                                        child: Center(
                                            child: Text(
                                              S.of(context).submit,
                                              style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                            )),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ]
                    )
                ),),

                ),
                Container(child:Form(key:widget.con.smtpFormKey,
                    child:SingleChildScrollView(
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              Wrap(
                                  children:[
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                onSaved: (input) => widget.con.smtp.host = input,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                initialValue: widget.con.settingDetails.smtp.host,

                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Host',
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                onSaved: (input) => widget.con.smtp.port = input,
                                                initialValue: widget.con.settingDetails.smtp.port,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Port',
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
                                    ),

                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                initialValue: widget.con.settingDetails.smtp.user,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                                onSaved: (input) => widget.con.smtp.user = input,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp User',
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
                                    ),
                                    Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_password : null,
                                                onSaved: (input) => widget.con.smtp.password = input,
                                                initialValue: widget.con.settingDetails.smtp.password,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: 'Smtp Password',
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
                                    ),





                                  ]
                              ),
                              SizedBox(height:40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Container(

                                        padding:EdgeInsets.only(left:20),
                                        child: Container(
                                          width: 200,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(30),
                                            /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                          ),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            onPressed: () {
                                          widget.con.smptDetailsUpdate();

                                            },
                                            child: Center(
                                                child: Text(
                                                  S.of(context).submit,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ]
                        )
                    )),

                ),
                Container(
                  child:Form( key:widget.con.deliveryFormKey,child:SingleChildScrollView(
                      child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Wrap(
                                children:[
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).delivery_tips),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value:  widget.con.settingDetails.delivery.deliveryTips,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.deliveryTips=value;
                                                            widget.con.delivery.deliveryTips = value;

                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                  ),
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).instance_delivery),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value:  widget.con.settingDetails.delivery.instantDelivery,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.instantDelivery=value;
                                                            widget.con.delivery.instantDelivery = value;

                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                  ),
                                  Div(
                                      colS: 12,
                                      colM:6,
                                      colL:6,
                                      child:Container(
                                        padding:EdgeInsets.only(top:10,left:20,right:20),
                                        child:Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [


                                            Padding(
                                              padding:EdgeInsets.only(top:20,),
                                              child:Wrap(
                                                children: [

                                                  Padding(
                                                    padding:EdgeInsets.only(top:10,),
                                                    child:Text(S.of(context).auto_assign),
                                                  ),
                                                  SizedBox(width:10),
                                                  Container(
                                                    width:65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget.con.settingDetails.delivery.autoassing,
                                                        onChanged: (value){
                                                          setState(() {
                                                            widget.con.settingDetails.delivery.autoassing=value;
                                                            widget.con.delivery.autoassing = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors.lightGreenAccent,
                                                        activeColor: Colors.green,

                                                      ),
                                                    ),),
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                  ),
                                  Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Padding(
                                      padding: EdgeInsets.only(top:10,left:20,right:20),
                                      child: Container(
                                          width: double.infinity,

                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.number,
                                              validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                              onSaved: (input) => widget.con.delivery.driverOrderLimit = input,
                                              initialValue:  widget.con.settingDetails.delivery.driverOrderLimit ,
                                              decoration: InputDecoration(
                                                labelText: 'Driver Order Limit (ongoing)',

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
                                  ),


                             /*     Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Padding(
                                      padding: EdgeInsets.only(top:10,left:20,right:20),
                                      child: Container(
                                          width: double.infinity,

                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.con.settingDetails.delivery.radius.toString(),
                                              validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                              onSaved: (input) => widget.con.delivery.radius = double.parse(input) ,
                                              decoration: InputDecoration(
                                                labelText: S.of(context).coverage_radius,
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
                                  ),


                                  Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Padding(
                                      padding: EdgeInsets.only(top:10,left:20,right:20),
                                      child: Container(
                                          width: double.infinity,

                                          child: TextFormField(
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.number,
                                              initialValue: widget.con.settingDetails.delivery.driverRadius.toString(),
                                              validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                              onSaved: (input) => widget.con.delivery.driverRadius = double.parse(input) ,
                                              decoration: InputDecoration(
                                                labelText: 'S.of(context).driver_coverage_distance',
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
                                  ), */

                                  Div(
                                    colS: 12,
                                    colM:6,
                                    colL:6,
                                    child:Padding(
                                      padding: EdgeInsets.only(top:20,left:20,right:20),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Distance type',style: TextStyle(fontSize: 10,color: Colors.grey),),
                                            DropdownButtonFormField(
                                                value:distancetype, //
                                                isExpanded: true,
                                                focusColor: transparent,
                                                validator: (value) => value == null ? S.of(context).please_select : null,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text("Km"),
                                                    value: 'km',
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text("Miles"),
                                                    value: 'miles',
                                                  ),
                                                ],
                                                onChanged: (value) {
                                                  setState(() {
                                                    distancetype = value;
                                                  });
                                                  widget.con.delivery.deliverType = distancetype;
                                                }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ]
                            ),
                            Div(
                                colS: 12,
                                colM:6,
                                colL:6,
                                child:Container(
                                  padding:EdgeInsets.only(top:10,left:20,right:20),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding:EdgeInsets.only(top:20,),
                                        child:Wrap(
                                          children: [

                                            Padding(
                                              padding:EdgeInsets.only(top:10,),
                                              child:Text('Scheduled order cancellation'),
                                            ),
                                            SizedBox(width:10),
                                            Container(
                                              width:65,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Switch(
                                                  value: widget.con.settingDetails.delivery.scheduleCancellation,
                                                  onChanged: (value){
                                                    setState(() {
                                                      widget.con.settingDetails.delivery.scheduleCancellation=value;
                                                      widget.con.delivery.scheduleCancellation = value;
                                                    });
                                                  },
                                                  activeTrackColor: Colors.lightGreenAccent,
                                                  activeColor: Colors.green,

                                                ),
                                              ),),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                )
                            ),
                            Div(
                              colS: 12,
                              colM:6,
                              colL:6,
                              child:Padding(
                                padding: EdgeInsets.only(top:10,left:20,right:20),
                                child: Container(
                                    width: double.infinity,

                                    child: TextFormField(
                                        textAlign: TextAlign.left,
                                        autocorrect: true,
                                        keyboardType: TextInputType.number,
                                        validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        onSaved: (input) => widget.con.delivery.scheduleCancellationTimeLimit = input,
                                        initialValue:  widget.con.settingDetails.delivery.scheduleCancellationTimeLimit ,
                                        decoration: InputDecoration(
                                          labelText: 'Scheduled order cancellation time limit (sec)',

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
                            ),
                            Div(
                                colS: 12,
                                colM:6,
                                colL:6,
                                child:Container(
                                  padding:EdgeInsets.only(top:10,left:20,right:20),
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding:EdgeInsets.only(top:20,),
                                        child:Wrap(
                                          children: [

                                            Padding(
                                              padding:EdgeInsets.only(top:10,),
                                              child:Text('Takeaway order cancellation'),
                                            ),
                                            SizedBox(width:10),
                                            Container(
                                              width:65,
                                              child: GestureDetector(
                                                onTap: () {},
                                                child: Switch(
                                                  value: widget.con.settingDetails.delivery.takeawayCancellation,
                                                  onChanged: (value){
                                                    setState(() {
                                                      widget.con.settingDetails.delivery.takeawayCancellation=value;
                                                      widget.con.delivery.takeawayCancellation = value;
                                                    });
                                                  },
                                                  activeTrackColor: Colors.lightGreenAccent,
                                                  activeColor: Colors.green,

                                                ),
                                              ),),
                                          ],
                                        ),
                                      ),


                                    ],
                                  ),
                                )
                            ),
                            Div(
                              colS: 12,
                              colM:6,
                              colL:6,
                              child:Padding(
                                padding: EdgeInsets.only(top:10,left:20,right:20),
                                child: Container(
                                    width: double.infinity,

                                    child: TextFormField(
                                        textAlign: TextAlign.left,
                                        autocorrect: true,
                                        keyboardType: TextInputType.number,
                                        validator: (input) =>  input.length < 1 ? S.of(context).please_enter_the_value : null,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                        onSaved: (input) => widget.con.delivery.takeawayCancellationTimeLimit = input,
                                        initialValue:  widget.con.settingDetails.delivery.takeawayCancellationTimeLimit ,
                                        decoration: InputDecoration(
                                          labelText: 'Takeaway order cancellation time limit (sec)',

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
                            ),
                            SizedBox(height:40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: Container(

                                      padding:EdgeInsets.only(left:20),
                                      child: Container(
                                        width: 200,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondary,
                                          borderRadius: BorderRadius.circular(30),
                                          /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                        ),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          onPressed: () {
                                           widget.con.deliveryDetailsUpdate();

                                          },
                                          child: Center(
                                              child: Text(
                                                S.of(context).submit,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ]
                      )
                  ),),

                ),


              ],
            ),
          ),
        ],
      ),
    );
  }
}
