import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Controller/recorded_training/view_enrolled_recorded_course_controller.dart';
import 'package:get/get.dart';
import '../../../Models/recorded/lesson.dart';
import '../../../l10n/app_localizations.dart';
import '../../recorded training/video_player_screen.dart';

class LessonsWidget extends GetWidget<ViewEnrolledRecordedCourseController> {
  LessonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final lessonsList = controller.lesson.value?.items ?? [];

      if (controller.lesson.value == null) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }

      if (lessonsList.isEmpty) {
        return Center(
          child: Text(
            AppLocalizations.of(context)!.noLesson,
            style: GoogleFonts.roboto(fontSize: 16.sp),
          ),
        );
      }

      int videoCounter = 1;
      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: lessonsList.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final item = lessonsList[index];

          if (item.type == "video") {
            final number = videoCounter++;
            return _buildVideoCard(item, context, number);
          } else if (item.type == "quiz") {
            return InkWell(
              onTap: () {
                controller.navToQuiz(item.quizId!);
              },
              child: _buildQuizCard(item, context),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      );
    });
  }

  Widget _buildVideoCard(LessonItem video, BuildContext context, int number) {
    final watched = video.status == true;
    final locked = video.isLocked;
    return Opacity(
      opacity: locked ? 0.5 : 1,
      child: Container(
        width: double.infinity,
        height: 103.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                number.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(



                    child: Text(
                      video.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    onTap:  locked
                ? null
                : () {
      if (video.videoUrl != null && video.videoUrl!.isNotEmpty) {
        print(video.videoUrl!);
      Get.to(() => VideoPlayerScreen(

        videoUrl:video.videoUrl!,));
      } else {
      Get.snackbar( AppLocalizations.of(context)!.alert,  AppLocalizations.of(context)!.nourl);
      }
      },
                  ),

                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              locked
                  ? Icons.lock
                  : watched
                  ? Icons.check_circle
                  : Icons.play_circle_fill,
              size: 24.sp,
              color: locked
                  ? Colors.grey
                  : watched
                  ? Colors.green
                  : Colors.grey,
            ),
            SizedBox(width: 8.w),
            video.isLocked
                ? SizedBox()
                : video.status
                ? SizedBox()
                : IconButton(
              icon: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title:  Text( AppLocalizations.of(context)!.changVidStatue),
                      content: Text( AppLocalizations.of(context)!.isCompleteWatch),
                      actions: [
                        TextButton(
                          onPressed: () {
                            controller.changeVideoStatus(video.videoId!,context);

                          },
                          child: Text( AppLocalizations.of(context)!.yes),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizCard(LessonItem quiz, BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (quiz.status) {
      case "passed":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case "failed":
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case "done":
        statusColor = Colors.orange;
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.hourglass_empty;
    }

    return Opacity(
      opacity: quiz.isLocked ? 0.5 : 1,
      child: Container(
        width: double.infinity,
        height: 70.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.quiz_outlined, color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.black),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                quiz.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
            Icon(statusIcon, color: statusColor),
          ],
        ),
      ),
    );
  }
}







