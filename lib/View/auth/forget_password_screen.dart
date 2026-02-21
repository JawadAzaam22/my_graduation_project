import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/auth/enter_number_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/back_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: EnterNumberController(),
        builder: (controller) {
          controller.context = context;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 50.h,
              leadingWidth: 100.w,
              leading: const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: CustomBackButton(),
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
                        AppLocalizations.of(context)!.forgotPassword,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold, fontSize: 30.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.forgetPassIntro,
                        style: GoogleFonts.roboto(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Colors.grey.shade100, width: 1.w),
                            bottom: BorderSide(
                                color: Colors.grey.shade100, width: 1.w),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                    context: context,
                                    showPhoneCode: true,
                                    onSelect: (Country value) {
                                      controller.selectedCountry = value;
                                      controller.update();
                                    });
                              },
                              child: Text(
                                "${controller.selectedCountry.flagEmoji} +${controller.selectedCountry.phoneCode}",
                                style: GoogleFonts.openSans(
                                    textStyle: GoogleFonts.openSans(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ),
                            Text(" | ",
                                style: GoogleFonts.openSans(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade200)),
                            Expanded(
                              child: TextFormField(
                                controller: controller.phoneController,
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  controller.phoneController.text = value;
                                  controller.update();
                                },
                                validator: controller.phoneValidator,
                                decoration: InputDecoration(
                                  hintText: '0 00 00 00 00',
                                  hintStyle: GoogleFonts.openSans(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey.shade400)),
                                  counterText: "",
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Obx(() => controller.isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ))
                          : Button(
                              color: Theme.of(context).primaryColor,
                              content: AppLocalizations.of(context)!.sendCode,
                              function: () {
                                controller.sendCode();
                              }))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
