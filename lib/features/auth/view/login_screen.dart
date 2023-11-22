import 'package:edtech_flutter/config/app_text_style.dart';
import 'package:edtech_flutter/features/auth/provider/auth_provider.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);

    String email = '';
    String password = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: AppTextStyle.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: AppTextStyle.bodyTextSmall,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 16.0.h),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: AppTextStyle.bodyTextSmall,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(height: 24.0.h),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (email.isNotEmpty && password.isNotEmpty) {
                    // Call signInWithEmailAndPassword from AuthRepository
                    await authRepository.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Navigate to the dashboard upon successful login
                    Navigator.pushReplacementNamed(
                        context, AppRouter.dashboard);
                  } else {
                    // Handle empty email or password fields
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content:
                              const Text('Please enter email and password'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } catch (e) {
                  // Handle any potential authentication errors here
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text('$e'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login', style: AppTextStyle.buttonText),
            ),
            SizedBox(height: 16.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account? ',
                    style: AppTextStyle.bodyTextSmall),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouter.signup);
                  },
                  child: Text(
                    'Sign Up',
                    style: AppTextStyle.bodyTextSmall
                        .copyWith(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
