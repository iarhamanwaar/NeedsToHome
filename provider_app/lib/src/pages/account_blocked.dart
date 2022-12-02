
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';

class AccountBlock extends StatefulWidget {
  @override
  _AccountBlockState createState() => _AccountBlockState();
}

class _AccountBlockState extends State<AccountBlock> {
  int dropDownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/img/block.png'),
                    width: 160,
                    height: 160,
                  ),
                  SizedBox(height: 15),
                  Text(
                    S.of(context).sorry_your_account_is_blocked,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  SizedBox(height: 15),
                  RichText(
                    text: new TextSpan(
                        text: S.of(context).please_contact,
                        style: Theme.of(context).textTheme.subtitle2,
                        children: [
                          new TextSpan(
                            text: '  admin@mps.com',
                            style: Theme.of(context).textTheme.subtitle2,
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Image(
                  image: AssetImage("assets/img/city.png"),
                  fit: BoxFit.fill,
                  height: 170,
                  width: MediaQuery.of(context).size.width),
            ),
          )
        ]));
  }
}
