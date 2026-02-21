import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/profile/change_pass_security_controller.dart';
import '../../l10n/app_localizations.dart';

class ChangePassSecurityScreen extends GetView<ChangePassSecurityController> {
  const ChangePassSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.newPassword,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),

                Text(
                  AppLocalizations.of(context)!.oldPassword,
                  style: GoogleFonts.openSans(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => TextFormField(
                    controller: controller.oldPasswordController,
                    obscureText: controller.isObscure2.value,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.required;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.enterPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure2.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: controller.changeIsPass2,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
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
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
                //////////////
                SizedBox(height: 20.h),

                Text(
                  AppLocalizations.of(context)!.newPassword,
                  style: GoogleFonts.openSans(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    validator: controller.getPasswordFeedback,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.newPasswordHint,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: controller.changeIsPass,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
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
                        borderSide: BorderSide(color: Colors.grey, width: 2),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.confirmPassword,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 5.h),
                Obx(
                  () => TextFormField(
                    controller: controller.conformPasswordController,
                    obscureText: controller.isObscure1.value,
                    validator: controller.isValidPasswordConfirmation,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context)!.confirmPasswordHint,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure1.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onPressed: controller.changeIsPass1,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 16.sp,
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
                        borderSide: BorderSide(color: Colors.grey, width: 2.w),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 60.h,
                ),
                Obx(() => controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ))
                    : Button(
                        color: Theme.of(context).primaryColor,
                        content: AppLocalizations.of(context)!.resetPassword,
                        function: () {
                          controller.resetPassword();
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
