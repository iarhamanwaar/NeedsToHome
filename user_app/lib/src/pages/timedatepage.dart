import 'dart:async';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multisuperstore/generated/l10n.dart';
import 'package:intl/intl.dart';
import 'package:multisuperstore/src/controllers/hservice_controller.dart';
import 'package:multisuperstore/src/elements/PermissionDeniedWidget.dart';
import 'package:multisuperstore/src/models/address.dart';
import 'package:multisuperstore/src/repository/hservice_repository.dart';
import 'package:multisuperstore/src/repository/user_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../elements/AddressBoxLoaderWidget.dart';
import '../repository/settings_repository.dart';

final stateBloc = StateBloc();
class TimeDatePage extends StatefulWidget {
  @override
  _TimeDatePageState createState() => _TimeDatePageState();
}

class _TimeDatePageState extends StateMVC<TimeDatePage> {
  HServiceController _con;

  _TimeDatePageState({this.dish}) : super(HServiceController()) {
    _con = controller;
  }
  final Map<String, dynamic> dish;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _con.timescaffoldKey,
      backgroundColor: Colors.black,
      body: currentUser.value.apiToken == null
          ? PermissionDeniedWidget()
          : Stack(
        children: <Widget>[
          CarCarousel(),
          CustomBottomSheet(context: context, dish: dish),
          Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                    _con.gotoMap();
                    },
                    child: Center(
                        child: Text(
                          S.of(context).choose_provider,
                          style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                        )),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}





class CarCarousel extends StatefulWidget {
  final Map<String, dynamic> dish;

  CarCarousel({this.dish});

  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // ignore: missing_required_param
          Image(
            image: NetworkImage(
                currentBookDetail.value.subcategoryImg),
            height:300,width:double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 27.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Theme.of(context).colorScheme.primary,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 30.0),
                    Text(S.of(context).time_and_date,
                      style: Theme.of(context).textTheme.headline3.merge(TextStyle(shadows: [
                        Shadow(
                          blurRadius: 50,
                          color: Color(0xFF000000),
                          offset: Offset(0, 0),
                        ),
                      ],
                          color:Theme.of(context).colorScheme.primary.withOpacity(0.8))),
                        ),
                  ],
                ),
              ),



              /*dark heading part */
              Container(
                  height: 240,
                  width:double.infinity,

                  child:Container(
                      alignment: Alignment.topCenter,
                      height:100,
                      /* background black light to dark gradient color */
                      decoration: BoxDecoration(
                        gradient: new LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(0.0, 0.6),
                          colors: <Color>[
                            const Color(0x8A000000).withOpacity(0.0),
                            const Color(0x8A000000).withOpacity(0.55),
                            const Color(0x8A000000).withOpacity(0.7),
                            const Color(0x8A000000).withOpacity(0.8),

                            const Color(0x8A000000).withOpacity(0.9),
                          ],
                        ),
                      ),

                    child:Padding(
                      padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 80.0,
                          bottom: 0.0),
                  child: Column(
                    children: [


                      Text(currentBookDetail.value.categoryName,
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .merge(TextStyle(color:Theme.of(context).colorScheme.primary)
                          )),
                      Text(currentBookDetail.value.subcategoryName,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .merge(TextStyle(color:Theme.of(context).colorScheme.primary)
                          )),

                    ],
                  ),
                          ),
                          ),
              ),
              /* end dark heading part */


            ]),
          ),
        ],
      ),
    );
  }
}

///////////////////
// ignore: must_be_immutable
class CustomBottomSheet extends StatefulWidget {
  BuildContext context;
  final Map<String, dynamic> dish;

  CustomBottomSheet({this.context, this.dish});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop;

  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    double sheetTop = MediaQuery.of(widget.context).size.height * 0.33;
    double minSheetTop = 30;
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
    DateTime date = DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    currentBookDetail.value.date = formattedDate;
    currentBookDetail.value.time = 'All STANDARD TIME';
  }

  forwardAnimation() {
    controller.forward();
    stateBloc.toggleAnimation();
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation();
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {
          controller.isCompleted ? reverseAnimation() : forwardAnimation();
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          //upward drag
          if (dragEndDetails.primaryVelocity < 0.0) {
            forwardAnimation();
            controller.forward();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(dish: widget.dish),
      ),
    );
  }
}
class SheetContainer extends StatefulWidget {
  final Map<String, dynamic> dish;

  SheetContainer({this.dish});
  @override
  _SheetContainerState createState() => _SheetContainerState();
}

class _SheetContainerState extends StateMVC<SheetContainer> {


  HServiceController _con;

  _SheetContainerState() : super(HServiceController()) {
    _con = controller;
  }


  DatePickerController _controller = DatePickerController();

  int checkedItem = 0;

