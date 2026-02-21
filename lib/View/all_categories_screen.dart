import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/back_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/color_pallet.dart';
import '../Controller/all_categories_controller.dart';
import '../l10n/app_localizations.dart';


class AllCategoriesScreen extends GetView<AllCategoriesController> {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
        widthFactor: 10.w,
        child: CustomBackButton(),),
        title: Text( AppLocalizations.of(context)!.allCategories),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child:
            SizedBox(
              height: 50.h,
              child: TextFormField(
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: isDark ? Colors.white70 : Colors.black54),
                  hintText:   AppLocalizations.of(context)!.search,
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),

                  filled: true,
                  fillColor: isDark ? Colors.grey.shade600 : Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: isDark ? Colors.white24 : Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    //borderSide: BorderSide(color: Colors.indigo, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                ),
                onChanged: controller.updateSearch,

              ),
            ),


            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search category...',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            //   ),
            //   onChanged: controller.updateSearch,
            // ),
          ),
          Expanded(
            child:
            Obx(() {
              final filtered = controller.filteredCategories;
              return
                controller.isLoading?Center(child:
                CircularProgressIndicator(color:Theme.of(context).primaryColor)):

                ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final category = filtered[index];
                  return Column(
                    children: [
                      InkWell(onTap:(){
                        controller.getCoursesOfCategory(category.id!);
                      },
                        child: Container(
                          height: 59.h,

                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Color(0xFF444444)
                                : Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 0.1.w,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    category.name!,
                                    maxLines: 2,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,

                                    style: GoogleFonts.roboto(
                                      color: Theme.of(context).textTheme.bodyMedium!.color,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                  "${category.number_of_courses!} ${ AppLocalizations.of(context)!.course}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.abc_sharp, size: 35,
                                  color:Theme.of(context).brightness == Brightness.dark?Colors.white: color6),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h,)
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
