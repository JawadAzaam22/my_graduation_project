import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Controller/profile/search_certificate_controller.dart';
import '../../l10n/app_localizations.dart';

class SearchCertificateScreen extends GetView<SearchCertificateController> {
  SearchCertificateScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    controller.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.certificates,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: _searchController,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: isDark ? Colors.white70 : Colors.black54),
                    hintText: AppLocalizations.of(context)!.enterCerID,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white54 : Colors.black45,
                    ),
                    filled: true,
                    fillColor: isDark ? Colors.grey.shade800 : Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color:
                              isDark ? Colors.white24 : Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  ),
                  onFieldSubmitted: (value) {
                    controller.searchCertificate(value.trim());
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Obx(() {
                if (controller.isLoading2.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (!controller.hasSearched.value) {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.searchForCer,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  );
                } else if (controller.certificateUrl.value.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r)),
                            shadowColor: Colors.indigo.withOpacity(0.3),
                            child: Container(
                              width: 330.w,
                              height: 250.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                gradient: LinearGradient(
                                  colors: isDark
                                      ? [
                                          Colors.indigo.shade700,
                                          Colors.indigo.shade900
                                        ]
                                      : [
                                          Colors.indigo.shade100,
                                          Colors.indigo.shade300
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.r),
                                    child: Image.network(
                                      controller.certificateUrl.value,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            controller.shareAssetImage(
                                                controller
                                                    .certificateUrl.value);
                                          },
                                          child: SvgPicture.asset(
                                              'assets/images/share.svg',
                                              fit: BoxFit.cover),
                                        ),
                                        SizedBox(width: 10.w),
                                        InkWell(
                                          onTap: () async {
                                            controller.saveToGallery();
                                          },
                                          child: SvgPicture.asset(
                                              'assets/images/load.svg',
                                              fit: BoxFit.cover),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                        Center(
                          child: Text(
                            '${AppLocalizations.of(context)!.dateOfCer}${controller.certificateDate.value}',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.messageWithCer,
                            style: GoogleFonts.poppins(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.noCertificate,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
