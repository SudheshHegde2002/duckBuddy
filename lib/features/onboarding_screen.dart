import 'package:flutter/material.dart';
import 'onboarding_page.dart';
import 'onboarding_model.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;
  bool _isTicked = false;


final pages = const [
  OnboardingPageData(
    title: "Duck the pressure. Keep it casual.",
    desc: "Duck (on duckBuddy): To intentionally avoid emotional pressure, long-term commitments, and relationship DRAMA",
    anim: "assets/animations/CANARD.json",
  ),
  OnboardingPageData(
    title: "Find your 'duck'Buddy",
    desc: "Swipe through profiles, find your vibe. duckBuddy (on duckBuddy): A person who helps you in ducking, as they are here for ducking too!",
    anim: "assets/animations/duck.json",
  ),
  OnboardingPageData(
    title: "18+, real users",
    desc: "Safe, verified, and controlled.",
    anim: "assets/animations/verification.json",
  ),
];


  @override
Widget build(BuildContext context) {
  return AnimatedContainer(
      duration: const Duration(milliseconds: 800), // slow smooth transition
      color: _index == pages.length - 1
      ? (_isTicked ? Colors.yellow : Colors.red)
      : Colors.yellow,
  curve: Curves.easeInOut,
  child: Scaffold(
     backgroundColor: Colors.transparent,
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => _index = i),
             itemBuilder: (_, i) => OnboardingPage(
                                        data: pages[i],
                                        isLast: i == pages.length - 1,
                                        isTicked: _isTicked,
                                        onTickChanged: (val) {
                                            setState(() {
                                            _isTicked = val;
                                            });
                                        },
                                        ),
            ),      
          ),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (i) => Container(
                margin: const EdgeInsets.all(4),
                width: _index == i ? 18 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _index == i ? Colors.black : Colors.white30,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Skip & Next / Get Started Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_index < pages.length - 1) {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    } else {
                      // TODO: Navigate to Welcome/Login screen
                    }
                  },
                  child: Text(
                    _index == pages.length - 1
                        ? "Get Started"
                        : "Next",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    ),
  ));
}
}