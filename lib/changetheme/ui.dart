import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:german_board/changetheme/controllet.dart';
import 'package:get/get.dart';

import '../Services/stripe_services.dart';

class ChangeTheme extends GetView<change> {
   ChangeTheme({super.key});

    @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
      child: Obx(() => Card(
            child: SwitchListTile(
              title: const Text("Change Theme"),
              secondary: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      controller.isDarkMode.value ? Colors.white : Colors.black,
                ),
                child: Icon(
                  controller.isDarkMode.value
                      ? Icons.nightlight_round
                      : Icons.wb_sunny_rounded,
                  color:
                      controller.isDarkMode.value ? Colors.black : Colors.white,
                ),
              ),
              value: controller.isDarkMode.value,
              onChanged: (bool value) {
                controller.isDarkMode.value = value;

                if (value) {
                  AdaptiveTheme.of(context).setDark();
                } else {
                  AdaptiveTheme.of(context).setLight();
                }
              },
            ),
          )),
    ));
  }
}
