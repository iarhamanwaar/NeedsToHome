import 'package:flutter/material.dart';
import '../components/appbar.dart';
import '../components/cards.dart';
import '../components/recentTransactions.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   SafeArea(
        child: Container(
          child: Column(
            children: [
              Appbar(),
              CardsList(),
              RecentTransactions(PageType:'recent'),
            ],
          ),
        ),
      )
    );
  }
}
