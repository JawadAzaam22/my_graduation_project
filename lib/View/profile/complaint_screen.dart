import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/profile/complaint_controller.dart';
import '../../l10n/app_localizations.dart';

class ComplaintScreen extends GetView<ComplaintController> {
  ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.complaint,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Obx(() => DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'kind of complaint',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.complaintType.value,
                    items: controller.complaintTypes
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (val) => controller.complaintType.value = val,
                  )),
              SizedBox(height: 16.h),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'complaint content',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                controller: controller.description,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "AppLocalizations.of(context)!.emp";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'connected info(optional)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) => controller.contactInfo.value = val,
                    controller: TextEditingController(
                        text: controller.contactInfo.value),
                  )),
              const SizedBox(height: 16),
              Button(
                  color: Theme.of(context).primaryColor,
                  content: AppLocalizations.of(context)!.addComplaint,
                  function: controller.submitComplaint)
            ],
          ),
        ),
      ),
    );
  }
}
