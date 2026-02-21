import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../Constants/color_pallet.dart';
import '../../../l10n/app_localizations.dart';

Widget MyDatePicker({
  required BuildContext context,
  void Function()? onTap,
  RxString? selectedDate,
  double height = 48,
  double width = 160,
  double borderRadius = 7,
  double borderWidth = 1,
  Color borderColor = borderColor,
  Color iconColor = primaryIconColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(AppLocalizations.of(context)!.date,
          style: TextStyle(
              color: labelColor, fontSize: 15.sp, fontWeight: FontWeight.w400)),
      SizedBox(
        width: width.w,
        height: height.h,
        child: TextField(
          controller: TextEditingController(), //text: selectedDate.value
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(width: borderWidth, color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(width: borderWidth, color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(width: borderWidth, color: focusedBorderColor),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
            suffixIcon: Icon(Icons.calendar_month_outlined, color: iconColor),
          ),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (pickedDate != null) {
              selectedDate?.value =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            }
          },
        ),
      ),
    ],
  );
}
