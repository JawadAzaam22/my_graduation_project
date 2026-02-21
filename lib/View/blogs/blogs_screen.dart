import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../Controller/blogs/blogs_controller.dart';
import '../../l10n/app_localizations.dart';


class BlogsScreen extends GetView<BlogsController> {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.blogs,

        ),
        centerTitle: false,
      ),
      body: LiquidPullToRefresh(
        onRefresh: controller.handleRefresh,
        color: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).primaryColor,
        showChildOpacityTransition: true,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

               SizedBox(
                 height: 20,
               ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Text(
                    AppLocalizations.of(context)!.recommended,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                ),

                SizedBox(
                  height: 220.h,
                  child: Obx(() => ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(left: 16, top: 8, right: 0),
                    children: controller.recommendedBlogs.map((blog) {
                      return InkWell(
                        onTap: () {
                          controller.navToViewBlog(blog.id);
                        },
                        child: _buildRecommendedCard(
                          imageUrl: blog.imageUrl,
                          category: blog.categories.isNotEmpty ? blog.categories.first : '',
                          title: blog.title,
                          author: blog.author,
                          date: blog.date,
                          views: blog.views.toString(),
                          avatarUrl: blog.avatarUrl,
                          context: context,
                        ),
                      );
                    }).toList(),
                  )),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    height: 36.h,
                    child: Obx(() => ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: controller.filters.map((filter) {
                        return GestureDetector(
                          onTap: () => controller.selectFilter(filter),
                          child: _buildFilterChip(
                            filter,
                            selected: controller.selectedFilter.value == filter,
                          ),
                        );
                      }).toList(),
                    )),
                  ),
                ),

                Obx(() => ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  children: controller.filteredBlogs.map((blog) {
                    return InkWell(
                      onTap: () {
                        controller.navToViewBlog(blog.id);
                      },
                      child: _buildBlogListTile(
                        imageUrl: blog.imageUrl,
                        category: blog.categories.isNotEmpty ? blog.categories.first : '',
                        title: blog.title,
                        date: blog.date,
                        views: blog.views.toString(),
                        context: context,
                      ),
                    );
                  }).toList(),
                )),
                SizedBox(height: 24.h),
              ],
            ),
          ],
        ),
      ),
    );
  }


  static Widget _buildRecommendedCard({
    required String imageUrl,
    required String category,
    required String title,
    required String author,
    required String date,
    required String views,
    required String avatarUrl,
    required BuildContext context,
  }) {
    return Container(
      width: 260.h,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  imageUrl,
                  height: 120.h,
                  width: 260.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF23255B),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: Colors.black,
                height: 1.2.h,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10.r,
                  backgroundImage: avatarUrl.isNotEmpty
                      ? NetworkImage(avatarUrl)
                      : null,
                  child: avatarUrl.isEmpty ? Icon(Icons.person, size: 14) : null,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.by + " " + author,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Color(0xFF23255B),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(Icons.remove_red_eye, size: 14),
                const SizedBox(width: 2),
                Text(
                  views,
                  style: TextStyle(
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }


  static Widget _buildFilterChip(String label, {bool selected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF23255B) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: selected
              ? null
              : Border.all(
            color: const Color(0xFFD9DBE9),
            width: 1.2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF23255B),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }


  static Widget _buildBlogListTile({
    required String imageUrl,
    required String category,
    required String title,
    required String date,
    required String views,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: 113.w,
              height: 93.h,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.error_outline, color: Colors.red),
                );
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF23255B),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFFA0A3BD),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '·',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFFA0A3BD),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      views + " " + AppLocalizations.of(context)!.views,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xFFA0A3BD),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    height: 1.2.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
