import 'package:flutter/material.dart';
import 'features/onboarding_screen.dart';

class DuckBuddyApp extends StatelessWidget {
  const DuckBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}
