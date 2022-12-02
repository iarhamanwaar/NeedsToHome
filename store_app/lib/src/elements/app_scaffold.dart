import 'package:flutter/material.dart';
import 'AppDrawer.dart';



class AppScaffold extends StatefulWidget {
  const AppScaffold({@required this.body, Key key}) : super(key: key);

  final Widget body;
  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {



  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final bool displayMobileLayout = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [
        if (!displayMobileLayout)
           AppDrawer(
            permanentlyDisplay: true,
          ),
        Expanded(
          child: Scaffold(
            //backgroundColor: Colors.white,
            appBar: AppBar(
              // when the app isn't displaying the mobile version of app, hide the menu button that is used to open the navigation drawer
              automaticallyImplyLeading: displayMobileLayout,

              backgroundColor: Theme.of(context).primaryColor,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: ListTile(
                  contentPadding: EdgeInsets.only(left: 0, right: 0),
                  leading: Wrap(
                    children: [
                      Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 2),
                            child: Image(image: AssetImage('assets/img/united-states-of-america.png'), height: 20, width: 20),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3, left: 5),
                            child: Text('English', style: Theme.of(context).textTheme.bodyText2),
                          ),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
               ),
            ),
            drawer: displayMobileLayout
                ?  AppDrawer(
                    permanentlyDisplay: false,
                  )
                : null,
            body: Scrollbar(

              isAlwaysShown: true,
              child: ListView(
    scrollDirection: Axis.vertical,
    children: [
                widget.body,
              ]),

            ),

          ),
        ),

      ],
    );
  }
}
