import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:german_board/Controller/home_controller.dart';
import 'package:get/get.dart';

class ListPlogs extends GetWidget<HomeController> {
  const ListPlogs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 121.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.blogs.length,
            itemBuilder: (context, index) {
              final blog = controller.blogs[index];
              return Container(
                width: 230.w,
                // height: 121.h,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: GestureDetector(
                    onTap: () {
                      controller.navToViewBlog(blog.id);
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.horizontal(
                              left: Directionality.of(context) ==
                                      TextDirection.rtl
                                  ? Radius.zero
                                  : const Radius.circular(10),
                              right: Directionality.of(context) ==
                                      TextDirection.rtl
                                  ? const Radius.circular(10)
                                  : Radius.zero,
                            ),
                            child: Image.network(
                              blog.imageUrl,
                              width: 100,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(Icons.error_outline,
                                        color: Colors.red),
                                  ),
                                );
                              },
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                blog.author,
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w300),
                              ),
                              // SizedBox(height: 4.h),
                              Text(
                                blog.title,
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              //  SizedBox(height: 4.h),
                              Text(
                                blog.content,
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w400),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 15.w,
              );
            },
          ),
        ));
  }
}
