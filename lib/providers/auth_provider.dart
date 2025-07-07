import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  // Getters
  UserModel? get user => _user;
  bool get isLoggedIn => _user != null;
  String? get userRole => _user?.role;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Login with email and password
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // For testing different roles
    if (email.contains('@')) {
      final role = email.contains('admin@') ? 'admin' :
      email.contains('service@') ? 'service_provider' :
      'lead_provider';

      _user = UserModel.dummyUser.copyWith(
        email: email,
        role: role,
      );
      _error = null;
    } else {
      _error = 'Invalid email or password';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Register new user
  Future<void> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API delay
    await Future.delayed(const Duration(seconds: 2));

    // Simple validation
    if (email.contains('@') && password.length >= 6) {
      _user = UserModel(
        name: name,
        email: email,
        role: 'lead_provider', // Default role
      );
      _error = null;
    } else {
      _error = 'Registration failed. Please check your details.';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Verify OTP (always returns true for now)
  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Select user role
  void selectRole(String role) {
    if (_user != null) {
      _user = _user!.copyWith(role: role);
      notifyListeners();
    }
  }

  // Complete KYC process
  Future<void> completeKyc(String cnic, String address, String imagePath) async {
    if (_user == null) return;

    try {
      _user = _user!.copyWith(
        cnic: cnic,
        address: address,
        profilePhoto: imagePath,
      );
      notifyListeners();

    } catch (e) {
      throw Exception('Failed to complete KYC: $e');
    }
  }

  // Logout
  void logout() {
    _user = null;
    _error = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Handle navigation after login
  void handlePostLoginNavigation(BuildContext context) {
    if (_user == null) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      _getDashboardRoute(),
          (route) => false,
    );
  }

  // Helper method to get the correct dashboard route based on user role
  String _getDashboardRoute() {
    switch (_user?.role) {
      case 'admin':
        return AppRoutes.adminDashboard;
      case 'service_provider':
        return AppRoutes.serviceDashboard;
      case 'lead_provider':
      default:
        return AppRoutes.leadDashboard;
    }
  }
}