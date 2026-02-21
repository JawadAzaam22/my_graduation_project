import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/recorded_training/quiz_controller.dart';
import '../../Models/recorded/Quiz_Model.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/button.dart';

class QuizScreen extends GetView<QuizController> {
  const QuizScreen({Key? key}) : super(key: key);

  Color _getOptionColor(BuildContext context, Answers option) {
    if (!controller.isAnswered.value) {
      return option.isSelected
          ? (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF444444)
              : const Color(0xffF4F3F6))
          : (Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF444444)
              : const Color(0xffF4F3F6));
    }

    if (option.isSelected) {
      return option.isCorrect == true ? Colors.green : Colors.red;
    }

    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF444444)
        : const Color(0xffF4F3F6);
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }

          if (controller.questions.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noQuestion,
                style: GoogleFonts.roboto(fontSize: 18.sp),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  controller.quizTitle,
                  style: GoogleFonts.roboto(
                      fontSize: 20.sp, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: controller.questions.isNotEmpty
                            ? controller.correctAnswers.value /
                                controller.questions.length
                            : 0,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.green),
                        minHeight: 12.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${controller.questionIndex.value + 1}/${controller.questions.length}',
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              Text(
                controller.questions[controller.questionIndex.value]
                        .questionText ??
                    '',
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(height: 30.h),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.options.length,
                  itemBuilder: (context, index) {
                    final option = controller.options[index];
                    return Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 60.h,
                          child: InkWell(
                            onTap: () {
                              if (!controller.isAnswered.value &&
                                  !controller.isLoading.value) {
                                controller.selectChoice(option.id!);
                              }
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                color: _getOptionColor(context, option),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: option.isSelected &&
                                          !controller.isAnswered.value
                                      ? Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black
                                      : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: const Color(0xffEDE8E3),
                                    radius: 18.r,
                                    child: controller.isAnswered.value &&
                                            option.isSelected
                                        ? (option.isCorrect == true
                                            ? const Icon(Icons.check,
                                                color: Colors.green)
                                            : const Icon(Icons.close,
                                                color: Colors.red))
                                        : Text(
                                            String.fromCharCode(65 + index),
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                            ),
                                          ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      option.answerText ?? '',
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18.sp,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                      ],
                    );
                  },
                ),
              ),
              Obx(() {
                final isAnswered = controller.isAnswered.value;
                final isLoading = controller.isLoading2.value;
                return Button(
                  color: (isAnswered || isLoading) ? Colors.grey : Colors.green,
                  content: isLoading
                      ? AppLocalizations.of(context)!.loading
                      : AppLocalizations.of(context)!.continu,
                  function: (isAnswered || isLoading)
                      ? () {}
                      : () => controller.checkAnswer(),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
