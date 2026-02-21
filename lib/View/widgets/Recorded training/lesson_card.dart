import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LessonCard extends StatelessWidget {
  const LessonCard(
      {super.key,
      required this.lessonId,
      required this.title,
      required this.isLocked,
      required this.duration});
  final int lessonId;
  final String title;
  final bool isLocked;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      child: ListTile(
        leading: Container(
          width: 46.w,
          height: 46.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$lessonId',
              style: GoogleFonts.jost(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF121212),
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.jost(fontSize: 16.sp, fontWeight: FontWeight.w400),
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(duration,
            style: GoogleFonts.mulish(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge?.color)),
        trailing: isLocked
            ? Icon(Icons.lock_outline_rounded,
                size: 17.sp, color: Theme.of(context).iconTheme.color)
            : null,
      ),
    );
  }
}
