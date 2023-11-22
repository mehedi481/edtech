import 'package:edtech_flutter/features/dashboard/courses/logic/courses_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoUrl = StateProvider<String?>((ref) => null);

final totalVideoLength = StateProvider<int>((ref) => 0);

final videoSelectionProvider =
    StateNotifierProvider.autoDispose<VideoSelectionNotifier, int>((ref) {
  return VideoSelectionNotifier(ref.watch(totalVideoLength));
});
