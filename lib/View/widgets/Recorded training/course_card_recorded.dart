import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../l10n/app_localizations.dart';

class CourseCardRecorded extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String language;
  final double rating;
  final String studentsRatting;
  final int totalStudents;
  final double price;
  final String? imageUrl;

  CourseCardRecorded({
    super.key,
    required this.title,
    required this.tags,
    required this.language,
    required this.rating,
    required this.studentsRatting,
    required this.totalStudents,
    required this.price,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Text(
                '$rating',
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 8.w),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 10.sp,
                unratedColor: Colors.grey.shade300,
              ),
              SizedBox(width: 16.w),
              Text(
                "($studentsRatting)",
                style: GoogleFonts.roboto(
                  fontSize: 8.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Wrap(
            spacing: 8.w,
            children: tags.asMap().entries.map((entry) {
              final index = entry.key;
              final tag = entry.value;
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 6.h,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: _getColorByOrder(index),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.poppins(
                    fontSize: 10.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 5.h),
          Text(
            _formatPrice(price),
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            width: 361.w,
            height: 204.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/live.jpg',
                    fit: BoxFit.cover,
                    width: 361.w,
                    height: 204.h,
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: (Directionality.of(context) == TextDirection.ltr)
                      ? 9.w
                      : null,
                  right: (Directionality.of(context) == TextDirection.rtl)
                      ? 9.w
                      : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.video_camera_back_outlined,
                          color: Colors.blue,
                          size: 12.sp,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          AppLocalizations.of(context)!.recordedTraining,
                          style: GoogleFonts.nunitoSans(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$totalStudents ${AppLocalizations.of(context)!.studentbought}',
                style: GoogleFonts.inter(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }

  Color _getColorByOrder(int index) {
    return _colorPalette[index % _colorPalette.length];
  }

  final List<Color> _colorPalette = [
    Colors.teal.shade200,
    Colors.deepPurple.shade400,
    Colors.blueAccent,
    Colors.grey,
  ];
  // Color _getTagColor(String tag) {
  //   switch (tag.toLowerCase()) {
  //     case 'software':
  //       return Colors.teal.shade200;
  //     case 'design':
  //       return Colors.deepPurple.shade400;
  //     case 'web':
  //       return Colors.blueAccent;
  //     default:
  //       return Colors.grey;
  //   }
  // }
// تحويل
  String _formatPrice(double price) {
    return '\$${price.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }
}
