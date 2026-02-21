import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/Live%20training/view_course_triannig_controller.dart';
import 'package:german_board/Models/live_training/enrolled_live_training_details_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../Live training/session_notes_screen.dart';

class SessionsWidget extends GetWidget<ViewCourseTriannigController> {
  const SessionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: Get.theme.primaryColor,
          ),
        );
      }

      if (controller.sessions.isEmpty) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: controller.sessions.length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) =>
            _buildSessionCard(controller.sessions[index], context),
      );
    });
  }

  Widget _buildSessionCard(Sessions session, BuildContext context) {
    final controller = Get.find<ViewCourseTriannigController>();

    return Container(
      width: 330.w,
      decoration: BoxDecoration(
        color: session.status == 'not_started'
            ? null
            : controller.getStatusColor(session.status).withOpacity(0.03),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Theme.of(context).textTheme.bodyMedium!.color!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    session.title ?? "",
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                _buildStatusIndicator(session, controller, context),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.grey.shade400,
                  size: 12.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  session.time ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Icon(
                  Icons.calendar_month,
                  color: Colors.grey.shade400,
                  size: 12.sp,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  session.date ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            _buildActionButtons(session, controller,controller.id,
                controller.training.value!.provider!.id, context),
            SizedBox(height: 5.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(
      Sessions session, controller, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: controller.getStatusColor(session.status).withOpacity(0.09),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        getStatusText(session.status, context),
        style: GoogleFonts.jost(
          fontSize: 12.sp,
          color: controller.getStatusColor(session.status).withOpacity(0.7),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      Sessions session, controller,trainingId, trainerID, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () =>Get.to(SessionNotesScreen(trainingId: trainingId, sessionId:session.id!,)),
              //controller.showNoteDialog(session.notes),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.viewNote,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                ),
              ),
              // SizedBox(
              //   width: 4.w,
              // ),
              // Icon(
              //   Icons.keyboard_arrow_down,
              //   size: 15.sp,
              //   color: Theme.of(context).textTheme.bodyMedium!.color!,
              // ),
            ],
          ),
        ),
        if (session.status == 'ongoing')
          InkWell(
            onTap: () {
              Get.toNamed("/agora", arguments: {
                "trainerId": "$trainerID",
                "chanel": "${session.id}",
                "training":"$trainingId",
                "sessionId":"${session.id}"
              });
            },
            child: Container(
              height: 25.h,
              width: 78.w,
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.theme.primaryColor),
              child: Text(
                AppLocalizations.of(context)!.join,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: session.status == 'not_started'
                      ? Colors.grey.shade400
                      : Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  String getStatusText(String? status, BuildContext context) {
    switch (status) {
      case 'completed':
        return AppLocalizations.of(context)!.completed;
      case 'ongoing':
        return AppLocalizations.of(context)!.ongoing;
      case 'canceled':
        return AppLocalizations.of(context)!.cancelled;
      case 'not_started':
        return AppLocalizations.of(context)!.notStarted;
      default:
        return 'ssss';
    }
  }
}
