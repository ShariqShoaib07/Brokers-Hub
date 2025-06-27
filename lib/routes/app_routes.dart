import 'package:flutter/material.dart';
import 'package:brokers_hub/screens/auth/login_screen.dart';
import 'package:brokers_hub/screens/auth/register_screen.dart';
import 'package:brokers_hub/screens/auth/onboarding_screen.dart';
import 'package:brokers_hub/screens/common/splash_screen.dart';
import 'package:brokers_hub/screens/auth/kyc_verification_screen.dart';
import 'package:brokers_hub/screens/auth/role_selection_screen.dart';
import 'package:brokers_hub/screens/lead_provider/L_dashboard_screen.dart'; // Fixed import name
import 'package:brokers_hub/screens/service_provider/s_dashboard_screen.dart'; // Fixed import name
import 'package:brokers_hub/screens/lead_provider/commission_screen.dart';
import 'package:brokers_hub/screens/service_provider/my_deals_screen.dart';
import 'package:brokers_hub/screens/service_provider/rating_tracker_screen.dart';

class AppRoutes {
  // Static route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String kycVerification = '/kyc-verification';
  static const String roleSelection = '/role-selection';
  static const String leadDashboard = '/lead-dashboard';
  static const String serviceDashboard = '/service-dashboard';
  static const String commission = '/commission'; // Added commission route
  static const String myDeals = '/my-deals';
  static const String ratingTracker = '/rating-tracker';

  // Helper to get all routes (might be useful for route guards)
  static List<String> get routes => [
    splash,
    onboarding,
    login,
    register,
    kycVerification,
    roleSelection,
    leadDashboard,
    serviceDashboard,
    myDeals,
    ratingTracker,
    commission, // Added to routes list
  ];
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.kycVerification:
        return MaterialPageRoute(builder: (_) => const KYCVerificationScreen());
      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      case AppRoutes.commission:
        return MaterialPageRoute(builder: (_) => CommissionScreen()); // Removed const
      case AppRoutes.leadDashboard:
        return MaterialPageRoute(builder: (_) => const LeadDashboardScreen());
      case AppRoutes.serviceDashboard:
        return MaterialPageRoute(builder: (_) => const SDashboardScreen());
      case AppRoutes.myDeals:
        return MaterialPageRoute(builder: (_) => const MyDealsScreen());
      case AppRoutes.ratingTracker:
        return MaterialPageRoute(builder: (_) => RatingTrackerScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for $routeName'),
        ),
      ),
    );
  }
}