import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../Controller/Live training/view_course_triannig_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Live tranning/view course trainning widget/attachment_widget.dart';
import '../widgets/Live tranning/view course trainning widget/cal_wid.dart';
import '../widgets/Live tranning/view course trainning widget/sessions_widget.dart';
import '../widgets/back_button.dart';

class ViewCourseTriannigScreen extends GetView<ViewCourseTriannigController> {
  const ViewCourseTriannigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: const CustomBackButton(),
        ),
      ),
      // -1-
      body: LiquidPullToRefresh(
        onRefresh: controller.handleRefresh,
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        showChildOpacityTransition: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      final training = controller.training.value;
                      if (training == null || training.title == null) {
                        return Text(" ");
                      }
                      return Text(
                        training.title!,
                        maxLines: 2,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 204.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Obx(() {
                          final training = controller.training.value;
                          if (training == null || training.cover == null) {
                            return Container(
                              height: 204.h,
                              color: Colors.grey[300],
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network(
                              training.cover!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 204.h,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: Icon(Icons.error_outline,
                                      color: Colors.red),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                      Positioned(
                        bottom: 16.h,
                        left: Directionality.of(context) == TextDirection.ltr
                            ? 16.w
                            : null,
                        right: Directionality.of(context) == TextDirection.rtl
                            ? 16.w
                            : null,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.wifi_tethering,
                                  color: Colors.blue, size: 14.sp),
                              SizedBox(width: 4.w),
                              Text(
                                AppLocalizations.of(context)!.liveTrainning,
                                style: GoogleFonts.nunitoSans(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  // -3-
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: TabBar(
                    controller: controller.tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      shape: BoxShape.rectangle,
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10.r,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    dividerHeight: double.nan,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: GoogleFonts.roboto(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.sessions),
                      Tab(text: AppLocalizations.of(context)!.attachments),
                      Tab(text: AppLocalizations.of(context)!.calendar),
                    ],
                    padding: EdgeInsets.all(6.w),
                  ),
                ),
                SizedBox(height: 20.h),
                // -2-
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: [
                      const SessionsWidget(),
                      const AttachmentWidget(),
                      CalWid(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
