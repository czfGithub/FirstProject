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
  final Function onClick; //点击事件
  final double left; //距离左边位置
  final double right; //距离右边位置
  final double top; //距离上面位置
  final double bottom; //距离底部距离
  final List<Widget> items;

  Popup({
    this.child,
    this.onClick,
    this.left,
    this.right,
    this.top,
    this.bottom,
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
          child: child,
          left: left,
          top: top,
          right: right,
          bottom: bottom,),
      ],
    ),
      onTap: (){ //点击空白处关闭
        Navigator.of(context).pop();
      },
    ),);
  }

}