  ScrollController scrollController = ScrollController(initialScrollOffset: 0);

  bool isFav = false;
  bool isReadless = false;
  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 25),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: Theme.of(context).primaryColor,),
      child: Column(
        children: <Widget>[
          drawerHandle(),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[


                          Container(
                            padding:
                            EdgeInsets.only(left:size.width > 769 ? size.width * 0.07 : size.width * 0.05, right: size.width > 769 ? size.width * 0.07 : size.width * 0.05,),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(

                                  child: Text(S.of(context).date_and_time,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(


                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: DatePicker(
                                                DateTime.now(),
                                                width: 60,
                                                height: 100,
                                                controller: _controller,
                                                initialSelectedDate: DateTime.now(),
                                                selectionColor: Theme.of(context).backgroundColor,
                                                selectedTextColor:Theme.of(context).colorScheme.primary,
                                                onDateChange: (date) {
                                                  // New date selected
                                                  setState(() {

                                                    // _con.addTodate(date.toString());
                                                    var formatter = new DateFormat('yyyy-MM-dd');
                                                    String formattedDate = formatter.format(date);
                                                    currentBookDetail.value.date = formattedDate;
                                                    print(formattedDate);
                                                  });
                                                },
                                              ),
                                            ),
                                          ])),
                    SizedBox(height:size.width > 769 ? 20 :0  ),

                             Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    height: 50,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: timeclock.length,
                                        itemBuilder: (context, index) {
                                          Datetime _datetime = timeclock.elementAt(index);

                                          var now = new DateTime.now();
                                          var formatter = new DateFormat('yyyy-MM-dd');
                                          String currentDate = formatter.format(now);

                                          if (now.hour >= _datetime.timeid && _datetime.timeid != 1 && currentBookDetail.value.date == currentDate) {
                                            return Container();
                                          } else {
                                            return Row(
                                              children: <Widget>[
                                                GestureDetector(
                                                    onTap: () => {
                                                      timeclock.forEach((_l) {
                                                        setState(() {
                                                          _l.selected = false;
                                                        });
                                                      }),
                                                      _datetime.selected = true,
                                                      currentBookDetail.value.time = _datetime.time,
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.50,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: _datetime.selected ? Colors.blueAccent : Theme.of(context).dividerColor,
                                                      ),
                                                      child: Center(
                                                          child: Text(_datetime.time,
                                                              style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  color: _datetime.selected ? Theme.of(context).colorScheme.primary :  Theme.of(context).backgroundColor,
                                                                  fontWeight: FontWeight.w700))),
                                                    )),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.06,
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ),

                                SizedBox(height:10.0),
                    Container(

                      child: Text(S.of(context).address,

                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                                SizedBox(height:10.0),
                                SizedBox(height: 10.0),
                                currentUser.value.address.isEmpty
                                    ? Container(
                                  width: MediaQuery.of(context).size.width * 0.40,
                                  height: 150,
                                  // ignore: deprecated_member_use
                                  child: FlatButton(
                                    onPressed: () async {



                                       await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PlacePicker(
                                              apiKey: setting.value.googleMapsKey,
                                              initialPosition: LatLng(currentUser.value.latitude, currentUser.value.longitude),
                                              useCurrentLocation: false,

                                              selectInitialPosition: true,
                                              usePlaceDetailSearch: true,
                                              forceSearchOnZoomChanged: true,

                                              selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                                if (isSearchBarFocused) {
                                                  return SizedBox();
                                                }
                                                return FloatingCard(
                                                    height: 220,
                                                    elevation: 0,
                                                    width: double.infinity,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                    bottomPosition: 0.0,
                                                    leftPosition: 0.0,
                                                    rightPosition: 0.0,
                                                    color: Theme.of(context).primaryColor,
                                                    child: state == SearchingState.Searching
                                                        ? AddressBoxLoaderWidget()
                                                        : Container(
                                                      padding: EdgeInsets.only(left:15,right:15,top:15),
                                                      child:Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text('SELECT DELIVERY LOCATION',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
                                                          SizedBox(height:20),
                                                          Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children:[
                                                                Align(
                                                                    alignment:Alignment.topLeft,
                                                                    child:Icon(Icons.location_on_outlined,size:30)
                                                                ),
                                                                Expanded(
                                                                    child:Container(
                                                                        padding: EdgeInsets.only(left:10),
                                                                        child:Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children:[
                                                                              Text('Address',style:Theme.of(context).textTheme.headline3),
                                                                              SizedBox(height: 10,),
                                                                              Text(selectedPlace?.formattedAddress,overflow: TextOverflow.ellipsis,maxLines: 2,
                                                                                  style:Theme.of(context).textTheme.bodyText2),
                                                                            ]
                                                                        )

                                                                    )
                                                                )
                                                              ]
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets.only(bottom:15,top:35),
                                                            width: double.infinity,
                                                            height: 50.0,
                                                            decoration: BoxDecoration(
                                                              color: Theme.of(context).colorScheme.secondary,
                                                              borderRadius: BorderRadius.circular(7),),

                                                            child: MaterialButton(
                                                              onPressed: () {
                                                                _con.addressData.latitude =  selectedPlace.geometry.location.lat;
                                                                _con.addressData.longitude = selectedPlace.geometry.location.lng;
                                                                _con.addressData.addressSelect = selectedPlace?.formattedAddress;
                                                                _con.addressData.isDefault = 'false';
                                                                currentUser.value.latitude = selectedPlace.geometry.location.lat;
                                                                currentUser.value.longitude = selectedPlace.geometry.location.lng;
                                                                currentUser.value.address.add( _con.addressData);
                                                                Navigator.pop(context,selectedPlace?.formattedAddress);

                                                              },
                                                              child: Center(
                                                                  child: Text(
                                                                      S.of(context).save_and_proceed,
                                                                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                  )),
                                                            ),
                                                          ),


                                                        ],
                                                      ),
                                                    )
                                                );
                                              },
                                            )
                                        ),
                                      );
                                      setState(() {
                                        currentUser.value;
                                      });
                                      setCurrentUserUpdate(currentUser.value);
                                    },
                                    child: Icon(Icons.add_circle, size: 40, color: Colors.pink),
                                  ),
                                )
                                    : Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    height: 165,
                                    child: ListView.builder(
                                        itemCount: currentUser.value.address.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, int index) {
                                          Address _address = currentUser.value.address.elementAt(index);
                                          return Row(
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () => {
                                                  currentUser.value.address.forEach((_l) {
                                                    setState(() {
                                                      _l.isDefault = 'false';
                                                    });
                                                  }),
                                                  _address.isDefault = 'true',
                                                  currentBookDetail.value.address = _address.addressSelect,
                                                  currentBookDetail.value.latitude = _address.latitude,
                                                  currentBookDetail.value.longitude = _address.longitude,
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(6),
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                        width: 1,
                                                      )),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      _address.isDefault == 'true'
                                                          ? Icon(
                                                        Icons.check_circle,
                                                        color: Theme.of(context).colorScheme.secondary,
                                                        size: 24,
                                                      )
                                                          : SizedBox(
                                                        height: 25,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                          Text(currentUser.value.name, style: Theme.of(context).textTheme.subtitle1),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                          Text(
                                                            _address.addressSelect,
                                                            style: Theme.of(context).textTheme.caption,
                                                          ),
                                                        ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width * 0.06,
                                              ),
                                              if (index + 1 == currentUser.value.address.length) ...[
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.40,
                                                  // ignore: deprecated_member_use
                                                  child: FlatButton(
                                                    onPressed: () async {



                                                      await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => PlacePicker(
                                                              apiKey: setting.value.googleMapsKey,
                                                              initialPosition: LatLng(currentUser.value.latitude, currentUser.value.longitude),
                                                              useCurrentLocation: false,

                                                              selectInitialPosition: true,
                                                              usePlaceDetailSearch: true,
                                                              forceSearchOnZoomChanged: true,

                                                              selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                                                if (isSearchBarFocused) {
                                                                  return SizedBox();
                                                                }
                                                                return FloatingCard(
                                                                    height: 220,
                                                                    elevation: 0,
                                                                    width: double.infinity,
                                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                    bottomPosition: 0.0,
                                                                    leftPosition: 0.0,
                                                                    rightPosition: 0.0,
                                                                    color: Theme.of(context).primaryColor,
                                                                    child: state == SearchingState.Searching
                                                                        ? AddressBoxLoaderWidget()
                                                                        : Container(
                                                                      padding: EdgeInsets.only(left:15,right:15,top:15),
                                                                      child:Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text('SELECT DELIVERY LOCATION',style:Theme.of(context).textTheme.subtitle2.merge(TextStyle(color:Theme.of(context).hintColor))),
                                                                          SizedBox(height:20),
                                                                          Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children:[
                                                                                Align(
                                                                                    alignment:Alignment.topLeft,
                                                                                    child:Icon(Icons.location_on_outlined,size:30)
                                                                                ),
                                                                                Expanded(
                                                                                    child:Container(
                                                                                        padding: EdgeInsets.only(left:10),
                                                                                        child:Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children:[
                                                                                              Text('Address',style:Theme.of(context).textTheme.headline3),
                                                                                              SizedBox(height: 10,),
                                                                                              Text(selectedPlace?.formattedAddress,overflow: TextOverflow.ellipsis,maxLines: 2,
                                                                                                  style:Theme.of(context).textTheme.bodyText2),
                                                                                            ]
                                                                                        )

                                                                                    )
                                                                                )
                                                                              ]
                                                                          ),
                                                                          Container(
                                                                            margin: EdgeInsets.only(bottom:15,top:35),
                                                                            width: double.infinity,
                                                                            height: 50.0,
                                                                            decoration: BoxDecoration(
                                                                              color: Theme.of(context).colorScheme.secondary,
                                                                              borderRadius: BorderRadius.circular(7),),

                                                                            child: MaterialButton(
                                                                              onPressed: () {
                                                                                _con.addressData.latitude =  selectedPlace.geometry.location.lat;
                                                                                _con.addressData.longitude = selectedPlace.geometry.location.lng;
                                                                                _con.addressData.addressSelect = selectedPlace?.formattedAddress;
                                                                                _con.addressData.isDefault = 'false';
                                                                                currentUser.value.latitude = selectedPlace.geometry.location.lat;
                                                                                currentUser.value.longitude = selectedPlace.geometry.location.lng;
                                                                                currentUser.value.address.add( _con.addressData);
                                                                                Navigator.pop(context,selectedPlace?.formattedAddress);

                                                                              },
                                                                              child: Center(
                                                                                  child: Text(
                                                                                      S.of(context).save_and_proceed,
                                                                                      style: Theme.of(context).textTheme.subtitle1.merge(TextStyle(color:Theme.of(context).primaryColorLight))
                                                                                  )),
                                                                            ),
                                                                          ),


                                                                        ],
                                                                      ),
                                                                    )
                                                                );
                                                              },
                                                            )
                                                        ),
                                                      );
                                                      setState(() {
                                                        currentUser.value;
                                                      });
                                                      setCurrentUserUpdate(currentUser.value);
                                                    },
                                                    child: Icon(Icons.add_circle, size: 40, color: Colors.pink),
                                                  ),
                                                ),
                                              ]
                                            ],
                                          );
                                        }),
                                  ),

                                SizedBox(height:10.0),
                                Container(

                                  child: Text(S.of(context).description,

                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                SizedBox(height:10.0),

                    Container(
                      width: size.width > 769 ? size.width * 0.5 :double.infinity,
                      padding:
                      EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Theme.of(context).dividerColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            onSaved: (input) => currentBookDetail.value.description = input,
                            maxLines: 8,
                            decoration:
                            InputDecoration.collapsed(hintText: S.of(context).description,
                            ),
                          ),
                        ),
                      ),
              ),
                    ),

                                SizedBox(height:100.0),



                              ],
                            ),
                          )






                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }


  drawerHandle() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      height: 3,
      width: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Color(0xffd9dbdb)),
    );
  }
}

