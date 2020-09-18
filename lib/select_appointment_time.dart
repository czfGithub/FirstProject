import 'package:flutter/material.dart';
import 'package:flutterapp/utils/time_util.dart';
import 'package:flutterapp/widget/day_gridview.dart';

class SelectAppointmentTime extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SelectAppointmentTime();
  }
}

class _SelectAppointmentTime extends State<SelectAppointmentTime>{

  var _initDate = DateTime.now();
  var _selectDate;
  var _monthYear;
  List<String> _headList = ['S','M','T','W','T','F','S'];

  getPreOrNextMonth(int month){
    setState(() {
      int year = _initDate.year;
      if(month < 1){
        month = 12;
        year = year - 1;
      }else if(month > 12){
        month = 1;
        year = year + 1;
      }
      _initDate = DateTime(year,month,1);
      _selectDate = _initDate;
      _monthYear = TimeUtil.getMonthName(_initDate) + "  ${_initDate.year}";
    });
  }

  onChange(time) {
    if (_selectDate != time) {
      setState(() {
        print(_selectDate);
        _selectDate = time;
        _showModalBottomSheet();
      });
    }
  }

  // 弹出底部菜单列表模态对话框
  Future<String> _showModalBottomSheet() {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 480,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(15),
                      child: Image.asset('images/ic_cancel.png',width: 15,height: 15,),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text('FILL IN PERSONAL INFORMATION',style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16),),
                      )
                  ),
                  Container(
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              Expanded(
                child: AnimatedPadding(
                  padding: MediaQuery.of(context).viewInsets,
                  duration: Duration(milliseconds: 100),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 20,bottom: 20,left: 40,right: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name',style: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),),
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(226, 229, 237, 1),width: 1)
                            ),
                            child: TextField(
                              style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 14),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Please fill in your personal name',
                                  hintStyle: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Text('ID',style: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),),
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(226, 229, 237, 1),width: 1)
                            ),
                            child: TextField(
                              style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 14),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Please fill in your personal ID card',
                                  hintStyle: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Text('Phone',style: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),),
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(226, 229, 237, 1),width: 1)
                            ),
                            child: TextField(
                              style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 14),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Please fill in your personal phone',
                                  hintStyle: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Text('Email',style: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),),
                          Container(
                            margin: EdgeInsets.only(top: 10,bottom: 30),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(226, 229, 237, 1),width: 1)
                            ),
                            child: TextField(
                              style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 14),
                              decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: 'Please fill in your personal email',
                                  hintStyle: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 14),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(72, 201, 151, 1),
                                borderRadius: BorderRadius.circular(25)
                            ),
                            child: Text('SUBMIT APPOINTMENT',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectDate = _initDate;
    _monthYear = TimeUtil.getMonthName(_initDate) + "  ${_initDate.year}";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('SELECT APPOINTMNET TIME',style: TextStyle(color: Colors.white,fontSize: 16),),),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  getPreOrNextMonth(_initDate.month - 1);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('images/ic_last_time.png',width: 18,height: 18,),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(_monthYear,style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16),),
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  getPreOrNextMonth(_initDate.month + 1);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Image.asset('images/ic_next_time.png',width: 18,height: 18,),
                ),
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: _headList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1
            ),
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text(_headList[index],style: TextStyle(color: Color.fromRGBO(102, 102, 102, 1),fontSize: 14),),
              );
            },
          ),
          DayGridView(
            initDate: DateTime(_initDate.year, _initDate.month, _initDate.day),
            selectDate: DateTime(_selectDate.year, _selectDate.month, _selectDate.day),
//              year: widget.firstTime.year +
//                  ((widget.firstTime.month + index - 1) / 12).floor(),
//              month: (widget.firstTime.month + index) % 12 == 0
//                  ? 12
//                  : (widget.firstTime.month + index) % 12,
            year: _selectDate.year,
            month: _selectDate.month,
            onChange: onChange,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(72, 201, 151, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Text('Appointment Available',style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20,left: 25,right: 25),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(72, 201, 151, 1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color.fromRGBO(72, 201, 151, 1),width: 1),
                    ),
                    child: Text('9:30Am',style: TextStyle(color: Colors.white,fontSize: 16),),
                  ),
                ),
                Container(
                  width: 50,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Color.fromRGBO(201, 201, 201, 1),width: 1),
                    ),
                    child: Text('12:30Pm',style: TextStyle(color: Color.fromRGBO(201, 201, 201, 1),fontSize: 16),),
                  ),
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}