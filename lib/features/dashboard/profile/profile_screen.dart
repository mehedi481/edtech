import 'package:edtech_flutter/features/auth/provider/auth_provider.dart';
import 'package:edtech_flutter/features/dashboard/provider/core_provider.dart';
import 'package:edtech_flutter/utils/extensions.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await authRepository.signOut();
            ref.watch(authStateProvider).whenData((user) {
              if (user == null) {
                context.nav
                    .pushNamedAndRemoveUntil(AppRouter.login, (route) => false);
                ref.watch(selectedIndexProvider.notifier).state = 0;
              }
            });
          },
          child: Text("Logout"),
        ),
      ),
    );
  }
}
