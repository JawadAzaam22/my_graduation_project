import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/browse_item_controller.dart';
import 'package:german_board/Models/one_course.dart';
import 'package:german_board/View/widgets/Live%20tranning/course_info_card.dart';
import 'package:german_board/View/widgets/back_button.dart';
import 'package:get/get.dart';

class BrowseItemScreen extends GetView<BrowseItemController> {
  const BrowseItemScreen({super.key});

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
      body: Obx(() {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.theme.primaryColor,
            ),
          );
        }

        if (controller.courses.isEmpty) {
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
            itemCount: controller.courses.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              OneCourse course = controller.courses[index];
              return InkWell(
                onTap: () {
                  controller.navToViewCourse(course.type, course.id!);
                },
                child:  CourseInfoCard(
                  courseImage: course.cover,
                  courseTitle: course.name,
                  learnersCount: 105000000,
                  instructorName:
                  "${course.provider?.firstName} ${course.provider?.lastName}",
                  instructorRole: course.provider?.specializedAt ?? "",
                  instructorImage: course.provider!.photo,
                ),
              );
            });
      }),
    );
  }
}
