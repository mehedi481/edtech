import 'package:edtech_flutter/config/app_text_style.dart';
import 'package:edtech_flutter/features/auth/provider/auth_provider.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.read(authRepositoryProvider);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: AppTextStyle.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: AppTextStyle.bodyTextSmall,
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0.h),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: AppTextStyle.bodyTextSmall,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0.h),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: AppTextStyle.bodyTextSmall,
                border: const OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24.0.h),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (name.isNotEmpty &&
                    email.isNotEmpty &&
                    password.isNotEmpty) {
                  try {
                    // Call createUserWithEmailAndPassword from AuthRepository
                    await authRepository.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    // Navigate to the dashboard or next screen upon successful sign-up
                    Navigator.pushReplacementNamed(
                        context, AppRouter.dashboard);
                  } catch (e) {
                    // Handle any potential authentication errors here
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('$e'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Handle empty fields
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill in all fields'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Sign Up', style: AppTextStyle.buttonText),
            ),
            SizedBox(height: 16.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ',
                    style: AppTextStyle.bodyTextSmall),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, AppRouter.login);
                  },
                  child: Text('Login', style: AppTextStyle.bodyTextSmall),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
