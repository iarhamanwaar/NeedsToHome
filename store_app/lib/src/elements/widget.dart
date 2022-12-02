
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/repository/user_repository.dart';
import 'package:map_picker_flutter/mpicker_templates.dart';
import 'package:responsive_ui/responsive_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CardWidget.dart';
import 'package:intl/intl.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class ProfileTweets extends StatefulWidget {
  ProfileTweets({this.con});
  @override
  _ProfileTweetsState createState() => _ProfileTweetsState();
  UserController con;
}

final control = TextEditingController();

class _ProfileTweetsState extends State<ProfileTweets>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    widget.con.generalModel.openingTime =
        widget.con.profileDetails.general.openingTime;
    widget.con.generalModel.closingTime =
        widget.con.profileDetails.general.closingTime;
    widget.con.generalModel.holidays.monVal =
        widget.con.profileDetails.general.holidays.monVal;
    widget.con.generalModel.holidays.tueVal =
        widget.con.profileDetails.general.holidays.tueVal;
    widget.con.generalModel.holidays.wedVal =
        widget.con.profileDetails.general.holidays.wedVal;
    widget.con.generalModel.holidays.thurVal =
        widget.con.profileDetails.general.holidays.thurVal;
    widget.con.generalModel.holidays.friVal =
        widget.con.profileDetails.general.holidays.friVal;
    widget.con.generalModel.holidays.satVal =
        widget.con.profileDetails.general.holidays.satVal;
    widget.con.generalModel.holidays.sunVal =
        widget.con.profileDetails.general.holidays.sunVal;
    widget.con.bankModel.businessType =
        widget.con.profileDetails.bankDetails.businessType;
    widget.con.deliverySettingData.allowAllDeliveryBoys =
        widget.con.profileDetails.deliverySettings.allowAllDeliveryBoys;
    widget.con.deliverySettingData.autoAssign =
        widget.con.profileDetails.deliverySettings.autoAssign;
    widget.con.deliverySettingData.instantDelivery =
        widget.con.profileDetails.deliverySettings.instantDelivery;
    widget.con.deliverySettingData.scheduleDelivery =
        widget.con.profileDetails.deliverySettings.scheduleDelivery;
    widget.con.deliverySettingData.takeaway =
        widget.con.profileDetails.deliverySettings.takeaway;
    _tabController = TabController(vsync: this, length: 3);

    super.initState();
  }

  int checkedItem = 0;

  Widget checkbox(String title, bool boolValue) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "MON":
                  widget.con.generalModel.holidays.monVal = value;
                  widget.con.profileDetails.general.holidays.monVal = value;
                  break;
                case "TUE":
                  widget.con.generalModel.holidays.tueVal = value;
                  widget.con.profileDetails.general.holidays.tueVal = value;
                  break;
                case "WED":
                  widget.con.generalModel.holidays.wedVal = value;
                  widget.con.profileDetails.general.holidays.wedVal = value;
                  break;
                case "THU":
                  widget.con.generalModel.holidays.thurVal = value;
                  widget.con.profileDetails.general.holidays.thurVal = value;
                  break;
                case "FRI":
                  widget.con.generalModel.holidays.friVal = value;
                  widget.con.profileDetails.general.holidays.friVal = value;
                  break;
                case "SAT":
                  widget.con.generalModel.holidays.satVal = value;
                  widget.con.profileDetails.general.holidays.satVal = value;
                  break;
                case "SUN":
                  widget.con.generalModel.holidays.sunVal = value;
                  widget.con.profileDetails.general.holidays.sunVal = value;
                  break;
              }
            });
          },
        )
      ],
    );
  }

  _selectTime(type) async {
    TimeOfDay selectedTime = TimeOfDay(
        hour: int.parse(DateFormat('kk').format(DateTime.now())),
        minute: int.parse(DateFormat('mm').format(DateTime.now())));
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Theme.of(context).colorScheme.secondary,
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.light(
                  primary: Theme.of(context).colorScheme.secondary).copyWith(secondary: Theme.of(context).colorScheme.secondary),
            ),
            child: child,
          );
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;

        if (type == 'open') {
          widget.con.generalModel.openingTime = picked.format(context);
          widget.con.openTime.text = picked.format(context);
        } else {
          widget.con.generalModel.closingTime = picked.format(context);
          widget.con.closeTime.text = picked.format(context);
        }

        /**_setTime = timePicker.formatDate(
            DateTime(year, month, day, selectedTime.hour, selectedTime.minute), [timePicker.hh, ':', timePicker.nn, " ", timePicker.am]).toString();
 */
      });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    MapPicker.init(
        theme: MPickerTheme(

            /// # Initial Location
            initialLocation: LatLng(-23.572143, -46.613275),

            /// # Text showed when address is not founded
            errorAddressMissing: 'Error, address don\'t founded.',

            /// # Text showed when gets error during find address
            errorToFindAddress: 'Error to find this address, try again.',

            /// # Initial text when don`t has any address selected
            withoutAddress: 'Without Address Picked',

            /// # Here the texts showed in [TextField] case you don`t use a custom
            searchHint: 'Type here...',
            searchLabel: 'Search:',

            /// # Language of return of google maps api
            lang: 'pt-BR'),
        key: 'AIzaSyDjJk2l2-0PxawqpgQ2BYVDNRbzqCvHMrw');
    return AppCard(
      margin:EdgeInsets.only(left:size.width>769? 15:0,right:size.width>769? 15:0,bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: widget.con.profileDetails.general?.storeName == ''
          ? Container()
          : Column(
              children: [
                TabBar(
                   isScrollable: true,
                  controller: _tabController,
                  indicatorColor: Color(0xFF5e078e),
                  unselectedLabelColor: Colors.grey,
                  //labelColor: Colors.black,
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  tabs: [
                    Tab(
                      child: Text(S.of(context).general_details),
                    ),
                    Tab(
                      child: Text(S.of(context).kyc_settings),
                    ),
                    Tab(
                      child: Text(
                          'SM settings & ${S.of(context).password_change}'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 700,
                  child: TabBarView(
                    controller: _tabController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        child: Form(
                          key: widget.con.generalFormKey,
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(children: [
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .ownerName = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .ownerName,
                                                validator: (input) =>
                                                    input.length <= 1
                                                        ? S
                                                            .of(context)
                                                            .provide_your_name
                                                        : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S.of(context).name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .storeName = input,
                                                initialValue:
                                                    currentUser.value.shopName,
                                                enabled: false,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_shop_name
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).shop_name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .companyLegalName = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .companyLegalName,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_subtitle
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .company_legal_name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                // onSaved: (input) => widget.con.generalModel.companyLegalName = input,

                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .business,
                                                //validator: (input) =>  input.length<= 1 ? S.of(context).please_select_your_business_type : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .business_type,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .subtitle = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .subtitle,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_subtitle
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).subtitle,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .subtitle = input,
                                                initialValue:
                                                    currentUser.value.email,
                                                enabled: false,
                                                validator: (input) => !input
                                                        .contains('@')
                                                    ? S
                                                        .of(context)
                                                        .should_be_valid_email
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).email,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .mobile = input,
                                                initialValue:
                                                    currentUser.value.phone,
                                                enabled: false,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).phone,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .alterMobile = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .alterMobile,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .alternative_mobile,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                controller: widget.con.openTime,
                                                keyboardType:
                                                    TextInputType.text,
                                                onTap: () {
                                                  _selectTime('open');
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).open_time,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                controller:
                                                    widget.con.closeTime,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                onTap: () {
                                                  _selectTime('close');
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).close_time,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .pickupAddress = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .pickupAddress,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_your_address
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).address,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .pinCode = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .pinCode,
                                                validator: (input) =>
                                                    input.length <= 1
                                                        ? 'Enter your zipcode'
                                                        : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).zipcode,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .landmark = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .landmark,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_your_landmark
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).landmark,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                        colS: 12,
                                        colM: 12,
                                        colL: 12,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 20, right: 20),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                final url =
                                                    'https://www.latlong.net/convert-address-to-lat-long.html';
                                                if (await canLaunch(url)) {
                                                  await launch(
                                                    url,
                                                    forceSafariVC: false,
                                                  );
                                                }
                                                /**  MapPickerTemplate.dialogAddressPicker(
                                                /// # Here you can pass your custom widget to put text and search
                                                  searchBuilder: (search) => Card(child: TextField(decoration: InputDecoration(labelText: 'Search:', hintText: 'Type here...', prefixIcon: IconButton(icon: Icon(Icons.arrow_back_outlined), onPressed: () => Navigator.pop(context)), suffixIcon: IconButton(icon: Icon(Icons.search),
                                                      /// # To search, just call the method `search` passing the address string
                                                      onPressed: () => search(control.text))), controller: control)),
                                                  /// # Here your custom widget to show current selected address
                                                  addressBuilder: (txt, done) => Card(
                                                    /// # Case you want put a button here to done the process, you just need call `done` function
                                                      child: Container(padding: EdgeInsets.all(10), child: Text(txt, textAlign: TextAlign.center))),
                                                  /// # You can to pass your custom marker here
                                                  marker: Icon(Icons.location_pin, color: Colors.redAccent, size: 30),
                                                  /// # Text in negative button
                                                  btnCancel: 'Cancel',
                                                  /// # Text in positive button
                                                  btnSave: 'Save', context: context);*/
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                child: Text(S.of(context).help),
                                              ),
                                            ))),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .latitude = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .latitude
                                                    .toString(),
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_latitude
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).latitude,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .generalModel
                                                    .longitude = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .general
                                                    .longitude
                                                    .toString(),
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_enter_longitude
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).longitude,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Container(
                                        child: Div(
                                            colS: 12,
                                            colM: 6,
                                            colL: 6,
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                    left: MediaQuery.of(context)
                                                                .size
                                                                .width >
                                                            769
                                                        ? 20
                                                        : 0,
                                                    top: 30),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 20),
                                                          child: Text(
                                                              S.of(context).mention_your_holidays)),
                                                      Container(
                                                        height: 80,
                                                        width: double.infinity,
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: checkbox(
                                                                "MON",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .monVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "TUE",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .tueVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "WED",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .wedVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "THU",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .thurVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "FRI",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .friVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "SAT",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .satVal,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: checkbox(
                                                                "SUN",
                                                                widget
                                                                    .con
                                                                    .profileDetails
                                                                    .general
                                                                    .holidays
                                                                    .sunVal,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ])))),
                                  ]),
                                  SizedBox(height: 40),
                                  InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: size.width * 0.16,
                                            right: size.width * 0.16),
                                        child: Container(
                                          width: double.infinity,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).colorScheme.secondary,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            /*borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))*/
                                          ),
                                          // ignore: deprecated_member_use
                                          child: FlatButton(
                                            onPressed: () {
                                              widget.con.update();
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
                                ]),
                          ),
                        ),
                      ),
                      Container(
                        child: Form(
                          key: widget.con.bankFormKey,
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Div(
                                    colS: 12,
                                    colM: 6,
                                    colL: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Container(
                                        //margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.width > 769 ? 20 : 10, right: MediaQuery.of(context).size.width > 769 ? 20 : 10),
                                        child: Text(
                                          S.of(context).seller_kyc,
                                          style: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  769
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headline1,
                                        ),
                                      ),
                                    )),
                                Wrap(runSpacing: 10, children: [
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 20, right: 20),
                                          child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  onSaved: (input) => widget
                                                      .con
                                                      .bankModel
                                                      .personalProof = input,
                                                  initialValue: widget
                                                      .con
                                                      .profileDetails
                                                      .bankDetails
                                                      .personalProof,
                                                  validator: (input) => input
                                                              .length <
                                                          1
                                                      ? S
                                                          .of(context)
                                                          .please_enter_the_personal_proof
                                                      : null,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    labelText: S
                                                        .of(context)
                                                        .personal_proof,
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                    // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ))))),
                                  Div(
                                    colS: 12,
                                    colM: 6,
                                    colL: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => widget
                                                  .con
                                                  .bankModel
                                                  .selectedYear = input,
                                              initialValue: widget
                                                  .con
                                                  .profileDetails
                                                  .bankDetails
                                                  .selectedYear,
                                              validator: (input) => input
                                                          .length <=
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_provide_started_year
                                                  : null,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText:
                                                    S.of(context).started_year,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                  ),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                          width: double.infinity,
                                          child: DropdownButtonFormField(
                                              value: widget.con.profileDetails
                                                  .bankDetails.businessType,
                                              // value: 'Partnership',
                                              isExpanded: true,
                                              validator: (input) => input
                                                          .length <
                                                      1
                                                  ? S
                                                      .of(context)
                                                      .please_select_your_business_type
                                                  : null,
                                              focusColor: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text(
                                                      "Private Limited Company"),
                                                  value:
                                                      'Private Limited Company',
                                                ),
                                                DropdownMenuItem(
                                                  child: Text(
                                                      "Limited Liability Partnership"),
                                                  value:
                                                      'Limited Liability Partnership',
                                                ),
                                                DropdownMenuItem(
                                                    child: Text("Partnership"),
                                                    value: 'Partnership'),
                                                DropdownMenuItem(
                                                    child: Text(
                                                        "Sole Proprietorship"),
                                                    value:
                                                        'Sole Proprietorship'),
                                                DropdownMenuItem(
                                                    child: Text(
                                                        "One Person Company"),
                                                    value:
                                                        'One Person Company'),
                                                DropdownMenuItem(
                                                    child: Text(S.of(context).startup),
                                                    value: 'Startup'),
                                                DropdownMenuItem(
                                                    child: Text("Other"),
                                                    value: 'Other'),
                                              ],
                                              onChanged: (value) {
                                                setState(() {
                                                  // _con.sellerKycData.businessType = value;
                                                });
                                              }),
                                        ),
                                      )),
                                ]),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 0,
                                      left: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 10,
                                      right: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 10),
                                  child: Text(
                                    S.of(context).holders_bank_details,
                                    style: MediaQuery.of(context).size.width >
                                            769
                                        ? Theme.of(context).textTheme.headline4
                                        : Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                SizedBox(width: 50),
                                Wrap(
                                  children: [
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget.con
                                                    .bankModel.bankName = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .bankDetails
                                                    .bankName,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_bank_name
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).bank_name,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                        colS: 12,
                                        colM: 6,
                                        colL: 6,
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20, right: 20),
                                            child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  onSaved: (input) => widget
                                                      .con
                                                      .bankModel
                                                      .holdersName = input,
                                                  initialValue: widget
                                                      .con
                                                      .profileDetails
                                                      .bankDetails
                                                      .holdersName,
                                                  validator: (input) => input
                                                              .length <
                                                          1
                                                      ? S
                                                          .of(context)
                                                          .please_enter_the_holders_name
                                                      : null,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    labelText: S
                                                        .of(context)
                                                        .holders_name,
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                    //    suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  )),
                                            ))),
                                    Div(
                                        colS: 12,
                                        colM: 6,
                                        colL: 6,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 20, right: 20),
                                          child: Container(
                                              width: double.infinity,
                                              child: TextFormField(
                                                  textAlign: TextAlign.left,
                                                  autocorrect: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (input) => input
                                                              .length <
                                                          1
                                                      ? S
                                                          .of(context)
                                                          .please_enter_the_branch
                                                      : null,
                                                  onSaved: (input) => widget.con
                                                      .bankModel.branch = input,
                                                  initialValue: widget
                                                      .con
                                                      .profileDetails
                                                      .bankDetails
                                                      .branch,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        S.of(context).branch,
                                                    labelStyle:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyText2
                                                            .merge(TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                    // suffixIcon: Tooltip(message: "Enter Your Store Name", child: Icon(Icons.help, color: Colors.grey)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ))),
                                        )),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget
                                                    .con
                                                    .bankModel
                                                    .accountNumber = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .bankDetails
                                                    .accountNumber,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_account_number
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <
                                                    TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                decoration: InputDecoration(
                                                  labelText: S
                                                      .of(context)
                                                      .account_number,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                    Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                onSaved: (input) => widget.con
                                                    .bankModel.bankCode = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .bankDetails
                                                    .bankCode,
                                                validator: (input) => input
                                                            .length <=
                                                        1
                                                    ? S
                                                        .of(context)
                                                        .please_provide_swift_code
                                                    : null,
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText:
                                                      S.of(context).swift_code,
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.16,
                                          right: size.width * 0.16),
                                      child: Container(
                                        width: double.infinity,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        // ignore: deprecated_member_use
                                        child: FlatButton(
                                          onPressed: () {
                                            widget.con.bankDetailsUpdate();
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
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 0,
                                      left: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 10,
                                      right: MediaQuery.of(context).size.width >
                                              769
                                          ? 20
                                          : 10),
                                  child: Text(
                                    S.of(context).delivery_settings,
                                    style: MediaQuery.of(context).size.width >
                                            769
                                        ? Theme.of(context).textTheme.headline4
                                        : Theme.of(context).textTheme.headline1,
                                  ),
                                ),
                                Wrap(children: [
                                  // setting.value.autoassing?
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(S
                                                        .of(context)
                                                        .auto_assign),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget
                                                            .con
                                                            .profileDetails
                                                            .deliverySettings
                                                            .autoAssign,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget
                                                                .con
                                                                .profileDetails
                                                                .deliverySettings
                                                                .autoAssign = value;
                                                            widget
                                                                .con
                                                                .deliverySettingData
                                                                .autoAssign = value;
                                                            /** widget.con.profileDetails.general.autoAssign=value;
                                                                  widget.con.generalModel.autoAssign = value; */
                                                          });
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(S
                                                        .of(context)
                                                        .allow_all_delivery_boys),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget
                                                            .con
                                                            .profileDetails
                                                            .deliverySettings
                                                            .allowAllDeliveryBoys,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            /**   widget.con.profileDetails.general.driverAssign=value;
                                                                  widget.con.generalModel.driverAssign = value; */
                                                            widget
                                                                .con
                                                                .profileDetails
                                                                .deliverySettings
                                                                .allowAllDeliveryBoys = value;
                                                            widget
                                                                .con
                                                                .deliverySettingData
                                                                .allowAllDeliveryBoys = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),

                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(S
                                                        .of(context)
                                                        .instant_delivery),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget
                                                            .con
                                                            .profileDetails
                                                            .deliverySettings
                                                            .instantDelivery,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget
                                                                .con
                                                                .profileDetails
                                                                .deliverySettings
                                                                .instantDelivery = value;
                                                            widget
                                                                .con
                                                                .deliverySettingData
                                                                .instantDelivery = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(
                                                        S.of(context).takeaway),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget
                                                            .con
                                                            .profileDetails
                                                            .deliverySettings
                                                            .takeaway,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget
                                                                .con
                                                                .profileDetails
                                                                .deliverySettings
                                                                .takeaway = value;
                                                            widget
                                                                .con
                                                                .deliverySettingData
                                                                .takeaway = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 20,
                                              ),
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 10,
                                                    ),
                                                    child: Text(S
                                                        .of(context)
                                                        .schedule_delivery),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Container(
                                                    width: 65,
                                                    child: GestureDetector(
                                                      onTap: () {},
                                                      child: Switch(
                                                        value: widget
                                                            .con
                                                            .profileDetails
                                                            .deliverySettings
                                                            .scheduleDelivery,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget
                                                                .con
                                                                .profileDetails
                                                                .deliverySettings
                                                                .scheduleDelivery = value;
                                                            widget
                                                                .con
                                                                .deliverySettingData
                                                                .scheduleDelivery = value;
                                                          });
                                                        },
                                                        activeTrackColor: Colors
                                                            .lightGreenAccent,
                                                        activeColor:
                                                            Colors.green,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                ]),
                                SizedBox(height: 40),
                                InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.16,
                                          right: size.width * 0.16),
                                      child: Container(
                                        width: double.infinity,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                              ])),
                        ),
                      ),
                      Container(
                          child: SingleChildScrollView(
                        child: Form(
                          key: widget.con.loginFormKey,
                          child: Column(children: [
                            Wrap(children: [
                              Div(
                                colS: 12,
                                colM: 12,
                                colL: 12,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                          textAlign: TextAlign.left,
                                          autocorrect: true,
                                          obscureText: true,
                                          onSaved: (input) =>
                                              widget.con.prePassword = input,
                                          validator: (input) => input.length < 1
                                              ? 'Please enter your current password'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText:
                                                S.of(context).current_password,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Colors.grey)),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ))),
                                ),
                              ),
                              Div(
                                colS: 12,
                                colM: 6,
                                colL: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                          textAlign: TextAlign.left,
                                          autocorrect: true,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          validator: (input) => input.length < 1
                                              ? 'Please enter your new password'
                                              : null,
                                          onSaved: (input) =>
                                              widget.con.password = input,
                                          decoration: InputDecoration(
                                            labelText:
                                                S.of(context).new_password,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Colors.grey)),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ))),
                                ),
                              ),
                              Div(
                                colS: 12,
                                colM: 6,
                                colL: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                          textAlign: TextAlign.left,
                                          autocorrect: true,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          onSaved: (input) =>
                                              widget.con.rePassword = input,
                                          validator: (input) => input.length < 1
                                              ? 'Please enter your confirm password'
                                              : null,
                                          decoration: InputDecoration(
                                            labelText:
                                                S.of(context).confirm_password,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(TextStyle(
                                                    color: Colors.grey)),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ))),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.16,
                                  right: size.width * 0.16),
                              child: Container(
                                width: double.infinity,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  onPressed: () {
                                    widget.con.passwordUpdate();
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
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width > 769
                                      ? 20
                                      : 0,
                                  left: MediaQuery.of(context).size.width > 769
                                      ? 20
                                      : 10,
                                  right: MediaQuery.of(context).size.width > 769
                                      ? 20
                                      : 10),
                              child: Text(
                                S.of(context).social_media_links,
                                style: MediaQuery.of(context).size.width > 769
                                    ? Theme.of(context).textTheme.headline4
                                    : Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            SizedBox(width: 50),
                            Form(
                              key: widget.con.registerFormKey,
                              child: Wrap(
                                children: [
                                  Div(
                                    colS: 12,
                                    colM: 6,
                                    colL: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => widget.con
                                                  .socialMedia.faceBook = input,
                                              initialValue: widget
                                                  .con
                                                  .profileDetails
                                                  .socialMedialLink
                                                  .faceBook,
                                              textAlign: TextAlign.left,
                                              autocorrect: true,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: 'FaceBook',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                  ),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 20, right: 20),
                                          child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                onSaved: (input) => widget
                                                    .con
                                                    .socialMedia
                                                    .whatsApp = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .socialMedialLink
                                                    .whatsApp,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  labelText: 'WhatsApp',
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                )),
                                          ))),
                                  Div(
                                      colS: 12,
                                      colM: 6,
                                      colL: 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10, left: 20, right: 20),
                                        child: Container(
                                            width: double.infinity,
                                            child: TextFormField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                onSaved: (input) => widget
                                                    .con
                                                    .socialMedia
                                                    .twitter = input,
                                                initialValue: widget
                                                    .con
                                                    .profileDetails
                                                    .socialMedialLink
                                                    .twitter,
                                                decoration: InputDecoration(
                                                  labelText: 'Twitter',
                                                  labelStyle: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .merge(TextStyle(
                                                          color: Colors.grey)),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ))),
                                      )),
                                  Div(
                                    colS: 12,
                                    colM: 6,
                                    colL: 6,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: 20, right: 20),
                                      child: Container(
                                          width: double.infinity,
                                          child: TextFormField(
                                              onSaved: (input) => widget
                                                  .con
                                                  .socialMedia
                                                  .instagram = input,
                                              initialValue: widget
                                                  .con
                                                  .profileDetails
                                                  .socialMedialLink
                                                  .instagram,
                                              textAlign: TextAlign.left,
                                              decoration: InputDecoration(
                                                labelText: 'Instagram',
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .merge(TextStyle(
                                                        color: Colors.grey)),
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.16,
                                  right: size.width * 0.16),
                              child: Container(
                                width: double.infinity,
                                height: 45.0,
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                // ignore: deprecated_member_use
                                child: FlatButton(
                                  onPressed: () {
                                    widget.con.socialMediaUpdate();
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
                            )
                          ]),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
