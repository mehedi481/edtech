import 'package:edtech_flutter/features/dashboard/courses/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookMarkNotifier extends StateNotifier<List<Videos>> {
  BookMarkNotifier() : super([]);

  void addBookMark(Videos video) {
    state = [...state, video];
  }

  void removeBookMark(Videos video) {
    state = state.where((element) => element != video).toList();
  }

  bool isBookMarked(Videos video) {
    return state.contains(video);
  }
}
