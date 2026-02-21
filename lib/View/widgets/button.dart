import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  Button(
      {super.key,
      required this.color,
      required this.content,
      required this.function,
      this.width = double.infinity,
      this.height = 56,
      this.textColor = Colors.white});
  final Color color;
  Color textColor;
  final String content;
  final VoidCallback function;
  double width;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            content,
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
