import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';

class AvailabilityScreen extends StatefulWidget {
  const AvailabilityScreen({Key? key}) : super(key: key);

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  final DateTime _currentDate = DateTime.now();
  List<String> selectedDate = [];
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String dateFrom = "";
  String dateTill = "";
  bool isDateSelected = false;

  String currentMonthVar= "";
   final List<DateTime> _markedDate = [];

 //list to display dates month wise
  List<DateTime> dateList = [];

  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {},
  );

  @override
  void initState() {
    super.initState();
    // setInitialValues();
    _currentMonth = DateFormat.yMd().format(_targetDateTime);
    currentMonthVar = _currentMonth.substring(0,1);
    debugPrint(_currentMonth);
    debugPrint(currentMonthVar);
  }
  // setInitialValues() async{
  //   SharedPreferences prefs = await _prefs;
  //
  //   setState(() {
  //     if(prefs.getStringList('availability') != null){
  //       debugPrint(prefs.getStringList('availability').toString());
  //       // _markedDate = prefs.getStringList('availability')!.cast<DateTime>();
  //       var stringList = prefs.getStringList('availability');
  //       for(var strinf in stringList!){
  //         // dateList.clear();
  //         _markedDate.add(DateTime.parse(strinf));
  //         _markedDateMap.add(DateTime.parse(strinf), Event(date: DateTime.parse(strinf)));
  //         // dateList.add(DateTime.parse(strinf));
  //       }
  //     }
  //     else{
  //       _markedDate = [];
  //     }
  //
  //   });
  //
  //
  //
  // }
  saveDatesInPreferences()async{
    SharedPreferences prefs = await _prefs;
    prefs.setStringList('availability', selectedDate);
    debugPrint("Values in shared preferences");
    debugPrint(prefs.getStringList('availability').toString());
  }
  chooseFromDate(){
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2050, 1, 1), onChanged: (date) {
          // print('change $date');
        }, onConfirm: (date) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          setState(() {
            dateFrom = formatter.format(date);
            debugPrint('Date From $date');
          });

        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
  chooseTillDate(){
    DatePicker.showDatePicker(context,
        showTitleActions: true,

        minTime: DateTime.parse(dateFrom),
        // minTime: DateTime(1950, 1, 1),
        maxTime: DateTime(2050, 1, 1), onChanged: (date) {
          // print('change $date');
        }, onConfirm: (date) {
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          setState(() {
            dateTill = formatter.format(date);

          });
          var startDate =  DateTime.parse(dateFrom);
          var endDate = DateTime.parse(dateTill);
          Get.back();
          //loop to add dates in list
          if(startDate.compareTo(endDate) < 0){
            for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
              setState(() {
                _markedDate.add(startDate.add(Duration(days: i)));
                _markedDateMap.add(startDate.add(Duration(days: i)), Event(date: date));
                dateList.add(startDate.add(Duration(days: i)));
                isDateSelected  = true;
                debugPrint(_markedDate.toString());
              });
            }
          }
          // print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }
  clearDates(){
    _markedDate.clear();
    dateList.clear();
    selectedDate.clear();
    _markedDateMap.clear();
    setState(() {
      dateFrom = "";
      dateTill = "";
      isDateSelected = false;
      debugPrint("Clear Till Date Clicked");
      Get.back();
    });
  }

  @override
  Widget build(BuildContext context) {

    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(

      //Today's border color
      todayBorderColor: Colors.green,

     //On date press
      onDayPressed: (date, events) {

        setState(() {
        //If date is already selected then remove
          if(_markedDate.contains(date)){
           _markedDate.remove(date);
           dateList.remove(date);
           selectedDate.remove(date.toString());
           _markedDateMap.remove(date, Event(date: date));
          }
          // otherwise add date to list
          else{
            _markedDate.add(date);
            dateList.add(date);
            selectedDate.add(date.toString());
            _markedDateMap.add(date, Event(date: date));
            saveDatesInPreferences();
            // selectedDateVar = date.toString().substring(6,7);
            // debugPrint("Selected Date");
            // debugPrint(date.toString().substring(6,7));
            // print(date);
          }
        });
        // events.forEach((event) {
        //   _markedDateMap.add(_selectedDate, event);
        //   print(event.title);
        // });
      },
      //To make days border circular set true otherwise false
      daysHaveCircularBorder: false,
      //To show only current month dates
      showOnlyCurrentMonthDate: false,
      //To show weekend dates
      weekendTextStyle: const TextStyle(
        color: Colors.blue,
      ),
      //month dates border
      thisMonthDayBorderColor: Colors.grey,
      daysTextStyle: TextStyle(
        color: Color(KColors.kColorDarkGrey),
      ),
      //Display calendar in week format
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      markedDateIconBorderColor: Colors.red,
      markedDateCustomShapeBorder: const RoundedRectangleBorder(
          side:BorderSide(color: Colors.red), //the outline color
          ),
      // markedDateCustomShapeBorder: Border.all(color: Colors.red),
      markedDateMoreCustomDecoration:  BoxDecoration(
        border: Border.all(color: Colors.red),
        color: Colors.red
      ),
      showIconBehindDayText: true,

      // markedDateCustomShapeBorder: CircleBorder(side: BorderSide(color: Colors.red)),
      markedDateCustomTextStyle: const TextStyle(
        fontSize: 18,

        color: Colors.white,
      ),
      showHeader: true,
      todayTextStyle: const TextStyle(
        color: Colors.blue,
      ),
      markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      minSelectedDate: _currentDate.subtract(const Duration(days: 360)),
      maxSelectedDate: _currentDate.add(const Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Color(KColors.kColorLightGrey),
      ),
      // inactiveDaysTextStyle: TextStyle(
      //   color: Colors.tealAccent,
      //   fontSize: 16,
      // ),
      onCalendarChanged: (DateTime date) {
        setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMd().format(_targetDateTime);
          currentMonthVar = _currentMonth.substring(0,1);

          dateList.clear();

          for(var marked in _markedDate){

            var dateTest = marked.toString().substring(6,marked.toString().length-16);
            debugPrint(marked.toString().substring(6,marked.toString().length-16));
            if(currentMonthVar == dateTest){
              dateList.add(marked);
              debugPrint(dateList.toString());
            }
          }
        });
      },
      onDayLongPressed: (DateTime date) {
        // print('long pressed date $date');
      },
    );

    return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Strings.availability,style: KFontStyle.newYorkSemiBold22,),
          ),
          toolbarHeight: 80,
          centerTitle: true,
          backgroundColor: Color(KColors.kColorWhite),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                isDateSelected ?
                InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: StatefulBuilder(builder: (context, setState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 3.0), //(x,y)
                                    blurRadius: 5.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(14),
                                // border: Border.all(
                                //   color: Colors.grey,
                                // ),
                              ),
                              height: MediaQuery.of(context).size.height/2,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("You are unavailable : ",style: KFontStyle.newYorkSemiBold22,),
                                  Column(children: [
                                    //From Date Text
                                    Container(
                                      height: 30,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "From : ",
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Text(
                                              dateFrom,
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children:  [
                                                  GestureDetector(
                                                    onTap: (){

                                                      setState(() {
                                                        debugPrint("Clear From Date Clicked");
                                                        dateFrom = "";
                                                      });
                                                    },
                                                      child: Icon(Icons.cancel_outlined,color: Colors.red,)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 05,),
                                    //Till Date Text
                                    Container(
                                      height: 30,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Till : ",
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Text(
                                              dateTill,
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Expanded(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children:  [
                                                  GestureDetector(
                                                    onTap:(){
                                                      clearDates();

                                                    },
                                                      child: Icon(Icons.cancel_outlined,color: Colors.red,)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],),
                                  Column(children: [
                                    Text("I am not available between",style: KFontStyle.kTextStyle18Black,),
                                    const SizedBox(height: 10,),
                                    // From Date Picker
                                    InkWell(
                                      onTap: (){
                                        chooseFromDate();
                                      },
                                      child: Container(
                                        height: 62,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                        decoration: BoxDecoration(
                                          boxShadow:  [
                                            BoxShadow(
                                              color: Color(KColors.kColorLightGrey),
                                              offset: const Offset(0.0, 3.0), //(x,y)
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          color: Color(KColors.kColorWhite),
                                          borderRadius: BorderRadius.circular(50),
                                          // border: Border.all(
                                          //   color: Color(KColors.kColorGrey),
                                          // ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("From",style: KFontStyle.kTextStyle18Black,),
                                              const SizedBox(width: 20,),
                                              const Icon(Icons.calendar_today_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    // Till Date Picker
                                    InkWell(
                                      onTap: (){
                                        if(dateFrom.isEmpty){
                                          Fluttertoast.showToast(
                                              msg: "Please select date from first",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                        else{
                                          chooseTillDate();
                                        }

                                      },
                                      child: Container(
                                        height: 62,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                        decoration: BoxDecoration(
                                          boxShadow:  [
                                            BoxShadow(
                                              color: Color(KColors.kColorLightGrey),
                                              offset: const Offset(0.0, 3.0), //(x,y)
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          color: Color(KColors.kColorWhite),
                                          borderRadius: BorderRadius.circular(50),
                                          // border: Border.all(
                                          //   color: Color(KColors.kColorGrey),
                                          // ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Till",style: KFontStyle.kTextStyle18Black,),
                                              const SizedBox(width: 20,),
                                              const Icon(Icons.calendar_today_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],),

                                ],),
                            );
                          }),
                        );
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 62,
                        width: MediaQuery.of(context).size.width/1.5,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                              color: Color(KColors.kColorLightGrey),
                              offset: const Offset(0.0, 3.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Color(KColors.kColorWhite),
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(
                          //   color: Color(KColors.kColorGrey),
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dateFrom,style: KFontStyle.kTextStyle18Black,),
                              const SizedBox(width: 20,),
                              const Icon(Icons.calendar_today_rounded),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 62,
                        width: MediaQuery.of(context).size.width/1.5,
                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        decoration: BoxDecoration(
                          boxShadow:  [
                            BoxShadow(
                              color: Color(KColors.kColorLightGrey),
                              offset: const Offset(0.0, 3.0), //(x,y)
                              blurRadius: 5.0,
                            ),
                          ],
                          color: Color(KColors.kColorWhite),
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(
                          //   color: Color(KColors.kColorGrey),
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(dateTill,style: KFontStyle.kTextStyle18Black,),
                              const SizedBox(width: 20,),
                              const Icon(Icons.calendar_today_rounded),
                            ],
                          ),
                        ),
                      ),
                  ],),
                ):
                ///Manage Unavailable days
                InkWell(
                  onTap: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          content: StatefulBuilder(builder: (context, setState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 3.0), //(x,y)
                                    blurRadius: 5.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(14),
                                // border: Border.all(
                                //   color: Colors.grey,
                                // ),
                              ),
                              height: MediaQuery.of(context).size.height/2,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("You are unavailable : ",style: KFontStyle.newYorkSemiBold22,),
                                  Column(children: [
                                    //From Date Text
                                    Container(
                                      height: 30,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "From : ",
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Text(
                                              dateFrom,
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 05,),
                                    //Till Date Text
                                    Container(
                                      height: 30,
                                      color: Colors.grey[200],
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Till : ",
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                            Text(
                                              dateTill,
                                              style: KFontStyle.kTextStyle16BlackRegular,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],),
                                  Column(children: [
                                    Text("I am not available between",style: KFontStyle.kTextStyle18Black,),
                                    const SizedBox(height: 10,),
                                    // From Date Picker
                                    InkWell(
                                      onTap: (){
                                        chooseFromDate();
                                      },
                                      child: Container(
                                        height: 62,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                        decoration: BoxDecoration(
                                          boxShadow:  [
                                            BoxShadow(
                                              color: Color(KColors.kColorLightGrey),
                                              offset: const Offset(0.0, 3.0), //(x,y)
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          color: Color(KColors.kColorWhite),
                                          borderRadius: BorderRadius.circular(50),
                                          // border: Border.all(
                                          //   color: Color(KColors.kColorGrey),
                                          // ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("From",style: KFontStyle.kTextStyle18Black,),
                                              const SizedBox(width: 20,),
                                              const Icon(Icons.calendar_today_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    // Till Date Picker
                                    InkWell(
                                      onTap: (){
                                        if(dateFrom.isEmpty){
                                          Fluttertoast.showToast(
                                              msg: "Please select date from first",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.TOP,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                        else{
                                          chooseTillDate();

                                        }
                                      },
                                      child: Container(
                                        height: 62,
                                        width: MediaQuery.of(context).size.width/1.5,
                                        margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                        decoration: BoxDecoration(
                                          boxShadow:  [
                                            BoxShadow(
                                              color: Color(KColors.kColorLightGrey),
                                              offset: const Offset(0.0, 3.0), //(x,y)
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          color: Color(KColors.kColorWhite),
                                          borderRadius: BorderRadius.circular(50),
                                          // border: Border.all(
                                          //   color: Color(KColors.kColorGrey),
                                          // ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Till",style: KFontStyle.kTextStyle18Black,),
                                              const SizedBox(width: 20,),
                                              const Icon(Icons.calendar_today_rounded),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],),

                                ],),
                            );
                          }),
                        );
                      },
                    );

                  },
                  child: Container(
                    height: 62,
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    decoration: BoxDecoration(
                      boxShadow:  [
                        BoxShadow(
                          color: Color(KColors.kColorLightGrey),
                          offset: const Offset(0.0, 3.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                      color: Color(KColors.kColorWhite),
                      borderRadius: BorderRadius.circular(50),
                      // border: Border.all(
                      //   color: Color(KColors.kColorGrey),
                      // ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Manage Unavailable days",style: KFontStyle.kTextStyle18Black,),
                          const Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _calendarCarouselNoHeader,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("You are unavailable on the following dates : ",style: KFontStyle.kTextStyle16BlackRegular,),
                ),
                const SizedBox(height: 10,),
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    for(var marked in dateList)
                      Text(marked.toString().substring(8,marked.toString().length-12),style: KFontStyle.newYorkSemiBold22,maxLines: 5,overflow: TextOverflow.ellipsis,),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}