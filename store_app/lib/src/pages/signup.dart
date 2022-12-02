import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/components/constants.dart';
import 'package:login_and_signup_web/src/controllers/user_controller.dart';
import 'package:login_and_signup_web/src/models/Dropdown.dart';
import 'package:login_and_signup_web/generated/l10n.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  final Function onLogInSelected;
  UserController con;
  SignUp({@required this.onLogInSelected, this.con});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.con.listenForDropdown('shop_focus', 'title', 'status', 'success');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Padding(
        padding: EdgeInsets.all(17),
        child: Center(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              height: size.height *
                  (size.height > 770
                      ? 0.7
                      : size.height > 670
                          ? 0.8
                          : 0.9),
              width: 520,
              color: Theme.of(context).primaryColor,
              child: Form(
                key: widget.con.registerFormKey,
                child: Center(
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(size.width > 670 ? 30 : 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              S.of(context).signup,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: 30,
                              child: Divider(
                                color: kPrimaryColor,
                                thickness: 2,
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              onSaved: (input) =>
                                  widget.con.registerData.name = input,
                              validator: (input) => input.length < 1
                                  ? S.of(context).should_be_more_than_3_characters
                                  : null,
                              decoration: InputDecoration(
                                hintText:  S.of(context).shop_name,
                                labelText: S.of(context).shop_name,
                                suffixIcon: Icon(
                                  Icons.store_mall_directory_rounded,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              onSaved: (input) =>
                                  widget.con.registerData.emailId = input,
                              keyboardType: TextInputType.emailAddress,
                              validator: (input) => !input.contains('@')
                                  ? S.of(context).should_be_valid_email
                                  : null,
                              decoration: InputDecoration(
                                hintText:  S.of(context).email,
                                labelText: S.of(context).email,
                                suffixIcon: Icon(
                                  Icons.mail_outline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Container(
                              width: double.infinity,
                              child: DropdownButton(
                                  value: _value, //
                                  isExpanded: true,
                                  focusColor:
                                      Theme.of(context).colorScheme.secondary,
                                  underline: Container(
                                    color: Colors.grey[300],
                                    height: 0.8,
                                  ),
                                  items: widget.con.dropDownList
                                      .map((DropDownModel map) {
                                    return new DropdownMenuItem(
                                      value: map.id,
                                      child: new Text(map.name,
                                          style: new TextStyle(
                                              color: Colors.black)),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      //  _con.subcategoryData.categoryId = value;
                                      widget.con.registerData.shopTypeId =
                                          value;
                                      _value = value;
                                    });
                                  }),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              onSaved: (input) =>
                                  widget.con.registerData.phone = input,
                              validator: (input) => input.length <= 0
                                  ? S.of(context).invalid_mobile_number
                                  : null,
                              decoration: InputDecoration(
                                hintText:  S.of(context).phone,
                                labelText: S.of(context).phone,
                                suffixIcon: Icon(
                                  Icons.phone,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            TextFormField(
                              obscureText: true,
                              onSaved: (input) =>
                                  widget.con.registerData.password = input,
                              validator: (input) => input.length < 3
                                  ? S.of(context).should_be_more_than_3_characters
                                  : null,
                              decoration: InputDecoration(
                                hintText:  S.of(context).password,
                                labelText: S.of(context).password,
                                suffixIcon: Icon(
                                  Icons.lock_outline,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 64,
                            ),
                            InkWell(
                              onTap: () {
                                widget.con.register(widget.onLogInSelected);
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kPrimaryColor.withOpacity(0.2),
                                      spreadRadius: 4,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    S.of(context).register,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).already_have_an_account,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onLogInSelected();
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).login,
                                        style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
