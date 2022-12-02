import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/wallet_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../Widget/creditCard.dart';
import 'package:multisuperstore/generated/l10n.dart';

import '../elements/HomeSliderLoaderWidget.dart';
import '../models/wallet.dart';
class CardsList extends StatefulWidget {
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends StateMVC<CardsList> {
  WalletController _con;
  _CardsListState() : super(WalletController()) {
    _con = controller;

  }




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 32.0, left: 15.0, right: 15.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(S.of(context).your_cards, style: Theme.of(context).textTheme.headline3),

              ],
            ),
          ),
        _con.walletList == null || _con.walletList.isEmpty
              ? HomeSliderLoaderWidget()
              :Container(
            height: 246.0,
            child: PageView.builder(
              itemCount: _con.walletList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Wallet _walletData = _con.walletList.elementAt(index);
                return  CreditCard(card: _walletData);
              },
            ),
          ),


        ],
      ),
    );
  }
}


