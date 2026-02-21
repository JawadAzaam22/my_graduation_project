import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Controller/recorded_training/view_enrolled_recorded_course_controller.dart';
import '../../../l10n/app_localizations.dart';

class CertificateWidget
    extends GetWidget<ViewEnrolledRecordedCourseController> {
  const CertificateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Obx(() {
      if (controller.isLoadingVid.value || controller.lesson.value == null) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
        );
      }

      final lesson = controller.lesson.value;
      final certificateUrl = lesson?.certificationImage;
      final hasCertificate =
          certificateUrl != null && certificateUrl.isNotEmpty;

      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 325.w,
                  height: 245.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: hasCertificate
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            certificateUrl!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.error_outline,
                                    color: Colors.red, size: 50.sp),
                              );
                            },
                          ),
                        )
                      : SvgPicture.asset(
                          'assets/images/preCertificate.svg',
                          fit: BoxFit.cover,
                        ),
                ),
                if (!hasCertificate)
                  Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.lock_outline,
                        size: 50.sp,
                        color: Colors.white,
                      ),
                    ),
                  )
                else
                  Positioned(
                    top: 10.h,
                    left: 10.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await controller.shareAssetImage(
                                lesson?.certificationImage ?? '');
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.share,
                                color: Colors.white, size: 24.sp),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () async {
                            await controller.saveToGallery();
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.download,
                                color: Colors.white, size: 24.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20.h),
            if (!hasCertificate)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.introCertificate,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.mulish(
                          fontSize: 14.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}
