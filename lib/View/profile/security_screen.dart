import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/profile/security_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';

class SecurityScreen extends GetView<SecurityController> {
  const SecurityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.security,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Obx(() => ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      title: Text(
                        AppLocalizations.of(context)!.rememberMe,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                      trailing: CupertinoSwitch(
                        value: controller.rememberMe.value,
                        activeColor: Color(0xFF23255B),
                        onChanged: (value) {
                          controller.rememberMe.value = value;
                        },
                      ),
                    )),

                // Change Password
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  title: Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: TextStyle(
                      fontSize: 15.sp,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                  onTap: () {
                    controller.navToChangePassSec();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
