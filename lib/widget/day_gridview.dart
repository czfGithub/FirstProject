import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/utils/time_util.dart';

class DayGridView extends StatefulWidget {
  DateTime initDate;
  DateTime selectDate;
  int year;
  int month;
  ValueChanged onChange;

  DayGridView({
    Key key,
    @required this.initDate,
    @required this.selectDate,
    @required this.year,
    @required this.month,
    this.onChange,
  });

  @override
  State<DayGridView> createState() => _DayGridViewState();
}

class _DayGridViewState extends State<DayGridView> {

  var endTime;

  @override
  void initState() {
    super.initState();
    print('initState');
    endTime = widget.initDate.add(Duration(days: 7));
  }

  @override
  void didUpdateWidget(DayGridView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    endTime = widget.initDate.add(Duration(days: 7));
  }

  List<Widget> dayItems() {
    List days = TimeUtil.getDay(
        widget.year, widget.month, MaterialLocalizations.of(context));
    List dayWidgets = days.map((value) {
      if (value is int) {
        return Container();
      }
      if (value == widget.selectDate) {
        return GestureDetector(
          onTap: () {
            widget.onChange(widget.selectDate);
          },
          child: Container(
            color: Colors.white,
            alignment: Alignment.center,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(72, 201, 151, 1),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    value.day.toString(),
                    style: TextStyle(color: Colors.white,fontSize: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        if (value == widget.initDate) {
          return GestureDetector(
            onTap: () {
              widget.onChange(widget.initDate);
            },
            child: Container(
                width: 40,
                height: 40,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      value.day.toString(),
                      style: TextStyle(color: Color.fromRGBO(72, 201, 151, 1),fontSize: 16),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(72, 201, 151, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                )),
          );
        } else {
          if (value.isBefore(widget.initDate) || value.isAfter(endTime)) {
            /// 在今天之前的时间无法点击
            return GestureDetector(
              child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        value.day.toString(),
                        style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 5,
                        height: 5,
                      ),
                    ],
                  )
              ),
            );
          } else {
            /// 在今天之后的时间可以点击
            return GestureDetector(
              onTap: () {
                widget.onChange(value);
              },
              child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          value.day.toString(),
                          style: TextStyle(color: Color.fromRGBO(51, 51, 51, 1),fontSize: 16),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(72, 201, 151, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    )
                  )
              ),
            );
          }
        }
      }
    }).toList();
    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = dayItems();
    return Container(
      height: 270,
      child: GridView.custom(
          gridDelegate:
          _DayPickerGridDelegate(mainAxisNumber: list.length > 35 ? 6 : 5),
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(0),
          childrenDelegate:
          SliverChildListDelegate(list, addRepaintBoundaries: false)),
    );
  }
}

/// 自定义GridView
class _DayPickerGridDelegate extends SliverGridDelegate {
  final int mainAxisNumber;

  const _DayPickerGridDelegate({
    this.mainAxisNumber,
  });

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = 270 / mainAxisNumber;
    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();