import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/color_pallet.dart';
import '../../Controller/auth/log_in_with_google_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Register/my_menu_dropdown.dart';
import '../widgets/Register/phone.dart';
import '../widgets/button.dart';
import '../widgets/my_text_field.dart';

class CompleteInformationScreen extends GetView<LogInWithGoogleController> {
  const CompleteInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 40.h),
          child: Column(
            children: [
              Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    "assets/images/bottomSplashPhoto.svg",
                    height: 320.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child:      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: GoogleFonts.habibi(
                            fontWeight: FontWeight.w700, fontSize: 40.sp),
                      ),
                    ),
                  )
                ],
              ),
              Obx(
                ()=> Form(
                  key: controller.formKey,
                  child:controller.isLoading? CircularProgressIndicator(color: Theme.of(context).primaryColor,):
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        AppLocalizations.of(context)!.completeYourDetails,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          myTextField(
                              controller: controller.firstNameController,
                              label: AppLocalizations.of(context)!.first,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return AppLocalizations.of(context)!.required;
                                }
                                return null;
                              },
                              width: 160),
                          SizedBox(width: 10.w),
                          myTextField(
                              controller: controller.lastNameController,
                              label: AppLocalizations.of(context)!.last,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return AppLocalizations.of(context)!.required;
                                }
                                return null;
                              },
                              width: 160),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              phone(
                                  width: 70,
                                  width1: 251,
                                  label: AppLocalizations.of(context)!.phone,
                                  controller: TextEditingController(
                                      text: controller.dialCode.value.toString()),
                                  controller1: controller.phoneController,
                                  validator:(email) {
                                    if (email == null || email.isEmpty) {
                                      return AppLocalizations.of(context)!.required;
                                    }
                                    return null;
                                  },
                                  readOnly1: false),
                            ],
                          )),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(AppLocalizations.of(context)!.date,
                                      style: TextStyle(
                                          color: labelColor,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: 160.w, minHeight: 48.h),
                                  child: TextField(
                                    controller: TextEditingController(
                                        text: controller.dateOfBirth.value),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                            width: 1, color: borderColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(7),
                                        borderSide: BorderSide(
                                            width: 1, color: focusedBorderColor),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      suffixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 25.sp,
                                      ),
                                    ),
                                    readOnly: true,
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                    ), //color: Colors.black
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2000),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        controller.setDateOfBirth(pickedDate);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          MyMenuDropdown(
                              label: AppLocalizations.of(context)!.gender,
                              items: controller.genders,
                              selectedItem: controller.selectedGender,
                              onChanged: (gender) {
                                controller.setGender(gender);
                              },
                              width: 160,
                              iconColor: Theme.of(context).iconTheme.color)
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.country,
                              style: TextStyle(
                                  color: labelColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400)),
                          const SizedBox(height: 5),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    controller.setCountry(country);
                                  },
                                );
                              },
                              child: Container(
                                height: 48.h,
                                width: 328.w,
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .border!
                                          .borderSide
                                          .color,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.selectedCountry.value,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .color,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 25.sp,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      myTextField(
                          label: AppLocalizations.of(context)!.address,
                          controller: controller.addressController,
                          validator: (address) {
                            if (address == null || address.isEmpty) {
                              return AppLocalizations.of(context)!.required;
                            }
                            return null;
                          },
                          width: 328),
                      SizedBox(
                        height: 10.h,
                      ),
                      Button(
                          color: Theme.of(context).primaryColor,
                          content: AppLocalizations.of(context)!.verify,
                          function: () {
                            controller.sendUserInformation();
                          },
                          width: 353.w),
                                  ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
