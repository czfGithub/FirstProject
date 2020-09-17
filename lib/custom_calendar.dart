import 'package:flutter/material.dart';
import 'package:flutterapp/widget/calendar.dart';

class CustomerCalendar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomerCalendar();
  }
}

class _CustomerCalendar extends State<CustomerCalendar>{

  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('自定义日历')),
      body: Calendar(initTime: _date,onChange: (value){ //firstTime: _date.subtract(Duration(days: 30),),endTime: _date.add(Duration(days: 30)),
        print(value);
      },),
    );
  }
}