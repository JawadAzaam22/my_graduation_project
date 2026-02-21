import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:german_board/View/widgets/Home%20Screen/advertising_slider.dart';
import 'package:german_board/View/widgets/Home%20Screen/list_plogs.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Controller/home_controller.dart';
import '../Controller/notifications_controller.dart';
import '../l10n/app_localizations.dart';
import 'notifications_screen.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});
  GlobalKey _sliderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsetsDirectional.only(start: 15.w),
          child: Image.asset(
            "assets/images/logo.png",
            height: 35.h,
            width: 35.w,
            fit: BoxFit.contain,
          ),
        ),
        leadingWidth: 70.w,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          Padding(
              padding: const EdgeInsets.all(0),
              child: Obx(() {
                final c = Get.find<NotificationController>();
                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                      onPressed: () async {
                        await Get.to(() => NotificationScreen());
                        final c = Get.find<NotificationController>();
                        await c.markAllAsRead();
                        c.loadNotifications();
                      },
                    ),
                    if (c.unreadCount.value > 0)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${c.unreadCount.value}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                  ],
                );
              })),
          SizedBox(
            width: 2.w,
          ),
          InkWell(
            child: Icon(
              Icons.search,
              size: 30.sp,
            ),
            onTap: () {
              controller.navToSearch();
            },
          ),
          SizedBox(
            width: 5.w,
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: controller.handleRefresh,
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        showChildOpacityTransition: true,
        child: ListView(
          children: [
            Column(
              children: [
                AdvertisingSlider(g: _sliderKey),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.categories,
                              style: GoogleFonts.roboto(
                                  fontSize: 18.sp, fontWeight: FontWeight.w400),
                            ),
                            Obx(() => controller.isLoading
                                ? const SizedBox()
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: InkWell(
                                        onTap: () {
                                          controller.navToSeeAllCategories(
                                              controller.categories);
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .seeAll)))),
                          ]),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(() => controller.isLoading ||
                              controller.isLoadingCatCourse
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor))
                          : Container(
                              height: 60.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.categories.length,
                                itemBuilder: (context, index) {
                                  final category = controller.categories[index];
                                  return InkWell(
                                    onTap: () {
                                      controller
                                          .getCoursesOfCategory(category.id!);
                                    },
                                    child: Container(
                                      height: 50.h,
                                      width: 150.w,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 3.h),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3.h),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? const Color(0xFF444444)
                                            : Colors.white,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 0.1.w,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.15),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                            offset: const Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            category.name ?? "",
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.roboto(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .color,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            " ${category.number_of_courses.toString()} ${AppLocalizations.of(context)!.course} ",
                                            style: GoogleFonts.roboto(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.topCourses,
                            style: GoogleFonts.roboto(
                                fontSize: 18.sp, fontWeight: FontWeight.w400),
                          ),
                          Obx(() => controller.isLoading
                              ? SizedBox()
                              : Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: InkWell(
                                      onTap: () {
                                        controller.navAllCourses(
                                            controller.allCourses);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .seeAll)))),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Obx(() => controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor))
                          : Container(
                              height: 190.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.allCourses.length,
                                  itemBuilder: (context, index) {
                                    final course = controller.allCourses[index];
                                    return InkWell(
                                      onTap: () {
                                        controller.navToViewCourse(
                                            course.type, course.id!);
                                      },
                                      child: Container(
                                        width: 230.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(10),
                                              ),
                                              child: Image.network(
                                                course.cover,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 133.h,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color: Colors.grey[200],
                                                    child: const Center(
                                                      child: Icon(
                                                          Icons.error_outline,
                                                          color: Colors.red),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    // color: Theme.of(context)!.colorScheme.primary,
                                                    ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      course.name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .color!),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              course.rating
                                                                  .toString(),
                                                              style: GoogleFonts.roboto(
                                                                  fontSize:
                                                                      12.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Theme.of(
                                                                          context)                                                                      .textTheme
                                                                      .bodyLarge!
                                                                      .color!),
                                                            ),
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            100),
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/images/star.svg",
                                                                height: 14.h,
                                                                width: 14.w,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }))),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 15.h),
                        child: Text(
                          AppLocalizations.of(context)!.popularBlogs,
                          style: GoogleFonts.roboto(
                              fontSize: 18.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const ListPlogs()
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
