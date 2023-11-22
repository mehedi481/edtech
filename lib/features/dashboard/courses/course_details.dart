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

// class _CourseDetailsState extends ConsumerState<CourseDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Course Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Consumer(builder: (context, ref, __) {
//               final url = ref.watch(videoUrl);
//               return AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: VideoPlayerWidget(
//                   videoUrl: url ?? widget.course.urls.first.url,
//                 ), // Pass the video URL here
//               );
//             }),
//             // List of Videos
//             ListView.builder(
//               shrinkWrap: true,
//               itemCount: widget.course.urls.length,
//               itemBuilder: (context, index) {
//                 final video = widget.course.urls[index];
//                 return ListTile(
//                   title: Text(video.title),
//                   onTap: () {
//                     ref.watch(videoUrl.notifier).state = video.url;
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _CourseDetailsState extends ConsumerState<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    final selectedVideoIndex = ref.watch(videoSelectionProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayerWidget(
                videoUrl: widget.course.urls[selectedVideoIndex].url,
              ),
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
