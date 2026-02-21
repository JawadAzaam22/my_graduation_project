import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../l10n/app_localizations.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final List<String> tags;
  final String language;
  final double rating;
  final String studentsRatting;
  final String price;
  final String type;
  final String site;
  final String? imageUrl;
  final String? startDate;
  final String? endDate;
  final int? duration;

  CourseCard({
    super.key,
    required this.title,
    required this.tags,
    required this.language,
    required this.rating,
    required this.studentsRatting,
    required this.price,
    required this.type,
    this.startDate,
    this.endDate,
    this.duration,
    this.imageUrl,
    this.site = "default",
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
              fontSize: 22.sp,
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
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 8.w),
              RatingBarIndicator(
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 10.sp,
                unratedColor: Colors.grey.shade300,
              ),
              SizedBox(width: 16.w),
              Text(
                "(${studentsRatting})",
                style: GoogleFonts.roboto(
                  fontSize: 8.sp,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.language,
                size: 15.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                '$language',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          type == "live"
              ? Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '$startDate',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      '$endDate',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: 5.h),
          type == "live"
              ? Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 15.sp,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '$duration',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.attach_money,
                size: 18.sp,
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                _formatPrice(price),
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
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
          site == "default"
              ? SizedBox(height: 15.h)
              : Column(
                  children: [
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 20.sp,
                        ),
                        Text(
                          site,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
          Center(
            child: Container(
              width: 361.w,
              height: 204.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        width: 361.w,
                        height: 204.h,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.error_outline, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.h,
                    left: (Directionality.of(context) == TextDirection.ltr)
                        ? 16.w
                        : null,
                    right: (Directionality.of(context) == TextDirection.rtl)
                        ? 16.w
                        : null,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wifi_tethering,
                            color: Colors.blue,
                            size: 12.sp,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          type == "live"
                              ? Text(
                                  AppLocalizations.of(context)!.liveTrainning,
                                  style: GoogleFonts.nunitoSans(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : type == "recorded"
                                  ? Text(
                                      AppLocalizations.of(context)!
                                          .recordedTraining,
                                      style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)!
                                          .onSiteTraining,
                                      style: GoogleFonts.nunitoSans(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
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

  String _formatPrice(String price) {
    return price.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
