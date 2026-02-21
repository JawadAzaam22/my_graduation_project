import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/auth/splash_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Constants/color_pallet.dart';
import '../../l10n/app_localizations.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      Get.offAndToNamed("/welcome");
    });

    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/topSplashPhoto.svg",
                height: 320.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 38.h, bottom: 100.h),
                child: Container(
                  // height: 300.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 138.h,
                          width: 142.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.splashSentence,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: primaryTextColor),
                      ),
                      Text(
                        AppLocalizations.of(context)!.splashSentence2,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: primaryTextColor),
                      )
                    ],
                  ),
                ),
              ),
              SvgPicture.asset(
                "assets/images/bottomSplashPhoto.svg",
                height: 320.h,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
      ),
    );
  }
}
