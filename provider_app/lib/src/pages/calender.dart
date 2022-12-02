import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handy/generated/l10n.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

class Calendar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new CalenderMain(title: ''),
    );
  }
}

class CalenderMain extends StatefulWidget {
  CalenderMain({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CalenderMainState createState() => new _CalenderMainState();
}

class _CalenderMainState extends State<CalenderMain> {
  DateTime now = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.white,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    ///
    super.initState();
    getAppointment();

    this.cal();
  }

  getAppointment() async {
    final QuerySnapshot qSnap =
        await FirebaseFirestore.instance.collection('data').get();

    qSnap.docs.forEach((element) {
      var date =
          DateTime.fromMillisecondsSinceEpoch(element.data());//['bookingtime']);
      int year = int.parse(DateFormat.y().format(date));
      int month = int.parse(DateFormat.M().format(date));
      int day = int.parse(DateFormat.d().format(date));
      setState(() {
        _markedDateMap.add(
            new DateTime(year, month, day),
            new Event(
              date: new DateTime(2020, 12, 6),
              title: 'Event 5',
              icon: _eventIcon,
            ));
      });
    });
  }

  cal() {}

  @override
  Widget build(BuildContext context) {
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.red,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),

      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,

      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,

      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),

      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return new Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.green),
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(S.current.my_appointment,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.green,
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 30.0,
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0,
                              ),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _targetDateTime = DateTime(
                                            _targetDateTime.year,
                                            _targetDateTime.month - 1);
                                        _currentMonth = DateFormat.yMMM()
                                            .format(_targetDateTime);
                                      });
                                    },
                                  ),
                                  Text(
                                    _currentMonth,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .merge(TextStyle(color: Colors.white)),
                                  ),
                                  // ignore: deprecated_member_use
                                  FlatButton(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _targetDateTime = DateTime(
                                            _targetDateTime.year,
                                            _targetDateTime.month + 1);
                                        _currentMonth = DateFormat.yMMM()
                                            .format(_targetDateTime);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16),
                            child: _calendarCarouselNoHeader,
                          ), //
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
