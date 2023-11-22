import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoSelectionNotifier extends StateNotifier<int> {
  final int totalVideos;
  VideoSelectionNotifier(this.totalVideos) : super(0);

  void selectVideo(int index) {
    state = index;
  }

  void nextVideo() {
    if (state < totalVideos - 1) {
      state++;
    }
  }

  void previousVideo() {
    if (state > 0) {
      state--;
    }
  }

  bool isLastVideo() {
    return state == totalVideos - 1;
  }
}
