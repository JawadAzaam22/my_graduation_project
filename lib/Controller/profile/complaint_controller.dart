import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ComplaintController extends GetxController {
  TextEditingController description = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var complaintType = RxnString();
  var contactInfo = ''.obs;
  final complaintTypes = ['Course', 'Blog', 'Trainer', "Others"];
  void submitComplaint() {
    if (formKey.currentState!.validate()) {
      Get.defaultDialog(
        title: 'complaint sent successfully',
        middleText: 'thanks for your connect',
        onConfirm: () {
          Get.back();
        },
        textConfirm: 'ok',
      );
    }
  }
}
