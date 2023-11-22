import 'package:edtech_flutter/features/auth/provider/auth_provider.dart';
import 'package:edtech_flutter/features/auth/view/login_screen.dart';
import 'package:edtech_flutter/features/dashboard/dashboard_screen.dart';
import 'package:edtech_flutter/firebase_options.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        designSize: const Size(390, 844), // XD Design Size For Pixel perfect
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'EdTech Flutter',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // initialRoute: AppRouter.login,
            home: const AuthChecker(),
            onGenerateRoute: (settings) => generatedRoutes(settings),
          );
        });
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
        data: (user) {
          if (user != null) {
            return DashBoardScreen();
          } else {
            return const LoginScreen();
          }
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, trace) => const LoginScreen());
  }
}
