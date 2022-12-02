import 'package:flutter/material.dart';
import 'package:login_and_signup_web/src/helpers/helper.dart';
import 'package:login_and_signup_web/src/models/vendorwallet.dart';
import 'package:login_and_signup_web/src/models/walletmodel.dart';
import 'package:login_and_signup_web/src/repository/wallet_repository.dart';
import 'package:toast/toast.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class WalletController extends ControllerMVC {

  // ignore: non_constant_identifier_names
  GlobalKey<FormState> RechargeFormKey;
  VendorWallet walletData=VendorWallet();
  WalletModel walletBannerData = WalletModel();
  List<VendorWallet> walletList=<VendorWallet>[];
  OverlayEntry loader;
  WalletController() {
    loader = Helper.overlayLoader(context);
  }


  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity ,);
  }

  Future<void> listenForWallet() async {
    setState(() => walletList.clear());
    final Stream<VendorWallet> stream = await getWallet();
    stream.listen((VendorWallet _banner) {
      setState(() => walletList.add(_banner));
    }, onError: (a) {
      print(a);
    }, onDone: () {
      print(walletList.length);
    });
  }

  listenForWalletBanner(){
    setState(() => walletBannerData = new WalletModel());
      getWalletBanner().then((value) {


        setState(() =>  walletBannerData = value);
      }).catchError((e) {


      }).whenComplete(() {

      });
    }

  requestAmount(rAmount, balance){

    if(balance!=0) {

      if(balance>double.parse(rAmount)) {
        Overlay.of(context).insert(loader);
        sendRequestAmount(rAmount).then((value) {
          showToast("Your request success fully", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
          Navigator.pop(context);
        }).whenComplete(() {
          Helper.hideLoader(loader);
          setState(() =>  walletList.clear());
          listenForWallet();
        });
      } else{
        showToast("Insufficient Balance", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
      }
    } else{
      showToast("Your wallet balance is 0", gravity: Toast.BOTTOM, duration: Toast.LENGTH_SHORT);
    }
  }



}




