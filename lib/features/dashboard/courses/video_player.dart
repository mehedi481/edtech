import 'package:chewie/chewie.dart';
import 'package:edtech_flutter/features/dashboard/courses/logic/courses_providers.dart';
import 'package:edtech_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends ConsumerStatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool hasShownPrompt = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoUrl);
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.videoUrl != oldWidget.videoUrl) {
      _disposeVideoPlayer();
      _initializeVideoPlayer(widget.videoUrl);
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {
            _videoPlayerController.addListener(() {
              if (_videoPlayerController.value.position ==
                  _videoPlayerController.value.duration) {
                if (ref.watch(videoSelectionProvider.notifier).isLastVideo()) {
                  if (!hasShownPrompt) {
                    Utils().showCertificateClaimPrompt(context);
                    hasShownPrompt = true;
                  }
                }
              }
              if (_videoPlayerController.value.isPlaying) {
                ref
                    .watch(visibilityBookMarkProvider.notifier)
                    .makeInvisibleAfterDelay();
              }
            });
            setState(() {});
          });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
    );
  }

  void _disposeVideoPlayer() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_videoPlayerController.value.isInitialized) {
      return Chewie(
        controller: _chewieController,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
