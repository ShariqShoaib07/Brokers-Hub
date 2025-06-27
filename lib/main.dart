import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/core/constants/app_theme.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/providers/chat_provider.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/providers/theme_provider.dart';
import 'package:brokers_hub/providers/wallet_provider.dart';
import 'package:brokers_hub/routes/app_routes.dart';
import 'package:brokers_hub/screens/auth/login_screen.dart';
import 'package:brokers_hub/screens/auth/onboarding_screen.dart';
import 'package:brokers_hub/screens/auth/register_screen.dart';
import 'package:brokers_hub/screens/auth/role_selection_screen.dart';
import 'package:brokers_hub/screens/auth/kyc_verification_screen.dart';
import 'package:brokers_hub/screens/common/splash_screen.dart';
import 'package:brokers_hub/screens/lead_provider/L_dashboard_screen.dart';
import 'package:brokers_hub/screens/service_provider/S_dashboard_screen.dart';
// Import all other screens as needed...

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => LeadProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Brokers Hub',
      debugShowCheckedModeBanner: false,

      // Theme Configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,

      // Navigation Configuration
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.roleSelection: (context) => const RoleSelectionScreen(),
        AppRoutes.kycVerification: (context) => const KYCVerificationScreen(),
        AppRoutes.leadDashboard: (context) => const LeadDashboardScreen(),
        AppRoutes.serviceDashboard: (context) => const SDashboardScreen(),
        // Add all other routes here...
      },

      // Fallback for unknown routes
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      ),

      // UI Configuration
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0, // Disables system text scaling
          ),
          child: child!,
        );
      },
    );
  }
}