import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/Live%20training/view_live_training_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Services/stripe_services.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Live tranning/learning_objectives.dart';
import '../widgets/back_button.dart';
import '../widgets/button.dart';
import '../widgets/Live tranning/course_card.dart';
import '../widgets/Live tranning/user_profile_card.dart';

class ViewLiveTrainingScreen extends GetView<ViewLiveTrainingController> {
  const ViewLiveTrainingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: const CustomBackButton(),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 20),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }

          if (controller.isFailed.value ||
              controller.liveTraining.value == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Icon(Icons.error_outline,
                        size: 80.sp, color: Colors.red)),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "Failed to load training data.",
                    style: GoogleFonts.roboto(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
              ],
            );
          }

          final training = controller.liveTraining.value!;
          final provider = training.provider!;
          final tags = training.tags?.map((e) => e.name ?? '').toList() ?? [];
          final objectives = training.keyLearningObjectives
                  ?.map((e) => e.text ?? '')
                  .toList() ??
              [];

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseCard(
                        startDate: training.start_date ?? '',
                        endDate: training.end_date ?? '',
                        duration: training.duration_in_hours ?? 0,
                        type: training.type ?? '',
                        title: training.title ?? '',
                        tags: tags,
                        language:
                            controller.getLanguage(training.language) ?? '',
                        rating: training.rate?.toDouble() ?? 0.0,
                        studentsRatting:
                            training.numberOfRates?.toString() ?? '0',
                        price: training.price ?? '0.0',
                        imageUrl: training.cover ?? '',
                      ),
                      SizedBox(height: 15.h),
                      UserProfileCard(
                        id: provider.id!,
                        name: provider.firstName ?? '',
                        role: provider.specializedAt ?? '',
                        isOnline: true,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        AppLocalizations.of(context)!.trainingDescription,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Obx(() {
                        final text = training.about ?? "";
                        final textStyle = GoogleFonts.openSans(
                          fontSize: 10.sp,
                          height: 1.5.h,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        );

                        final textPainter = TextPainter(
                          text: TextSpan(text: text, style: textStyle),
                          maxLines: 3,
                          textDirection: TextDirection.ltr,
                        )..layout(
                            maxWidth: MediaQuery.of(context).size.width - 40);

                        controller.isShortText.value =
                            textPainter.didExceedMaxLines == false;

                        return (controller.isShortText.value == true)
                            ? Text(text, style: textStyle)
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedSize(
                                    duration: Duration(milliseconds: 300),
                                    child: Text(
                                      training.about ?? "",
                                      maxLines:
                                          controller.isExpanded.value ? 20 : 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.toggleDescription(),
                                    child: Text(
                                      controller.isExpanded.value
                                          ? AppLocalizations.of(context)!
                                              .readLess
                                          : AppLocalizations.of(context)!
                                              .readMore,
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      }),
                      SizedBox(height: 30.h),
                      LearningObjectives(objectives: objectives),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              ///////need edit
              Obx(() => controller.enrolled.value
                  ? Button(
                      color: Theme.of(context).primaryColor,
                      content: AppLocalizations.of(context)!.view,
                      function: () {
                        controller.navToViewCourse(
                            training.type!, training.id!);
                      },
                    )
                  : StripeService.instance.isLoadingToPay.value
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ))
                      : Button(
                          color: Theme.of(context).primaryColor,
                          content:
                              "${AppLocalizations.of(context)!.enroll} ${training.price ?? ""}\$ ",
                          function: () {
                            StripeService.instance.makePayment(training.id!,
                                training.price!, context, training.type!);
                          },
                        )),
            ],
          );
        }),
      ),
    );
  }
}
