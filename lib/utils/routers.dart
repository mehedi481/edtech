import 'package:edtech_flutter/features/auth/view/login_screen.dart';
import 'package:edtech_flutter/features/auth/view/signup_screen.dart';
import 'package:edtech_flutter/features/dashboard/book_mark/book_mark_screen.dart';
import 'package:edtech_flutter/features/dashboard/courses/course_details.dart';
import 'package:edtech_flutter/features/dashboard/courses/courses_screen.dart';
import 'package:edtech_flutter/features/dashboard/courses/models/course_model.dart';
import 'package:edtech_flutter/features/dashboard/dashboard_screen.dart';
import 'package:edtech_flutter/features/dashboard/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  AppRouter._();
  static const String login = '/login';
  static const String signup = '/signup';
  static const String dashboard = '/dashboard';
  static const String courses = '/courses';
  static const String bookmark = '/bookmark';
  static const String profile = '/profile';
  static const String courseDetails = '/course-details';
}

Route generatedRoutes(RouteSettings settings) {
  Widget child;

  switch (settings.name) {
    case AppRouter.login:
      child = const LoginScreen();
      break;
    case AppRouter.signup:
      child = const SignUpScreen();
      break;
    case AppRouter.dashboard:
      child = DashBoardScreen();
      break;
    case AppRouter.courses:
      child = const CoursesScreen();
      break;
    case AppRouter.bookmark:
      child = const BookmarkScreen();
      break;
    case AppRouter.profile:
      child = const ProfileScreen();
      break;
    case AppRouter.courseDetails:
      child = CourseDetails(
        course: settings.arguments as CourseListModel,
      );
      break;
    default:
      throw Exception('Invalid route: ${settings.name}');
  }

  // return PageTransition(child: child, type: PageTransitionType.fade);
  return MaterialPageRoute(settings: settings, builder: (context) => child);
  // return PageTransition(
  //   child: child,
  //   type: PageTransitionType.fade,
  //   settings: settings,
  // );
}
