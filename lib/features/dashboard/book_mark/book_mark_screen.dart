import 'package:edtech_flutter/config/app_text_style.dart';
import 'package:edtech_flutter/features/dashboard/book_mark/logic/book_mark_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookMarkedList = ref.watch(bookMarkedListProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked', style: AppTextStyle.title),
      ),
      body: bookMarkedList.isEmpty
          ? const Center(
              child: Text('No Bookmarked Videos'),
            )
          : ListView.builder(
              itemCount: bookMarkedList.length,
              itemBuilder: (context, index) {
                final video = bookMarkedList[index];
                return ListTile(
                  title: Text(video.title),
                  trailing: IconButton(
                    onPressed: () {
                      ref
                          .read(bookMarkedListProvider.notifier)
                          .removeBookMark(video);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            ),
    );
  }
}
