import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildParticipantTile(String name, Color color) {
  return Container(
    width: 190.w,
    height: 320.h,
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: 95.w,
              height: 22.h,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.mic_off,
                    color: Colors.red,
                    size: 15.sp,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    name,
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: Colors.black),
                  )
                ],
              )),
        ),
      ],
    ),
  );
}
