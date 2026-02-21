import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Models/profiles.dart';
import 'package:german_board/profile/user_profile_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../View/widgets/back_button.dart';
import '../l10n/app_localizations.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: CustomBackButton(),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }

        if (controller.isFailed.value || controller.profiles.value == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                  child: Icon(Icons.error_outline,
                      size: 80.sp, color: Colors.red)),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.louddata,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          );
        }

        final profiles = controller.profiles.value!;

        return Column(
          children: [
            _buildCoverAndProfileSection(context, profiles),
            SizedBox(height: 30.h),
            _buildStatsSection(context, profiles),
            SizedBox(height: 20.h),
            _buildTabNavigation(context),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Obx(
                    () {
                      if (controller.selectedTab.value == 0) {
                        return Column(
                          children: [
                            _buildContentCard(
                                AppLocalizations.of(context)!.brief, profiles.brief ?? "", context),
                            SizedBox(height: 15.h),
                            _buildContentCard(
                                AppLocalizations.of(context)!.gender, profiles.gender ?? "", context),
                            SizedBox(height: 15.h),
                            _buildContentCard(
                                AppLocalizations.of(context)!.location, profiles.location ?? "", context),
                            SizedBox(height: 15.h),
                            _buildContentCard(
                                AppLocalizations.of(context)!.phone, profiles.phoneNumber ?? "", context),
                            SizedBox(height: 15.h),
                            _buildContentCard(AppLocalizations.of(context)!.dateofbirth,
                                profiles.dateOfBirth ?? "", context),
                          ],
                        );
                      } else {
                        return Obx(() {
                          if (controller.isLoading.value) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Get.theme.primaryColor,
                              ),
                            );
                          }

                          if (profiles.trainings!.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.w),
                                child: Text(
                                  AppLocalizations.of(context)!.thernocours,
                                  style: GoogleFonts.mulish(
                                    fontSize: 16.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            );
                          }

                          return ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: profiles.trainings!.length,
                            separatorBuilder: (_, __) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) => _buildCourseItem(
                                context,profiles.trainings![index]),
                          );
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCoverAndProfileSection(BuildContext context, Profiles profiles) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              child: Image.network(
                profiles.cover!,
                fit: BoxFit.cover,
                width: 361.w,
                height: 204.h,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
            ),
            Positioned(
              top: 180.h - (85.h / 2),
              right: 280.w,
              child: Container(
                width: 85.w,
                height: 85.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: <Color>[
                      const Color(0xFF2B40FF),
                      const Color(0xFF04001F),
                      const Color(0xFF000000),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.network(
                        profiles.photo!,
                        fit: BoxFit.cover,
                        width: 361.w,
                        height: 204.h,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.error_outline, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profiles.name!,
                      style: GoogleFonts.jost(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyMedium!.color!,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      profiles.specializedAt!,
                      style: GoogleFonts.mulish(
                        fontSize: 13,
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        )
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context, Profiles profile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(
            profile.allTraineeEnrolled.toString(), AppLocalizations.of(context)!.course, context),
        _buildStatItem(
            profile.trainings?.length.toString() ?? '0', AppLocalizations.of(context)!.student, context),
        _buildStatItem(profile.role!, AppLocalizations.of(context)!.role, context),
      ],
    );
  }

  Widget _buildStatItem(String number, String label, BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.jost(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.mulish(
            fontSize: 13,
            color: Theme.of(context).textTheme.bodyLarge!.color,
          ),
        ),
      ],
    );
  }

  Widget _buildTabNavigation(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setSelectedTab(0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 0
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.profiles,
                      style: TextStyle(
                        color: controller.selectedTab.value == 0
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setSelectedTab(1),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 1
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.courses,
                      style: TextStyle(
                        color: controller.selectedTab.value == 1
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard(String title, String content, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyMedium!.color),
          ),
          SizedBox(height: 10.h),
          Text(
            content,
            style: GoogleFonts.roboto(
              fontSize: 12.sp,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem(BuildContext context, Training training) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child:  Image.network(
                training.cover!,
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.error_outline, color: Colors.red),
                  );
                },
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    training.name!,
                    style: GoogleFonts.jost(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    training.type!,
                    style: GoogleFonts.mulish(
                      fontSize: 15.sp,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: Text(
                      training.price!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 18,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              training.rating.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '${training.traineeEnrolled} Std',
                        style: GoogleFonts.mulish(
                          fontSize: 13.sp,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
