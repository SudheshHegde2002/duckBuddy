import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final bool isLast;
  final bool isTicked;
  final ValueChanged<bool> onTickChanged;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isLast,
    required this.isTicked,
    required this.onTickChanged,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 280,
          child: Lottie.asset(data.anim), 
        ),

        const SizedBox(height: 30),

        Text(
          data.title, 
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 12),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            data.desc, 
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),

            if (isLast)
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: IconButton(
                iconSize: 50,
                icon: Icon(
                    isTicked
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: Colors.black,
                ),
                onPressed: () {
                    onTickChanged(!isTicked);
                },
                ),
            ),

                ],
    );
  }
}
