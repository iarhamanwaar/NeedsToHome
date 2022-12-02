import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../helpers/helper.dart';
import '../models/recharge.dart';
import '../models/wallet_transactions.dart';
import '../repository/user_repository.dart';
import '../models/wallet.dart';
import '../repository/wallet_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class WalletController extends ControllerMVC {
  List<WalletTransactions> walletTransactionList = <WalletTransactions>[];
  GlobalKey<ScaffoldState> scaffoldKey;
  Recharge rechargeData = new Recharge();
  Wallet walletData=Wallet();

  // ignore: non_constant_identifier_names
  GlobalKey<FormState> RechargeFormKey;
  OverlayEntry loader;

  WalletController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    RechargeFormKey = new GlobalKey<FormState>();
    listenForWallet();
    loader = Helper.overlayLoader(context);
  }


  Future<void> listenForWallet() async {
    getWallet().then((value) {
      setState(() {
        //loaderData = true;
        walletData = value;
      } );

    });
  }

  Future<void> listenForWalletTransaction(type) async {
    final Stream<WalletTransactions> stream = await getTransaction(type);
    stream.listen((WalletTransactions _walletAmount) {
      setState(() => walletTransactionList.add(_walletAmount));
      walletTransactionList.forEach((element) {
        print(element.balance);
      });
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }


  recharge(amount) {

      rechargeData.user_id = currentUser.value.id;
      rechargeData.type = 'credit';
      rechargeData.amount=amount;
      Overlay.of(context).insert(loader);
      SendRecharge(rechargeData).then((value) {
        if (value == true) {
          Navigator.of(context).pushReplacementNamed('/Thankyou');
        } else {
          // ignore: deprecated_member_use
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('Error'),
          ));
        }
      }).catchError((e) {
        loader.remove();
        // ignore: deprecated_member_use
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('Error'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });

  }

  showToast(message){
    Fluttertoast.showToast(
      msg:  message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
    );
  }
}