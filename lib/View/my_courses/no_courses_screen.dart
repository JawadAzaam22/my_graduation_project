import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../l10n/app_localizations.dart';

class NoCoursesScreen extends StatelessWidget {
  const NoCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(27),
          child: Column(
            children: [
              SvgPicture.asset(
                "assets/images/myCoursesPhoto.svg",
                height: 330.h,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Text(AppLocalizations.of(context)!.noCourses,
                  style: GoogleFonts.roboto(
                      fontSize: 19.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color)),
              const SizedBox(
                height: 10,
              ),
              Text(AppLocalizations.of(context)!.noCoursesSentence,
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color)),
              Text(AppLocalizations.of(context)!.noCoursesSentence1,
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color)),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
