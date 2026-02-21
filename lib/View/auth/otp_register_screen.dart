import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/auth/otp_register_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/back_button.dart';
import '../widgets/button.dart';

class OtpRegisterScreen extends GetView<OtpRegisterController> {
  OtpRegisterScreen({super.key});

  var otpController = Get.put(OtpRegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              CustomBackButton(),
              SizedBox(
                height: 50.h,
              ),
              Text(
                AppLocalizations.of(context)!.enterCode,
                style: GoogleFonts.openSans(
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20.h,
              ),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.openSans(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context)!.sMSActivationCode,
                      style: GoogleFonts.openSans(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(text: ' '),
                    TextSpan(text: controller.phoneNum),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Obx(
                () => PinCodeTextField(
                  appContext: context,
                  length: 5,
                  keyboardType: TextInputType.number,
                  controller: controller.otpController,
                  onChanged: (value) {
                    print("${value}");
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 72.h,
                    fieldWidth: 63.w,
                    inactiveColor: Colors.grey.shade300,
                    selectedColor:
                        otpController.isError.value ? Colors.red : Colors.black,
                    activeColor: otpController.isError.value
                        ? Colors.red
                        : Colors.grey.shade300,
                  ),
                ),
              ),
              Obx(() => otpController.isError.value
                  ? Text(AppLocalizations.of(context)!.wrongCode,
                      style: GoogleFonts.openSans(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400))
                  : SizedBox()),
              SizedBox(height: 200.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => !otpController.isResendEnabled.value
                      ? Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sendCodeAgain,
                              style: GoogleFonts.openSans(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp),
                            ),
                            Text(
                              " 00:${otpController.remainingTime.value}",
                              style: GoogleFonts.openSans(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.notReceiveCode,
                              style: GoogleFonts.openSans(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            TextButton(
                              onPressed: otpController.resendOTP,
                              child: Text(
                                AppLocalizations.of(context)!.resend,
                                style: GoogleFonts.openSans(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp),
                              ),
                            )
                          ],
                        )),
                ],
              ),
              SizedBox(height: 20.h),
              Button(
                width: double.infinity,
                function: () {
                  controller.isLoading ? null : controller.verifyOTP();
                },
                color: Theme.of(context).primaryColor,
                content: AppLocalizations.of(context)!.verify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
