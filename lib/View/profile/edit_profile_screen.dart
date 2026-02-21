import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/color_pallet.dart';
import '../../Controller/profile/edit_profile_controller.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Register/my_menu_dropdown.dart';
import '../widgets/button.dart';
import '../widgets/my_text_field.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    Orientation orientation = MediaQuery.of(context).orientation;

    return GetBuilder(
        init: EditProfileController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.editProfile,
                  style: GoogleFonts.roboto(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
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
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  controller.uploadImage2();
                                },
                                child: CircleAvatar(
                                  radius: 16.r,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.camera_alt,
                                      size: 16.r, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        children: [
                          Expanded(
                            child: myTextField(
                              controller: controller.firstNameController,
                              hinText: AppLocalizations.of(context)!.first,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return AppLocalizations.of(context)!.required;
                                }
                                return null;
                              },
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: myTextField(
                              controller: controller.lastNameController,
                              hinText: AppLocalizations.of(context)!.last,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return AppLocalizations.of(context)!.required;
                                }
                                return null;
                              },
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      MyMenuDropdown(
                        label: AppLocalizations.of(context)!.gender,
                        items: controller.genders,
                        selectedItem: controller.selectedGender,
                        onChanged: (gender) {
                          controller.setGender(gender);
                        },
                        width: double.infinity,
                        iconColor: Colors.black,
                      ),
                      SizedBox(height: 10.h),
                      Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.date,
                              style: TextStyle(
                                color: labelColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              controller: TextEditingController(
                                text: controller.dateOfBirth.value,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                              readOnly: true,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      myTextField(
                        hinText: AppLocalizations.of(context)!.email,
                        controller: controller.emailController,
                        validator: controller.isValidEmail,
                        width: double.infinity,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10.h),
                      TextFormField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        validator: controller.phoneValidator,
                        decoration: InputDecoration(
                          hintText:
                              '( +${controller.selectedCountry.phoneCode} ) 987-848-1225',
                          prefixIcon: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country value) {
                                  controller.setCountry(value);
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 12),
                              child: Text(
                                "${controller.selectedCountry.flagEmoji} +${controller.selectedCountry.phoneCode}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.country,
                            style: TextStyle(
                              color: labelColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.selectedCountry1.value,
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Icon(Icons.arrow_drop_down,
                                        size: 25.sp, color: Colors.black),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      myTextField(
                        hinText: AppLocalizations.of(context)!.address,
                        controller: controller.addressController,
                        validator: (address) {
                          if (address == null || address.isEmpty) {
                            return AppLocalizations.of(context)!.required;
                          }
                          return null;
                        },
                        width: double.infinity,
                      ),
                      SizedBox(height: 30.h),
                      Obx(() => controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Button(
                              color: Theme.of(context).primaryColor,
                              content: AppLocalizations.of(context)!.submit,
                              function: () {},
                              width: double.infinity,
                            )),
                    ],
                  ),
                ),
              ),
            ));
  }
}
