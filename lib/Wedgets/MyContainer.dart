import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  MyContainer({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    required this.color,
    this.child,
  });

  double height;
  double width;
  double radius;
  Color color;
  Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Center(child: child),
    );
  }
}
