import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/color_pallet.dart';

Widget myTextField(
    {String? label,
    String? hinText,
    Function(String?)? onChanged,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    double height = 48,
    double? width,
    bool readOnly = false,
    Color borderColor = borderColor,
    Color labelColor = labelColor,
    String? Function(String?)? validator,
    required TextEditingController controller,
    Widget? mySuffixIcon}) {
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
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width != null ? width.w : double.infinity,
        ),
        child: TextFormField(
          readOnly: readOnly,
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: TextStyle(
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hinText,
            suffixIcon: mySuffixIcon,
            hintStyle: GoogleFonts.mulish(
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade400)),
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
          onChanged: onChanged,
          validator: validator,
        ),
      )
    ],
  );
}
