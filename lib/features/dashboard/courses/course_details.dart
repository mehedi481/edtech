import 'package:edtech_flutter/config/app_text_style.dart';
import 'package:edtech_flutter/features/dashboard/book_mark/logic/book_mark_provider.dart';
import 'package:edtech_flutter/features/dashboard/courses/logic/courses_providers.dart';
import 'package:edtech_flutter/features/dashboard/courses/models/course_model.dart';
import 'package:edtech_flutter/features/dashboard/courses/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetails extends ConsumerStatefulWidget {
  const CourseDetails({super.key, required this.course});
  final CourseListModel course;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends ConsumerState<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    final selectedVideoIndex = ref.watch(videoSelectionProvider);
    final isVisible = ref.watch(visibilityBookMarkProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayerWidget(
                    videoUrl: widget.course.urls[selectedVideoIndex].url,
                  ),
                ),
                isVisible
                    ? Positioned(
                        left: 10.h,
                        top: 10.w,
                        child: Row(
                          children: [
                            Text(
                              "Add to bookmarks",
                              style: AppTextStyle.bodyTextSmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (ref.watch(bookMarkedListProvider).contains(
                                    widget.course.urls[selectedVideoIndex])) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Already Bookmarked'),
                                      ),
                                    );
                                } else {
                                  ref
                                      .read(bookMarkedListProvider.notifier)
                                      .addBookMark(
                                        widget.course.urls[selectedVideoIndex],
                                      );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text('Video Bookmarked'),
                                      ),
                                    );
                                }
                                ref
                                    .read(visibilityBookMarkProvider.notifier)
                                    .hide();
                              },
                              icon: const Icon(
                                Icons.bookmark,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: 10.h),
            // Buttons to navigate to the next and previous videos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(videoSelectionProvider.notifier).previousVideo();
                  },
                  child: const Text('Previous Video'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(videoSelectionProvider.notifier).nextVideo();
                  },
                  child: const Text('Next Video'),
                ),
              ],
            ),
            // List of Videos
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.course.urls.length,
              itemBuilder: (context, index) {
                final video = widget.course.urls[index];
                return ListTile(
                  title: Text(video.title),
                  onTap: () {
                    ref
                        .read(videoSelectionProvider.notifier)
                        .selectVideo(index);

                    ref.invalidate(visibilityBookMarkProvider);
                  },
                  tileColor: index == selectedVideoIndex
                      ? Colors.blue.withOpacity(0.3)
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
