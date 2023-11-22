import 'package:edtech_flutter/config/app_text_style.dart';
import 'package:edtech_flutter/features/dashboard/courses/logic/courses_providers.dart';
import 'package:edtech_flutter/features/dashboard/courses/models/course_model.dart';
import 'package:edtech_flutter/utils/extensions.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courses",
          style: AppTextStyle.title,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.r),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.9.h,
          children: List.generate(
            courseList.length,
            (index) => CourseCard(
              course: courseList[index],
              onTap: () {
                ref.watch(totalVideoLength.notifier).state =
                    courseList[index].urls.length;

                context.nav.pushNamed(
                  AppRouter.courseDetails,
                  arguments: courseList[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final CourseListModel course;
  final Function? onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              course.image,
              fit: BoxFit.cover,
              height: 122.h,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        course.description,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: Colors.yellow[700], size: 16.sp),
                        Text(course.rating, style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Text(
                        'enrolled',
                        style: AppTextStyle.bodyTextSmall.copyWith(
                          fontSize: 10.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => onTap?.call(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(60.w, 30.h),
                        backgroundColor: Colors.purple[100],
                        foregroundColor: Colors.blue,
                      ),
                      child: Text(
                        "Continue",
                        style: AppTextStyle.bodyTextSmall.copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
