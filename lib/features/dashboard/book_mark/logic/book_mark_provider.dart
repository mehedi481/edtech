import 'package:edtech_flutter/features/dashboard/book_mark/logic/book_mark_notifier.dart';
import 'package:edtech_flutter/features/dashboard/courses/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookMarkedListProvider =
    StateNotifierProvider<BookMarkNotifier, List<Videos>>((ref) {
  return BookMarkNotifier();
});
