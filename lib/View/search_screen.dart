import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/View/widgets/back_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controller/search_controller.dart';
import '../l10n/app_localizations.dart';

class SearchScreen extends GetView<SearchAController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: CustomBackButton(),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchBox(context),
              SizedBox(height: 16.h),
              if (controller.recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.recentSearch,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        )),
                    TextButton(
                      onPressed: controller.clearAllRecent,
                      child: Text(
                        AppLocalizations.of(context)!.clearAll,
                        style: GoogleFonts.roboto(
                            fontSize: 12.sp, color: Colors.red),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 8,
                  children: controller.recentSearches.map((term) {
                    return Container(
                      height: 28.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () => controller.submitSearch(term),
                            child: Text(
                              term,
                              style: GoogleFonts.roboto(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          GestureDetector(
                            onTap: () => controller.removeRecentSearch(term),
                            child: Icon(Icons.close,
                                size: 18.sp, color: Colors.black54),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20.h),
              ],
              if (controller.articles.isNotEmpty ||
                  controller.providers.isNotEmpty ||
                  controller.courses.isNotEmpty) ...[
                if (controller.articles.isNotEmpty) ...[
                  Text(AppLocalizations.of(context)!.blogs,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 100.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.articles.length,
                      separatorBuilder: (_, __) => SizedBox(width: 15.w),
                      itemBuilder: (context, index) {
                        final a = controller.articles[index];
                        return InkWell(
                          onTap: () async {
                            await controller.saveRecentSearch(
                                controller.search.text.trim());
                            controller.navToViewBlog(a["id"]);
                          },
                          child: SizedBox(
                            width: 230.w,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(10)),
                                    child: Image.network(
                                      a["image"] ?? "",
                                      width: 100.w,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10.h),
                                        Text(a["author"] ?? "",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey[600])),
                                        Text(a["title"] ?? "",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                        Text(
                                          a["content"],
                                          style: TextStyle(
                                              fontSize: 8.sp,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w400),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
                if (controller.providers.isNotEmpty) ...[
                  Text(AppLocalizations.of(context)!.providers,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  SizedBox(height: 10.h),
                  Column(
                    children: controller.providers.map((p) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: (p["image"] != null &&
                                    p["image"].toString().isNotEmpty)
                                ? NetworkImage(p["image"])
                                : null,
                            child: (p["image"] == null ||
                                    p["image"].toString().isEmpty)
                                ? const Icon(Icons.person)
                                : null,
                          ),
                          title: Text(p["name"] ?? ""),
                          subtitle: Text(p["role"] ?? ""),
                          onTap: () async {
                            await controller.saveRecentSearch(
                                controller.search.text.trim());
                            Get.toNamed("/userprofiles", arguments: {
                              "id": p["id"],
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.h),
                ],
                if (controller.courses.isNotEmpty) ...[
                  Text(AppLocalizations.of(context)!.courses,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500, fontSize: 16.sp)),
                  SizedBox(height: 10.h),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.courses.length,
                    separatorBuilder: (c, i) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final cObj = controller.courses[index];
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            cObj["cover"] ?? "",
                            width: 60.w,
                            height: 60.h,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.error_outline),
                          ),
                          title: Text(cObj["name"] ?? ""),
                          subtitle: Text(
                            "${cObj["instructor"] ?? ""} • ${cObj["type"] ?? ""}",
                          ),
                          onTap: () async {
                            await controller.saveRecentSearch(
                                controller.search.text.trim());
                            controller.navToViewCourse(
                                cObj["type"], cObj["id"]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ],
            ],
          ),
        );
      }),
    );
  }

  Widget searchBox(BuildContext context) {
    return Obx(() {
      return CupertinoTextField(
        controller: controller.search,
        placeholder: AppLocalizations.of(context)!.search,
        prefix: const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Icon(Icons.search, color: Color(0xFFA0A3BD), size: 22),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0x26A0A3BD),
          borderRadius: BorderRadius.circular(12),
        ),
        style: TextStyle(fontSize: 15.sp),
        onChanged: controller.debouncedSearch,
        onSubmitted: controller.submitSearch,
        suffix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (controller.isLoading)
              const Padding(
                padding: EdgeInsets.only(right: 6),
                child: CupertinoActivityIndicator(),
              ),
            if (controller.search.text.isNotEmpty)
              IconButton(
                splashRadius: 18.r,
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.search.clear();
                  controller.debouncedSearch("");
                },
              ),
          ],
        ),
      );
    });
  }
}
