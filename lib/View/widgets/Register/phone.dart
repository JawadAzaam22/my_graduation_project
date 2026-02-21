import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Constants/color_pallet.dart';

Widget phone({
  String? label,
  bool isPassword = false,
  double height = 48,
  double? width,
  double? width1,
  bool readOnly = true,
  bool readOnly1 = true,
  Color borderColor = borderColor,
  Color labelColor = labelColor,
  String? Function(String?)? validator,
  required TextEditingController controller,
  required TextEditingController controller1,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (label != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            label,
            style: TextStyle(
                color: labelColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
      Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width != null ? width.w : double.infinity,
              //  maxWidth: 500,
            ),
            child: TextFormField(
              readOnly: readOnly,
              controller: controller,
              obscureText: isPassword,
              style: TextStyle(
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(width: 1),
                ),
              ),
              validator: validator,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: width1 != null ? width1.w : double.infinity,
            ),
            child: TextFormField(
              readOnly: readOnly1,
              controller: controller1,
              obscureText: isPassword,
              style: TextStyle(
                fontSize: 15.sp,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(width: 1),
                ),
              ),
              validator: validator,
            ),
          ),
        ],
      )
    ],
  );
}
