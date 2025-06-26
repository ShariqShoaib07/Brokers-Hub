import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/core/constants/app_theme.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/routes/app_routes.dart';

void main() {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // Add other providers here as needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brokers Hub',
      theme: AppTheme.lightTheme, // Using light theme from app_theme.dart
      initialRoute: AppRoutes.splash, // Initial route set to splash screen
      onGenerateRoute: RouteGenerator.generateRoute, // Using route generator
      // Optional: Add navigator key if you need to navigate without context
      // navigatorKey: NavigationService.navigatorKey,
    );
  }
}