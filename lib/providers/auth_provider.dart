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

    // For now, just return the dummy user if email contains "@"
    if (email.contains('@')) {
      _user = UserModel.dummyUser.copyWith(email: email);
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
      // 1. First upload image if needed
      // final photoUrl = await _uploadImage(imagePath);

      // 2. Update local user
      _user = _user!.copyWith(
        cnic: cnic,
        address: address,
        profilePhoto: imagePath, // or use photoUrl if uploaded
      );
      notifyListeners();

      // 3. Save to backend
      // await _apiService.updateUserKyc(_user!);
    } catch (e) {
      // Re-throw so UI can handle it
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

    // Clear any existing routes and navigate to the appropriate dashboard
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