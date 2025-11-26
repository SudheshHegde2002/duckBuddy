import 'package:flutter/material.dart';
import 'onboarding_page.dart';
import 'onboarding_model.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int _index = 0;
  bool _isTicked = false;

  late AnimationController _pulseController;
  late Animation<Color?> _pulseAnimation;

  final pages = const [
    OnboardingPageData(
      title: "Duck the pressure. Keep it casual.",
      desc:
          "Duck (on duckBuddy): To intentionally avoid emotional pressure, long-term commitments, and relationship DRAMA",
      anim: "assets/animations/CANARD.json",
    ),
    OnboardingPageData(
      title: "Find your 'duck'Buddy",
      desc:
          "Swipe through profiles, find your vibe. duckBuddy (on duckBuddy): A person who helps you in ducking, as they are here for ducking too!",
      anim: "assets/animations/duck.json",
    ),
    OnboardingPageData(
      title: "Only 𝑫𝒖𝒄𝒌𝒆𝒓𝒔 allowed",
      desc: "Safe, verified, and controlled.",
      anim: "assets/animations/error.json",
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // slow pulse
    );

    _pulseAnimation = ColorTween(
      begin: const Color.fromARGB(255, 160, 60, 55),
      end: const Color.fromARGB(255, 110, 30, 28),
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _pulseController.repeat(reverse: true); // ✅ breathing effect
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return AnimatedBuilder(
    animation: _pulseAnimation,
    builder: (context, child) {
      final bool isLast = _index == pages.length - 1;

      Color targetColor;

      if (isLast && !_isTicked) {
        targetColor = _pulseAnimation.value!; // pulsing red
      } else {
        targetColor = const Color.fromARGB(255, 196, 181, 48); // yellow
      }

      return AnimatedContainer(
        duration: const Duration(milliseconds: 200), 
        curve: Curves.easeIn,
        color: targetColor,
        child: child,
      );
    },
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

            // Dots
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

            // Next / Get Started
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();

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
    ),
  );
}

}
