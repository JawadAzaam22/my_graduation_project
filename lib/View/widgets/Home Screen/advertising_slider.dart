import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> sliderImages = [
  "https://www.shutterstock.com/shutterstock/photos/1364078036/display_1500/stock-vector-human-hand-touching-on-a-book-low-poly-wireframe-online-education-blue-background-or-concept-with-1364078036.jpg", // الصورة الأولى
  "https://static.vecteezy.com/system/resources/previews/016/086/472/non_2x/education-banners-e-learning-school-activities-white-line-design-style-on-blue-vector.jpg", // الصورة الثانية
  "https://static.vecteezy.com/system/resources/previews/021/643/286/non_2x/computer-programming-horizontal-banner-technology-background-design-set-of-banners-with-blue-background-vector.jpg", // الصورة الثالثة
];

Widget AdvertisingSlider({required GlobalKey g}) {
  return SizedBox(
    height: 220.h,
    width: double.infinity,
    child: CarouselSlider.builder(
      key: g,
      unlimitedMode: true,
      slideBuilder: (index) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    sliderImages[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.blueAccent));
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image,
                          color: Colors.grey, size: 50),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      slideTransform: const CubeTransform(),
      slideIndicator: CircularSlideIndicator(
        currentIndicatorColor: Colors.white,
        indicatorBackgroundColor: Colors.transparent,
        indicatorBorderColor: Colors.white,
        indicatorBorderWidth: 1.5,
        indicatorRadius: 4,
        itemSpacing: 13.w,
        padding: const EdgeInsets.only(bottom: 15),
      ),
      itemCount: sliderImages.length,
    ),
  );
}
