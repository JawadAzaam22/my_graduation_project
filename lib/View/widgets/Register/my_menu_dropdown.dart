import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../Constants/color_pallet.dart';

Widget MyMenuDropdown({
  required String label,
  required List<String> items,
  required RxString selectedItem,
  required Function(String?)? onChanged,
  double height = 48,
  double width = 328,
  double borderRadius = 7,
  double borderWidth = 1,
  required Color? iconColor,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: TextStyle(
              fontSize: 15.sp, fontWeight: FontWeight.w400, color: labelColor)),
      const SizedBox(
        height: 5,
      ),
      Obx(() => ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width.w, minHeight: height.h),
            child: DropdownButtonFormField2(
              iconStyleData: IconStyleData(
                  iconDisabledColor: iconColor, iconEnabledColor: iconColor),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(
                    width: borderWidth,
                  ), // color: borderColor
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(
                    width: borderWidth,
                  ), // color: color2
                ),
              ),
              isExpanded: true,
              value: selectedItem.value,
              style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: labelColor),
              items: items
                  .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item, style: TextStyle(fontSize: 14.sp))))
                  .toList(),
              onChanged: onChanged,
            ),
          )),
    ],
  );
}
