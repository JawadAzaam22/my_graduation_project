import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/on%20Site%20training/view_onsite_training_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/Live tranning/learning_objectives.dart';
import '../widgets/back_button.dart';
import '../widgets/Live tranning/course_card.dart';
import '../widgets/Live tranning/user_profile_card.dart';

class ViewOnsiteTrainingScreen extends GetView<ViewOnsiteTrainingController> {
  const ViewOnsiteTrainingScreen({super.key});
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
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ));
          }

          if (controller.isFailed.value ||
              controller.onSiteTraining.value == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomBackButton(),
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

          final training = controller.onSiteTraining.value!;
          final provider = training.provider!;
          final tags = training.tags?.map((e) => e.name ?? '').toList() ?? [];
          final objectives = training.keyLearningObjectives
                  ?.map((e) => e.text ?? '')
                  .toList() ??
              [];

          return Column(
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CourseCard(
                        title: training?.title ?? '',
                        tags: tags,
                        language:
                            controller.getLanguage(training.language) ?? '',
                        rating: training.rate?.toDouble() ?? 0.0,
                        studentsRatting:
                            training.numberOfRates?.toString() ?? '0',
                        price: training.price!,
                        imageUrl: training.cover ?? '',
                        type: training.type!,
                        site: training.training_site!,
                      ),
                      SizedBox(height: 15.h),
                      UserProfileCard(
                        id: provider.id ?? 1,
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
                                      '${training.about ?? ""}',
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
            ],
          );
        }),
      ),
    );
  }
}
