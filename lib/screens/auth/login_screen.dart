import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/app_input_field.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await Provider.of<AuthProvider>(context, listen: false).login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (!mounted) return;

      // Check if user has selected role (in real app, this would come from user data)
      final hasSelectedRole = true; // Mock value - replace with actual check

      if (hasSelectedRole) {
        Navigator.pushReplacementNamed(context, AppRoutes.leadDashboard); // Or service dashboard based on role
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.roleSelection);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    // Fake Google sign-in logic
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google sign-in would be implemented here')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Welcome Back',
                  style: AppTextStyles.headlineMedium(context).copyWith(fontSize: 28),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: AppTextStyles.bodyMedium(context).copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 40),

                // Email Field
                AppInputField(
                  controller: _emailController,
                  label: 'Email Address',
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                AppInputField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),

                // Forgot Password (optional)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {}, // Would navigate to forgot password screen
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                CustomButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  label: _isLoading ? 'Logging in...' : 'Login',
                  backgroundColor: AppColors.primaryBlue,
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),

                // Or Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'OR',
                        style: AppTextStyles.bodyMedium(context).copyWith(color: Colors.grey),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 20),

                // Google Sign-In Button
                OutlinedButton(
                  onPressed: _isLoading ? null : _handleGoogleSignIn,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google_logo.png',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      Text('Continue with Google'),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Register Prompt
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.bodyMedium(context).copyWith(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Register',
                            style: AppTextStyles.bodyMedium(context).copyWith(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}