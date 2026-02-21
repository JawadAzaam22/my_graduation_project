import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../l10n/app_localizations.dart';

class CourseInfoCard extends StatelessWidget {
  final String courseTitle;
  final int learnersCount;
  final String instructorName;
  final String instructorRole;
  final String? instructorImage;
  final String? courseImage;

  const CourseInfoCard({
    super.key,
    required this.courseTitle,
    required this.learnersCount,
    required this.instructorName,
    required this.instructorRole,
    this.instructorImage,
    required this.courseImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 348.w,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        border: Border.all(width: 1, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(10, 10),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Title
                Container(
                  child: Text(
                    courseTitle,
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4.h),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 41.sp,
                          height: 41.sp,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.5.w,
                            ),
                          ),
                          child: ClipOval(
                            child: instructorImage!.isNotEmpty
                                ? Image.network(
                                    instructorImage!,
                                    fit: BoxFit.cover,
                                    width: 361.w,
                                    height: 204.h,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 30.sp,
                                    color: Colors.grey.shade600,
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
                            instructorName,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyMedium?.color,
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
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
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
          SizedBox(
            width: 5.w,
          ),
          Icon(
            Icons.person,
            size: 30.sp,
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  String _formatLearners(int count, BuildContext context) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k ${AppLocalizations.of(context)!.learners}';
    }
    return '$count ${AppLocalizations.of(context)!.learners}';
  }
}
