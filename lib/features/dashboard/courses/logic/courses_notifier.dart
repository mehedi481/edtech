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

class VisibilityBookMarkNotifier extends StateNotifier<bool> {
  VisibilityBookMarkNotifier() : super(true);

  Future<void> makeInvisibleAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    state = false;
  }

  void hide() {
    state = false;
  }
}
