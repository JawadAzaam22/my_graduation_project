import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/Live training/view_live_training_controller.dart';

class UserProfileCard extends GetWidget<ViewLiveTrainingController> {
  final String name;
  final String role;
  final int id;
  final String? imageUrl;
  final bool isOnline;

  const UserProfileCard({
    super.key,
    required this.id,
    required this.name,
    required this.role,
    this.imageUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primaryContainer),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    // color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: imageUrl != null
                      ? Image.asset(
                          imageUrl!,
                          fit: BoxFit.cover,
                          width: 361.w,
                          height: 204.h,
                        )
                      : Icon(
                          Icons.person,
                          size: 25.sp,
                          color: Color(0xFF121212),
                        ),
                ),
              ),
              Positioned(
                bottom: 2.h,
                right: Directionality.of(context) == TextDirection.ltr
                    ? 2.w
                    : null,
                left: Directionality.of(context) == TextDirection.rtl
                    ? 2.w
                    : null,
                child: Container(
                  width: 12.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  role,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          InkWell(
              onTap: () {
                Get.toNamed("/userprofiles", arguments: {
                  "id": id,
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 30.h,
                width: 70.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).textTheme.bodyMedium!.color!,
                    )),
                child: Text(
                  AppLocalizations.of(context)!.view,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                      fontSize: 10.sp),
                ),
              )),
        ],
      ),
    );
  }
}
