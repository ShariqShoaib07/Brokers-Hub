import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isLoggedIn) {
      // Navigate to appropriate dashboard based on role
      final route = authProvider.userRole == 'lead_provider'
          ? AppRoutes.leadDashboard
          : AppRoutes.serviceDashboard;
      Navigator.pushReplacementNamed(context, route);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo Placeholder
            Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.handshake,
                size: 80,
                color: AppColors.primaryBlue,
              ),
            ),
            const SizedBox(height: 20),
            // App Name
            Text(
              'Brokers Hub',
              style: AppTextStyles.headlineLarge(context).copyWith(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}