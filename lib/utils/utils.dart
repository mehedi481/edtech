import 'package:edtech_flutter/utils/extensions.dart';
import 'package:edtech_flutter/utils/routers.dart';
import 'package:flutter/material.dart';

class Utils {
  void showCertificateClaimPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text(
              'You have completed the course. Claim your Certificate now!'),
          actions: [
            TextButton(
              onPressed: () {
                context.nav.pushNamedAndRemoveUntil(
                    AppRouter.dashboard, (route) => false);
              },
              child: const Text('Claim Certificate'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
