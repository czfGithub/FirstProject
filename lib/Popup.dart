import 'package:flutter/material.dart';

class PopRoute extends PopupRoute{
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

}

class Popup extends StatelessWidget{
  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double top; //距离上面位置
  final List<Widget> items;

  Popup({
    this.child,
    this.onClick,
    this.left,
    this.top,
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: GestureDetector(child: Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
        ),
        Positioned(
          child: Container(
            color: Colors.white,
            child: Column(children: items),
          ),
          left: left,
          top: top,),
      ],
    ),
      onTap: (){ //点击空白处
        Navigator.of(context).pop();
      },
    ),);
  }

}

