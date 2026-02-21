import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Controller/Live training/view_course_triannig_controller.dart';
import '../../../../Models/live_training/enrolled_live_training_details_model.dart';

class AttachmentWidget extends GetWidget<ViewCourseTriannigController> {
  const AttachmentWidget({
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

      if (controller.attachments.isEmpty) {
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
        itemCount: controller.attachments.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) =>
            _buildAttachmentCard(controller.attachments[index], context),
      );
    });
  }

  Widget _buildAttachmentCard(Attachments attachment, BuildContext context) {
    String fileName = attachment.fileName ?? '';
    String extension = "default";

    if (fileName!.contains('.') && !fileName.endsWith('.')) {
      List<String> parts = fileName.split('.');
      if (parts.length > 1) {
        extension = parts.last.toLowerCase();
      }
    }
    IconData fileIcon;
    switch (extension) {
      case 'pdf':
        fileIcon = Icons.picture_as_pdf;
        break;
      case 'jpg':
      case 'png':
      case 'jpeg':
        fileIcon = Icons.image;
        break;
      case 'mp4':
      case 'mov':
        fileIcon = Icons.video_file;
        break;
      default:
        fileIcon = Icons.insert_drive_file;
    }

    return Container(
      width: 330.w,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(fileIcon, size: 28.sp, color: Colors.grey.shade600),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color:
                              Theme.of(context)!.textTheme.bodyMedium!.color!,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Text(
                            attachment.fileSize ?? "",
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            attachment.fileDate ?? "",
                            style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(() {
                      final url = attachment.fileUrl!;
                      final isDownloaded = controller.isFileDownloaded(url);

                      return IconButton(
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isDownloaded
                              ? Icon(Icons.visibility,
                                  key: ValueKey('view-$url'))
                              : Icon(Icons.download,
                                  key: ValueKey('download-$url')),
                        ),
                        onPressed: () async {
                          if (isDownloaded) {
                            await controller.openFile(url);
                          } else {
                            await controller.downloadFile(url);
                          }
                        },
                      );
                    }),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
