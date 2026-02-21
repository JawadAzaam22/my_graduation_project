import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/auth/log_in_with_google_controller.dart';
import '../../Controller/auth/welcome-controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  WelcomeController controller = Get.find<WelcomeController>();
  LogInWithGoogleController googleController =
      Get.find<LogInWithGoogleController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
          child: Column(
            children: [
              Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/images/topSplashPhoto.svg",
                    height: 320.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        "assets/images/logo1.png",
                        height: 120.h,
                        width: 123.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeSentence,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700, fontSize: 32.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcomeSentence1,
                      style: GoogleFonts.inter(
                          fontSize: 17.sp,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                    Text(
                      AppLocalizations.of(context)!.welcomeSentence2,
                      style: GoogleFonts.inter(
                          fontSize: 17.sp,
                          color: Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Button(
                        color: Theme.of(context).primaryColor,
                        content: AppLocalizations.of(context)!.login,
                        function: () {
                          controller.navToLogIn();
                        },
                        width: 353),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        googleController.signInWithGoogle();
                      },
                      child: Container(
                        height: 56.h,
                        width: 353.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF444444)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(7.11),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Obx(
                            () => googleController.isLoading
                                ? const CircularProgressIndicator()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            end: 5.w),
                                        child: SvgPicture.asset(
                                          "assets/images/Google.svg",
                                          height: 18.h,
                                          width: 18.w,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.logWGoogl,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () {
                        controller.navToRegister();
                      },
                      child: Container(
                        height: 56.h,
                        width: 353.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF444444)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(7.11),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.createAccount,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
