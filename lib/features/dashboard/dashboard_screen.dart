import 'package:edtech_flutter/features/dashboard/book_mark/book_mark_screen.dart';
import 'package:edtech_flutter/features/dashboard/courses/courses_screen.dart';
import 'package:edtech_flutter/features/dashboard/profile/profile_screen.dart';
import 'package:edtech_flutter/features/dashboard/provider/core_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DashBoardScreen extends ConsumerWidget {
  DashBoardScreen({
    super.key,
  });

  final List<Widget> _screens = const [
    CoursesScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: IndexedStack(
        index: ref.watch(selectedIndexProvider),
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: ref.watch(selectedIndexProvider),
        onDestinationSelected: (index) => ref.watch(selectedIndexProvider.notifier).state = index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_stories_outlined),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_add),
            label: 'Bookmark',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
