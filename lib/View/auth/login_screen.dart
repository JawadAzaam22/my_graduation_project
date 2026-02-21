import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/auth/log_in_with_google_controller.dart';
import '../../Controller/auth/login_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/back_button.dart';
import '../widgets/button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  LoginController controller = Get.find<LoginController>();
  LogInWithGoogleController googleController =
      Get.find<LogInWithGoogleController>();
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50.h,
          leadingWidth: 60.w,
          leading: Center(
            widthFactor: 10.w,
            child: CustomBackButton(),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.login,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold, fontSize: 30.sp),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.emailAddress,
                        style: GoogleFonts.openSans(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 5.h),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: controller.isValidEmail,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enterEmail,
                          suffixIcon: Icon(Icons.check_circle),
                          hintStyle: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2)),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        AppLocalizations.of(context)!.password,
                        style: GoogleFonts.openSans(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 5.h),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          obscureText: controller.isObscure.value,
                          // validator: controller.getPasswordFeedback,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .passwordValidation;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText:
                                AppLocalizations.of(context)!.enterPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                  controller.isObscure.value
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Theme.of(context).iconTheme.color),
                              onPressed: controller.changeIsPass,
                            ),
                            hintStyle: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade100),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.w),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              controller.navToEnterNum();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgotPassword,
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      Obx(
                        () => controller.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ))
                            : Button(
                                color: Theme.of(context).primaryColor,
                                content: AppLocalizations.of(context)!.login,
                                function: () {
                                  controller.login();
                                },
                              ),
                      ),
                      SizedBox(
                        height: 120.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              height: 5.h,
                              color: Colors.grey,
                            ),
                          ),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.loginWith,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 5.h,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      InkWell(
                        onTap: () {
                          googleController.signInWithGoogle();
                        },
                        child: Container(
                          height: 56.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Color(0xFF444444)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/Google.svg',
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.google,
                                  style: GoogleFonts.inter(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAccount,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          controller.navToSignUp();
                        },
                        child: Container(
                          // width: 130.w,
                          child: Text(
                            AppLocalizations.of(context)!.createAccount,
                            softWrap: true,
                            maxLines: 2,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
