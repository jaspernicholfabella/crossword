import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
    @required this.onTap,
    @required this.child,
    this.padding = 8.0,
    this.button_color = Colors.white
  }) : super(key: key);

  final onTap;
  final child;
  final padding;
  final button_color;

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
        child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color:button_color,
          shape:BoxShape.circle
        ),
        child:child
        ),
    );
  }
}