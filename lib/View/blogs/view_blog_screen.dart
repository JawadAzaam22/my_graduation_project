import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Controller/blogs/v_read_controller.dart';
import '../../l10n/app_localizations.dart';
import 'package:german_board/Controller/blogs/view_blog_controller.dart';

import '../widgets/back_button.dart';

class ViewBlogScreen extends GetView<ViewBlogController> {
  const ViewBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ttsController = Get.put(TtsController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Center(
          widthFactor: 10.w,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 39.sp,
              width: 39.sp,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF444444)
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1.w,
                ),
              ),
              child: Center(
                child: InkWell(
                    onTap: () {
                      Get.back();
                      ttsController.pauseF();
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined,
                        color: Theme.of(context).iconTheme.color)),
              ),
            ),
          )
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
        final blog = controller.blog.value;
        if (blog == null) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.noDataFound,
              style: TextStyle(fontSize: 16.sp),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  blog.imageUrl.isNotEmpty
                      ? blog.imageUrl
                      : 'https://via.placeholder.com/400x200',
                  height: 170.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 170.h,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image,
                        size: 50, color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  if (blog.categories.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        blog.categories.first,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF23255B),
                        ),
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Text(
                    blog.date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFA0A3BD),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '·',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFA0A3BD),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.remove_red_eye,
                      size: 14, color: const Color(0xFFA0A3BD)),
                  const SizedBox(width: 2),
                  Text(
                    blog.views.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFA0A3BD),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                blog.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  height: 1.3.h,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 10.r,
                          backgroundImage: blog.avatarUrl.isNotEmpty
                              ? NetworkImage(blog.avatarUrl)
                              : null,
                          child: blog.avatarUrl.isEmpty
                              ? Icon(Icons.person, size: 14)
                              : null,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          " ${AppLocalizations.of(context)!.by} ${blog.author}",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF23255B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.surround_sound_outlined,
                              color: Color(0xFF23255B)),
                          onPressed: () {
                            ttsController.speak( blog.content);
                          },
                          splashRadius: 22.r,
                        ),
                        ttsController.click.value && !ttsController.pause.value
                            ? IconButton(
                                icon: const Icon(Icons.pause,
                                    color: Color(0xFF23255B)),
                                onPressed: () {
                                  ttsController.pauseF();
                                },
                                splashRadius: 22.r,
                              )
                            : SizedBox(),
                        ttsController.click.value && !ttsController.pause.value
                            ? IconButton(
                                icon: const Icon(Icons.stop_circle_outlined,
                                    color: Color(0xFF23255B)),
                                onPressed: () {
                                  ttsController.stop();
                                },
                                splashRadius: 22.r,
                              )
                            : SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 14.h),
              Text(
                blog.content,
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 1.6.h,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
