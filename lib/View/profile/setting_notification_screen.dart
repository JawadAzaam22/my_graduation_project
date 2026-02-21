import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/profile/setting_notification_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../l10n/app_localizations.dart';

class SettingNotificationScreen extends StatelessWidget {
  const SettingNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingNotificationController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.notifications,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.sp, vertical: 8.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.h,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.specialOffers,
                value: controller.specialOffers,
                onChanged: controller.onSpecialOffersChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.sound,
                value: controller.sound,
                onChanged: controller.onSoundChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.vibrate,
                value: controller.vibrate,
                onChanged: controller.onVibrateChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.generalNotification,
                value: controller.generalNotification,
                onChanged: controller.onGeneralNotificationChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.paymentOptions,
                value: controller.paymentOptions,
                onChanged: controller.onPaymentOptionsChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.appUpdate,
                value: controller.appUpdate,
                onChanged: controller.onAppUpdateChanged,
              ),
              _buildSwitchTile(
                title: AppLocalizations.of(context)!.newServiceAvailable,
                value: controller.newServiceAvailable,
                onChanged: controller.onNewServiceAvailableChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required RxBool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.mulish(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Obx(
            () => CupertinoSwitch(
              value: value.value,
              activeColor: const Color(0xFF23255B),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
