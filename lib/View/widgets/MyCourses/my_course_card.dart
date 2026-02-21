import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../l10n/app_localizations.dart';

class MyCourseCard extends StatelessWidget {
  MyCourseCard(
      {super.key,
      required this.courseTitle,
      required this.rating,
      required this.durationOfCourse,
      required this.instructorName,
      required this.instructorRole,
      this.instructorImage,
      this.remainingHours,
      required this.isCompleted,
      required this.isOnline,
      required this.courseImage,
      this.achievementRate});
  final String courseTitle;
  String? achievementRate = "0";
  final double rating;
  final double durationOfCourse;
  final String instructorName;
  final double? remainingHours;
  final String instructorRole;
  final String? instructorImage;
  final String? courseImage;
  final bool isOnline;
  final bool isCompleted;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        height: 115.h,
        //  width: 368.w,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, 5),
              blurRadius: 7.r,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
              child: Image.network(
                courseImage!,
                fit: BoxFit.cover,
                width: 113.w,
                height: 93.h,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      courseTitle,
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: Colors.amber,
                        size: 18.sp,
                      ),
                      Text(
                        rating.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        child: VerticalDivider(
                          width: 10,
                        ),
                        height: 10,
                        width: 12,
                      ),
                      Text(
                        durationOfCourse.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 30.sp,
                            height: 30.sp,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: instructorImage != null
                                  ? Image.asset(
                                      instructorImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 30.sp,
                                      color: Colors.grey.shade600,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 2.h,
                            right:
                                Directionality.of(context) == TextDirection.ltr
                                    ? 2.w
                                    : null,
                            left:
                                Directionality.of(context) == TextDirection.rtl
                                    ? 2.w
                                    : null,
                            child: Container(
                              width: 7.sp,
                              height: 7.sp,
                              decoration: BoxDecoration(
                                color:
                                    //isOnline ? Colors.green :
                                    Colors.grey,
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
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              instructorName,
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              softWrap: true,
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              instructorRole,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: GoogleFonts.poppins(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    isCompleted
                        ? SvgPicture.asset(
                            "assets/images/complete.svg",
                            height: 30.h,
                            width: 30.w,
                            fit: BoxFit.cover,
                          )
                        : isOnline
                            ? SizedBox(
                                height: 22.h,
                              )
                            : CircularPercentIndicator(
                                radius: 15.sp,
                                lineWidth: 5.sp,
                                percent: double.parse(achievementRate!) / 100,
                                center: Text(
                                    "${double.parse(achievementRate!).round()}%",
                                    style: TextStyle(fontSize: 7.sp)),
                                progressColor: Colors.blue,
                                backgroundColor: Colors.grey.shade300,
                                circularStrokeCap: CircularStrokeCap.round,
                              ),
                    SizedBox(
                      height: 22.h,
                    ),
                    isCompleted
                        ? Text(
                            AppLocalizations.of(context)!.certificate,
                            style: GoogleFonts.mulish(
                              color: Colors.green,
                              fontWeight: FontWeight.w800,
                              fontSize: 8.sp,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.green,
                            ),
                          )
                        : isOnline
                            ? Container(
                                width: 60,
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Text(
                                  "on going",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.jost(
                                    fontSize: 11.sp,
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 8.sp,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "2 hours left",
                                    style: GoogleFonts.roboto(
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
