import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> slides = [
    OnboardingSlide(
      icon: Icons.connect_without_contact,
      title: "Connect Clients with Services",
      description: "Earn commissions by referring clients to trusted service providers in your network.",
    ),
    OnboardingSlide(
      icon: Icons.monetization_on,
      title: "Earn Commissions",
      description: "Get paid when your referrals turn into successful business deals.",
    ),
    OnboardingSlide(
      icon: Icons.verified_user,
      title: "Trusted Network",
      description: "All service providers are vetted to ensure quality and reliability for your clients.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button (top-right)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _navigateToLogin(),
                child: Text(
                  'Skip',
                  style: AppTextStyles.bodyMedium(context).copyWith(
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),

            // PageView Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return SingleOnboardingSlide(slide: slides[index]);
                },
              ),
            ),

            // Bottom Section (Dots + Button)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      slides.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.primaryBlue
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Get Started Button (only on last slide)
                  if (_currentPage == slides.length - 1)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _navigateToLogin,
                        child: Text(
                          'Get Started',
                          style: AppTextStyles.bodyMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }
}

class SingleOnboardingSlide extends StatelessWidget {
  final OnboardingSlide slide;

  const SingleOnboardingSlide({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              slide.icon,
              size: 80,
              color: AppColors.primaryBlue,
            ),
          ),
          const SizedBox(height: 40),

          // Title
          Text(
            slide.title,
            style: AppTextStyles.headlineMedium(context).copyWith(
              fontSize: 24,
              color: AppColors.primaryBlue,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            slide.description,
            style: AppTextStyles.bodyMedium(context).copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;

  OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
  });
}