class StateBloc {
  StreamController animationController = StreamController.broadcast();
  final StateProvider provider = StateProvider();

  Stream get animationStatus => animationController.stream;

  void toggleAnimation() {
    provider.toggleAnimationValue();
    animationController.sink.add(provider.isAnimating);
  }

  void dispose() {
    animationController.close();
  }
}

class StateProvider {
  bool isAnimating = true;

  void toggleAnimationValue() => isAnimating = !isAnimating;
}
class Datetime {
  Datetime({this.timeid, this.time, this.selected});
  int timeid;
  String time;
  bool selected;
}

List<Datetime> timeclock = <Datetime>[
  Datetime(timeid: 1, time: 'All STANDARD TIME', selected: false),
  Datetime(timeid: 2, time: 'STD TIME 0.00 AM TO 2.00AM', selected: false),
  Datetime(timeid: 4, time: 'STD TIME 2.00 AM TO 4.00AM', selected: false),
  Datetime(timeid: 6, time: 'STD TIME 4.00 AM TO 6.00AM', selected: false),
  Datetime(timeid: 8, time: 'STD TIME 6.00 AM TO 8.00AM', selected: false),
  Datetime(timeid: 10, time: 'STD TIME 8.00 AM TO 10.00AM', selected: false),
  Datetime(timeid: 12, time: 'STD TIME 10.00 AM TO 12.00PM', selected: false),
  Datetime(timeid: 14, time: 'STD TIME 12.00 PM TO 2.00PM', selected: false),
  Datetime(timeid: 16, time: 'STD TIME 2.00 PM TO 4.00PM', selected: false),
  Datetime(timeid: 18, time: 'STD TIME 4.00 PM TO 6.00PM', selected: false),
  Datetime(timeid: 20, time: 'STD TIME 6.00 PM TO 8.00PM', selected: false),
  Datetime(timeid: 22, time: 'STD TIME 8.00 PM TO 10.00PM', selected: false),
  Datetime(timeid: 24, time: 'STD TIME 10.00 PM TO 12.00PM', selected: false),
];
