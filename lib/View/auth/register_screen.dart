import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Constants/color_pallet.dart';
import 'package:get/get.dart';
import '../../Controller/auth/register_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Register/phone.dart';
import '../widgets/back_button.dart';
import '../widgets/button.dart';
import '../widgets/Register/my_menu_dropdown.dart';
import '../widgets/my_text_field.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    controller.context = context;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding:
                EdgeInsetsDirectional.only(start: 17.w, bottom: 30.h, end: 17),
            child: Column(
              crossAxisAlignment:
                  //orientation == Orientation.portrait
                  //  ? CrossAxisAlignment.start
                  //    :
                  CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 25.h, top: 25.h),
                  child: Text(
                    AppLocalizations.of(context)!.createAccount,
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      //orientation == Orientation.portrait
                      //  ? MainAxisAlignment.start
                      //    :
                      MainAxisAlignment.center,
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
                        validator: (Name) {
                          if (Name == null || Name.isEmpty) {
                            return AppLocalizations.of(context)!.required;
                          }
                        },
                        width: 160),
                  ],
                ),
                const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                          // orientation == Orientation.portrait
                          //     ? MainAxisAlignment.start
                          //     :
                          MainAxisAlignment.center,
                      children: [
                        phone(
                          width: 70,
                          width1: 251,
                          label: AppLocalizations.of(context)!.phone,
                          controller: TextEditingController(
                              text: controller.dialCode.toString()),
                          controller1: TextEditingController(
                              text: controller.phoneNumber), //.value.toString()
                        ),
                      ],
                    )
                ,
                const SizedBox(height: 10),
                myTextField(
                    label: AppLocalizations.of(context)!.email,
                    controller: controller.emailController,
                    validator: controller.isValidEmail,
                    width: 328,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                Obx(
                  () => myTextField(
                    label: AppLocalizations.of(context)!.password,
                    controller: controller.passwordController,
                    width: 328,
                    validator: controller.getPasswordFeedback,
                    isPassword: controller.isObscure.value,
                    mySuffixIcon: IconButton(
                      icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Theme.of(context).iconTheme.color),
                      onPressed: controller.changeIsPass,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => myTextField(
                    label: AppLocalizations.of(context)!.confirm,
                    validator: controller.isValidPasswordConfirmation,
                    controller: controller.passwordConfirmationController,
                    width: 328,
                    isPassword: controller.isObscure.value,
                    mySuffixIcon: IconButton(
                      icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Theme.of(context).iconTheme.color),
                      onPressed: controller.changeIsPass,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment:
                      // orientation == Orientation.portrait
                      //     ? MainAxisAlignment.start
                      //     :
                      MainAxisAlignment.center,
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
                                  borderSide:
                                      BorderSide(width: 1, color: borderColor),
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
                const SizedBox(height: 40),
                Obx(
                  () => controller.isLoading
                      ? CircularProgressIndicator()
                      : Button(
                          color: Theme.of(context).primaryColor,
                          content: AppLocalizations.of(context)!.submit,
                          function: () {
                            controller.signUP();
                            // controller.formKey.currentState!.validate();
                          },
                          width: 353.w),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
