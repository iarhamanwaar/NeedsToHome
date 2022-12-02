
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/pages/otp_verification_email.dart';
import 'package:toast/toast.dart';
import '../models/registermodel.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../helpers/helper.dart';
import '../models/user.dart';
import '../repository/user_repository.dart' as repository;
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';

class UserController extends ControllerMVC {
  UserLocal user = new UserLocal();
  RegisterModel registerData = RegisterModel();
  bool hidePassword = true;
  Address addressData = Address();
  bool loading = false;
  String otpNumber;

  Map _userObj = {};
  final googleSignIn = GoogleSignIn();
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<ScaffoldState> scaffoldKeyState;
  TextEditingController emailController;
  TextEditingController phoneController;
  OverlayEntry loader;
  // ignore: non_constant_identifier_names
  RegisterModel register_data = new RegisterModel();

  UserController() {
    loader = Helper.overlayLoader(context);
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    this.scaffoldKeyState = new GlobalKey<ScaffoldState>();
    emailController = TextEditingController();
    phoneController = TextEditingController();

    //  listenForAddress();

  }



  void login() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);
      repository.login(user).then((value) {
        Helper.hideLoader(loader);
        if (value != null && value.apiToken != null) {
        /**  Fluttertoast.showToast(
            msg: "${S.of(context).login} ${S.of(context).successfully}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
          ); */
        gettoken();



          if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0) {

            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          }else{
            Navigator.of(context).pushReplacementNamed('/location');
          }
        } else {
          // ignore: deprecated_member_use
          scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).wrong_email_or_password),
          ));
        }
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_account_not_exist),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  handleLogin(){
    Overlay.of(context).insert(loader);
    FacebookAuth.instance.login(
        permissions: ["public_profile", "email"]).then((value) {
      FacebookAuth.instance.getUserData().then((userData) {

        setState(() {
          _userObj = userData;
        });

        registerData.name = _userObj["name"];

        registerData.phone = _userObj["phone"];
        registerData.email_id = _userObj["email"];
        registerData.loginType = 'smart';
        registerData.regVia    = 'Fb';
        registerData.img       = _userObj["picture"]["data"]["url"];

        repository.smartLogin(registerData).then((value) {

          if (value.auth == true) {

            showToast("${S.of(context).register} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
            if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0) {
              gettoken();

              Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
            }else{
              Navigator.of(context).pushReplacementNamed('/location');
            }
          } else {
            // ignore: deprecated_member_use
            scaffoldKey?.currentState?.showSnackBar(SnackBar(
              content: Text(S.of(context).this_email_account_exists),
            ));
          }
        }).catchError((e) {
          Helper.hideLoader(loader);
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      }).onError((error, stackTrace)  {
        Helper.hideLoader(loader);
      });
  });



  }

  gettoken() {


    FirebaseMessaging.instance.getToken().then((deviceid) {

      var table = 'user' + currentUser.value.id;
      FirebaseFirestore.instance.collection('devToken').doc(table).set({'devToken': deviceid, 'userId': currentUser.value.id}).catchError((e) {
        print('firebase error');
        print(e);

      }).then((value) {

      });
    });
  }

  void saveAddress(){
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();

      setState(() => currentUser.value.address.add(addressData));
      setCurrentUserUpdate(currentUser.value);
      Navigator.pop(context);
    }
  }

  void register() async {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.currentUser.value.email = register_data.email_id;
      repository.currentUser.value.phone = register_data.phone;
      repository.currentUser.value.name = register_data.name;
      register_data.regVia = repository.currentUser.value.loginVia;
      currentUser.value.description = register_data.description;
      repository.setCurrentUserUpdate(currentUser.value);
      Overlay.of(context).insert(loader);
      repository.register(register_data).then((value) {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).success),
        ));
        Navigator.pop(context, true);
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }


  void otpVerification(email, con) {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      var rng = new Random();

      String code = (rng.nextInt(9000) + 1000).toString();
      repository.resetPassword(email, code).then((value) {

      }).whenComplete(() {

      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OtpVerificationEmail(email: email,otp: code,con: con,)));
    }
  }

  void resetPassword(email, otp) {
    FocusScope.of(context).unfocus();
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      repository.resetPassword(email, otp).then((value) {
        if (value != null && value == true) {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).your_reset_link_has_been_sent_to_your_email),
            action: SnackBarAction(
              label: S.of(context).login,
              onPressed: () {

              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          loader.remove();
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).error_verify_email_settings),
          ));
        }
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  updatePassword(RegisterModel user) {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      Overlay.of(context).insert(loader);

      repository.updatePassword(user).then((value) {

        Navigator.of(context).pushReplacementNamed('/Login');

      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKeyState?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  Future googleLogin() async {

    Overlay.of(context).insert(loader);
    final user = await googleSignIn.signIn();
    if (user == null) {
      Helper.hideLoader(loader);
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );


      await FirebaseAuth.instance.signInWithCredential(credential);


      final userData = FirebaseAuth.instance.currentUser;
      registerData.name = userData.displayName;
     // registerData.phone = userData.phoneNumber;
      registerData.email_id = user.email;
      registerData.loginType = 'smart';
      registerData.regVia    = 'GMail';
      registerData.img       = userData.photoURL;


      repository.smartLogin(registerData).then((value) {

        if (value.auth == true) {

          showToast("${S.of(context).register} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
          if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0) {


            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
          }else{
            Navigator.of(context).pushReplacementNamed('/location');
          }
        } else {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).this_email_account_exists),
          ));
        }
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }).whenComplete(() {
        gettoken();
        Helper.hideLoader(loader);
      });

      // Navigator.of(context).pushReplacementNamed('/Pages', arguments: 1);
    }
  }



  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {


    try {
      Overlay.of(context).insert(loader);
      final authCredential =
      await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);



      if(authCredential?.user != null){


        registerData.name = authCredential.user.displayName;
        registerData.phone = authCredential.user.phoneNumber;
        registerData.email_id = authCredential.user.email;
        registerData.loginType = 'smart';
        registerData.regVia    = 'Phone';
        repository.smartLogin(registerData).then((value) {

          if (value.auth == true) {

            showToast("${S.of(context).register} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
            if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0) {
              gettoken();

              Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
            }else{
              Navigator.of(context).pushReplacementNamed('/location');
            }
          } else {
            // ignore: deprecated_member_use
            scaffoldKey?.currentState?.showSnackBar(SnackBar(
              content: Text(S.of(context).this_email_account_exists),
            ));
          }
        }).catchError((e) {
          loader.remove();
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).this_email_account_exists),
          ));
        }).whenComplete(() {
          Helper.hideLoader(loader);
        });
      }

    } on FirebaseAuthException catch (e) {
      print(e.message);
      Helper.hideLoader(loader);
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar((SnackBar(content: Text(e.message))));
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }


  /*  Future<void> handleLogin() async {
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
    case FacebookLoginStatus.cancelledByUser:
    break;
    case FacebookLoginStatus.error:
    break;
    case FacebookLoginStatus.loggedIn:
    try {
    await loginWithfacebook(result);
    } catch (e) {
      print('firebase login error');
    print('error');
    print(e);
    }
    break;
    }
    } */










 /* Future loginWithfacebook(FacebookLoginResult result) async {

    final FacebookAccessToken accessToken = result.accessToken;
    AuthCredential credential =
    FacebookAuthProvider.credential(accessToken.token);
    var a = await FirebaseAuth.instance.signInWithCredential(credential);
    Overlay.of(context).insert(loader);

    registerData.name = a.user.displayName;
    registerData.phone = a.user.phoneNumber;
    registerData.email_id = a.user.email;
    registerData.loginType = 'smart';
    registerData.regVia    = 'Fb';
    registerData.img       = a.user.photoURL;


    repository.smartLogin(registerData).then((value) {

      if (value.auth == true) {

        showToast("${S.of(context).register} ${S.of(context).successfully}", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
        if(currentUser.value.latitude!=0.0 && currentUser.value.longitude!=0.0) {
          gettoken();

          Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
        }else{
          Navigator.of(context).pushReplacementNamed('/location');
        }
      } else {
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(S.of(context).this_email_account_exists),
        ));
      }
    }).catchError((e) {
      loader.remove();
      // ignore: deprecated_member_use
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text(S.of(context).this_email_account_exists),
      ));
    }).whenComplete(() {
      Helper.hideLoader(loader);
    });



    } */

  Future<void> listenForCheckValue(table, col, para, type) async {

    checkValue(table, col, para).then((value) {
      if(value){
        if(type=='Email'){
          setState(() => emailController.text = '');
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text(S.of(context).this_email_account_exists),
          ));
        }
      }
    }).catchError((e) {

    }).whenComplete(() {

    });
  }



}
