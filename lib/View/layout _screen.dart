import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/my_courses/my_courses_screen.dart';
import 'package:german_board/View/profile/my_profile_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constants/color_pallet.dart';
import '../Controller/layout_controller.dart';
import '../l10n/app_localizations.dart';
import 'blogs/blogs_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends GetView<LayoutController> {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> nav = [
      AppLocalizations.of(context)!.home,
      AppLocalizations.of(context)!.myCourses,
      AppLocalizations.of(context)!.blogs,
      AppLocalizations.of(context)!.myProfile
    ];
    List<IconData> iconList = [
      Icons.home,
      Icons.play_circle_outline_rounded,
      Icons.menu_book_outlined,
      Icons.account_circle_outlined,
    ];

    return Obx(() => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: IndexedStack(
            index: controller.navIndex.value,
            children: [
              HomeScreen(),
              MyCoursesScreen(),
              BlogsScreen(),
              MyProfileScreen(),
            ],
          ),
          bottomNavigationBar: Container(
            height: 62.h,
            child: AnimatedBottomNavigationBar.builder(
              itemCount: nav.length,
              activeIndex: controller.navIndex.value,
              gapLocation: GapLocation.none,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              leftCornerRadius: 0,
              rightCornerRadius: 0,
              tabBuilder: (int index, bool isActive) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconList[index],
                          size: 28.sp,
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : color4,
                        ),
                        Text(
                          nav[index],
                          style: GoogleFonts.roboto(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isActive
                                ? Theme.of(context).primaryColor
                                : color4,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: isActive ? 3.h : 0,
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                );
              },
              elevation: 0,
              onTap: controller.changIndex,
              backgroundColor:
                  Theme.of(context).navigationBarTheme.backgroundColor,
            ),
          ),
        ));
  }
}
