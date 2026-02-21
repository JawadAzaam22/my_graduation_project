import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/profile/my_profile_controller.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: MyProfileController(),
        builder: (controller) => SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.only(top: 40),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF444444)
                                    : Color(0x26A0A3BD),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 65.h),
                              Text(
                                controller.service.currentUser!.firstName!,
                                style: GoogleFonts.jost(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                controller.service.currentUser!.email!,
                                style: GoogleFonts.mulish(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Expanded(
                                child: ListView(
                                  children: [
                                    _profileItem(
                                      Icons.edit,
                                      () {
                                        controller.navToEditProfile();
                                      },
                                      AppLocalizations.of(context)!.editProfile,
                                    ),
                                    // _profileItem(
                                    //   Icons.payment,
                                    //   () {
                                    //     print("object");
                                    //   },
                                    //   AppLocalizations.of(context)!
                                    //       .paymentOptions,
                                    // ),
                                    _profileItem(
                                      Icons.book_online,
                                      () {
                                        controller.navToSearchCertificate();
                                      },
                                      AppLocalizations.of(context)!
                                          .certificates,
                                    ),
                                    _profileItem(
                                      Icons.notifications,
                                      () {
                                        controller.navToSettingNotify();
                                      },
                                      AppLocalizations.of(context)!
                                          .notifications,
                                    ),
                                    _profileItem(
                                      Icons.security,
                                      () {
                                        controller.navToSecurity();
                                      },
                                      AppLocalizations.of(context)!.security,
                                    ),
                                    _profileItem(Icons.language, () {
                                      controller.navToLanguage();
                                    }, AppLocalizations.of(context)!.language,
                                        trailing: Text(
                                            Localizations.localeOf(context)
                                                        .languageCode ==
                                                    'en'
                                                ? AppLocalizations.of(context)!
                                                    .english
                                                : Localizations.localeOf(
                                                                context)
                                                            .languageCode ==
                                                        'de'
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .deutsch
                                                    : AppLocalizations.of(
                                                            context)!
                                                        .arabic,
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontSize: 13.sp))),
                                    _profileItem(Icons.dark_mode, () {
                                      print("object");
                                    }, AppLocalizations.of(context)!.darkMode,
                                        trailing: Obx(
                                          () => CupertinoSwitch(
                                            activeColor:
                                                const Color(0xFF23255B),
                                            value: controller.isDarkMode.value,
                                            onChanged: (bool value) {
                                              controller.isDarkMode.value =
                                                  value;

                                              if (value) {
                                                AdaptiveTheme.of(context)
                                                    .setDark();
                                                controller.update();
                                              } else {
                                                AdaptiveTheme.of(context)
                                                    .setLight();
                                                controller.update();
                                              }
                                            },
                                          ),
                                        )),
                                    _profileItem(
                                      Icons.report_problem_outlined,
                                      () {
                                        controller.navToComplaint();
                                      },
                                      AppLocalizations.of(context)!.complaint,
                                    ),
                                    _profileItem(
                                      Icons.description,
                                      () {
                                        controller.navToTermsAndCondition();
                                      },
                                      AppLocalizations.of(context)!
                                          .termsConditions,
                                    ),
                                    _profileItem(
                                      Icons.help_center,
                                      () {
                                        print("object");
                                      },
                                      AppLocalizations.of(context)!.helpCenter,
                                    ),
                                    _profileItem(Icons.group_add, () {
                                      Share.share(
                                        'قم بتحميل التطبيق من هنا: https://yourappdownloadlink.com',
                                        subject: 'رابط تحميل التطبيق',
                                      );
                                    },
                                        AppLocalizations.of(context)!
                                            .inviteFriends),
                                    _profileItem(
                                      Icons.logout_outlined,
                                      () {
                                        controller.logout();
                                      },
                                      AppLocalizations.of(context)!.logout,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  width: 96.r,
                                  height: 96.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Container(
                                    width: 96.r,
                                    height: 96.r,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                    ),
                                    child: CircleAvatar(
                                      radius: 48.r,
                                      backgroundColor: Colors.white,
                                      child: controller.image2 == null
                                          ? Icon(Icons.person,
                                              size: 60.r, color: Colors.grey)
                                          : ClipOval(
                                              child: Image.file(
                                                controller.image2!,
                                                width: 96.r,
                                                height: 96.r,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _profileItem(IconData icon, GestureTapCallback press, String title,
      {Widget? trailing}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
            style: GoogleFonts.mulish(
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: trailing ??
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
          onTap: press,
        ),
      ],
    );
  }
}
