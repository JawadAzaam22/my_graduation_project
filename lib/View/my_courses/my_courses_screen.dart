import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/my_courses/my_courses_controller.dart';
import 'package:german_board/View/widgets/button.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/MyCourses/my_course_card.dart';
import 'no_courses_screen.dart';

class MyCoursesScreen extends GetView<MyCoursesController> {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myCourses),
      ),
      body:
      LiquidPullToRefresh(
        onRefresh: controller.handleRefresh,
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        showChildOpacityTransition: true,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Obx(() => controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Button(
                              textColor: !controller.isLiveSelected.value &&
                                          Theme.of(context).brightness ==
                                              Brightness.dark ||
                                      !controller.isLiveSelected.value &&
                                          Theme.of(context).brightness ==
                                              Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                              width: 170.w,
                              color: controller.isLiveSelected.value
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                              content: AppLocalizations.of(context)!.live,
                              function: () {
                                controller.updateSelected(true);
                              },
                              height: 45,
                            ),
                            Button(
                                textColor: controller.isLiveSelected.value &&
                                            Theme.of(context).brightness ==
                                                Brightness.dark ||
                                        controller.isLiveSelected.value &&
                                            Theme.of(context).brightness ==
                                                Brightness.light
                                    ? Colors.black
                                    : Colors.white,
                                width: 170.w,
                                color: controller.isLiveSelected.value
                                    ? Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                    : Theme.of(context).primaryColor,
                                content: AppLocalizations.of(context)!.recorded,
                                function: () {
                                  controller.updateSelected(false);
                                },
                                height: 45)
                          ],
                        ),
                      ),
                      Expanded(
                        child: !controller
                                .noCourses(controller.isLiveSelected.value)
                                .value
                            ? ListView.builder(
                                itemCount: controller.isLiveSelected.value
                                    ? controller.liveCourses.length
                                    : controller.recordedCourses.length,
                                itemBuilder: (context, index) {
                                  var course = controller.isLiveSelected.value
                                      ? controller.liveCourses[index]
                                      : controller.recordedCourses[index];
                                  return InkWell(
                                    onTap: () {
                                      final type = controller.isLiveSelected.value
                                          ? "live"
                                          : "recorded";
                                      controller.navToViewCourse(type, course.id);
                                    },
                                    child: MyCourseCard(
                                      courseTitle: course.courseTitle,
                                      rating: course.rating,
                                      durationOfCourse: course.durationInHours,
                                      instructorName: course.instructorName,
                                      instructorRole: course.instructorRole,
                                      isCompleted: course.isCompleted,
                                      isOnline: controller.isLiveSelected.value,
                                      courseImage: course.courseImage,
                                      achievementRate:
                                          course.achievementRate ?? "0",
                                    ),
                                  );
                                },
                              )
                            : const NoCoursesScreen(),
                      ),
                    ],
                  ))),
      ),
    );
  }
}
