import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/profile/language_controller.dart';
import '../../l10n/app_localizations.dart';

class LanguageScreen extends GetView<LanguageController> {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    controller.initLanguages(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.language,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Expanded(
            child: ListView.separated(
              itemCount: controller.languages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 0),
              itemBuilder: (context, index) {
                return Obx(() => ListTile(
                      title: Text(
                        controller.languages[index]['name']!,
                        style: GoogleFonts.mulish(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      trailing: Checkbox(
                        value: controller.selectedIndex.value == index,
                        onChanged: (val) {
                          controller.selectLanguage(index);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        activeColor: Colors.indigo,
                        checkColor: Colors.white,
                        side:
                            BorderSide(color: Colors.grey.shade400, width: 1.5),
                      ),
                      onTap: () => controller.selectLanguage(index),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
