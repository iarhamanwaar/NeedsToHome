import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_web/src/components/card.dart';
import 'package:responsive_ui/responsive_ui.dart';


class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin:EdgeInsets.only(bottom:25),
      padding: EdgeInsets.only(bottom: 20),
      child: Column(

        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: Color(0xFF5e078e),
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            tabs: [
              Tab(
                child: Text('General details'),
              ),
              Tab(
                child: Text('Bank details'),
              ),
              Tab(
                child: Text('Password change'),
              ),
            ],
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
               Container(
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Shop name',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Sub title',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.emailAddress,

                                    decoration: InputDecoration(
                                      labelText: 'Email',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Phone',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Alternative mobile',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Open time',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Close time',
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

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Started year',
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
                          colM:12,
                          colL:12,
                          child:Padding(
                            padding: EdgeInsets.only(top:20,left:20,right:20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Theme.of(context).dividerColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextField(
                                  maxLines: 5,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Description',
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
                        Div(
                          colS: 12,
                          colM:6,
                          colL:6,
                          child:Padding(
                            padding: EdgeInsets.only(top:10,left:20,right:20),
                            child: Container(
                                width: double.infinity,

                                child: TextField(
                                    textAlign: TextAlign.left,
                                    autocorrect: true,
                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      labelText: 'Status',
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


                  ]
                ),
          ),
               ),
                Container(
                    child:SingleChildScrollView(
                      child:Column(
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

                                        child: TextField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,

                                            decoration: InputDecoration(
                                              labelText: 'Bank Name',
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

                                        child: TextField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],

                                            decoration: InputDecoration(
                                              labelText: 'Account Number',
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

                                        child: TextField(
                                            textAlign: TextAlign.left,
                                            autocorrect: true,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Swift Code',
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
                        ]
                      )
                    )
                ),
                Container(
                    child:SingleChildScrollView(
                        child:Column(
                            children:[
                              Wrap(
                                  children:[
                                    Div(
                                      colS: 12,
                                      colM:12,
                                      colL:12,
                                      child:Padding(
                                        padding: EdgeInsets.only(top:10,left:20,right:20),
                                        child: Container(
                                            width: double.infinity,

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: 'Current password',
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

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: 'New password',
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

                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: true,
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                decoration: InputDecoration(
                                                  labelText: 'Confirm password',
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
                            ]
                        )
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
