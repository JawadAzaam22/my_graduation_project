import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/auth/password_changed_controller.dart';
import '../../l10n/app_localizations.dart';

class PasswordChangedScreen extends GetWidget<PasswordChangedController> {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Image(
                  image: const AssetImage(
                    'assets/images/stars.png',
                  ),
                  height: 126.h,
                  width: 146.w,
                ),
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  AppLocalizations.of(context)!.passChanged,
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold, fontSize: 30.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.passChangedIntro,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Button(
                    color: Theme.of(context).primaryColor,
                    content: AppLocalizations.of(context)!.backToLogin,
                    function: () {
                      controller.navToLogin();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
