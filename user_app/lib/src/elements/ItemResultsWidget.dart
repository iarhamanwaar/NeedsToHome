import 'package:flutter/material.dart';
import 'package:multisuperstore/src/controllers/home_controller.dart';
import 'package:multisuperstore/src/elements/EmptyOrdersWidget.dart';
import 'package:multisuperstore/src/pages/search_item.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import '../../generated/l10n.dart';
import '../repository/user_repository.dart';
import 'SearchShopListWidget.dart';
import 'custom_clipper.dart';

class ItemResultWidget extends StatefulWidget {

  final searchKey;
  final superCategory;
  ItemResultWidget({Key key,this.searchKey, this.superCategory} ) : super(key: key);

  @override
  _ItemResultWidgetState createState() => _ItemResultWidgetState();
}

class _ItemResultWidgetState extends StateMVC<ItemResultWidget> with SingleTickerProviderStateMixin {

  HomeController _con;
  _ItemResultWidgetState() : super(HomeController()) {
    _con = controller;
  }
  TextEditingController searchTextController;
  stt.SpeechToText _speech;
  bool _isListening = false;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    searchTextController = TextEditingController();
    _speech = stt.SpeechToText();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    _con.listenForVendorItemSearch(widget.searchKey,'banner', widget.superCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DefaultTabController(
          length: 2,
          child:SafeArea(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: <Widget>[
                  Row(
                      children:[
                      InkWell(
                            onTap:(){
                              Navigator.pop(context);
                            },
                            child:Icon(Icons.arrow_back)
                        ),

                      ]
                  ),

                  _con.searchState=='finding'?EmptyOrdersWidget():_con.searchState=='find'?

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.green,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: <Widget>[
                        Text(S.of(context).item),
                        Text(S.of(context).shop),

                      ],
                    ),
                  ):Container(),
                  _con.searchState=='find'?Expanded(
                    child: TabBarView(
                      controller: _tabController,

                      children: <Widget>[

                        Container(
                          child:  SearchItem(itemDetails: _con.searchResultData.item,),
                        ),
                        Container(
                          child: SearchShopListWidget(vendor: _con.searchResultData.vendor,),
                        ),


                      ],
                    ),
                  ):Container()


                  /*Expanded(
                child: ListView(
                  children: <Widget>[
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.auto_suggestion.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        AutoSuggestion _suggestion = _con.auto_suggestion.elementAt(index);
                        return Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  print(1);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor,
                                  ))),
                                  child: ListTile(
                                    leading: const Icon(Icons.search),
                                    title: Text(
                                      _suggestion.text,
                                      style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(fontWeight: FontWeight.w600)),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.call_made,
                                        textDirection: TextDirection.rtl,
                                      ),
                                      color: Theme.of(context).hintColor,
                                      onPressed: () {
                                        _con.saveSearch(_suggestion.text);
                                      },
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                  ],
                ),
              ),*/
                ],
              ),
            ),
          )),
    );
  }

  // ignore: non_constant_identifier_names
  void ShowClipper() {
    String _text = S.of(context).press_the_button_and_start_speaking;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.37,
              color: Color(0xff737373),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    color: Theme.of(context).primaryColorLight,
                  ),
                  Expanded(
                    child: ClipPath(
                      clipper: CustomShape(), // this is my own class which extendsCustomClipper
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                ),

                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      _text,
                                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(fontWeight: FontWeight.w400)),
                                      textAlign: TextAlign.center,
                                    )
                                  ]),

                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 5),
                                child: AvatarGlow(
                                  animate: _isListening,
                                  glowColor: Colors.green,
                                  endRadius: 75.0,
                                  duration: const Duration(milliseconds: 2000),
                                  repeatPauseDuration: const Duration(milliseconds: 100),
                                  repeat: true,
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      if (!_isListening) {
                                        bool available = await _speech.initialize(
                                          onStatus: (val) {

                                          },
                                          onError: (val) => print('onError: $val'),
                                        );
                                        if (available) {
                                          setState(() => _isListening = true);
                                          _speech.listen(
                                            onResult: (val) => setState(() {
                                              _text = val.recognizedWords;

                                              if (val.hasConfidenceRating && val.confidence > 0) {

                                                _speech.stop();
                                                _con.listenForVendorItemSearch( _text,'search',currentUser.value.filterId);
                                                searchTextController.text = _text;


                                                Navigator.pop(context);
                                              }
                                            }),
                                          );
                                        }
                                      } else {
                                        setState(() => _isListening = false);
                                        _speech.stop();
                                      }
                                    },
                                    child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}