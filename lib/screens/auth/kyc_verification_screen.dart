import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/app_input_field.dart';
import 'package:brokers_hub/routes/app_routes.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class KYCVerificationScreen extends StatefulWidget {
  const KYCVerificationScreen({super.key});

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cnicController = TextEditingController();
  final _addressController = TextEditingController();
  File? _profileImage;
  bool _isLoading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _cnicController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _handlePhotoUpload() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile photo selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  Future<void> _submitKyc() async {
    if (!_formKey.currentState!.validate()) return;
    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload a profile photo')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Await the KYC completion
      await Provider.of<AuthProvider>(context, listen: false).completeKyc(
        _cnicController.text.trim(),
        _addressController.text.trim(),
        _profileImage!.path,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('KYC verification completed successfully!')),
      );

      // Navigate to appropriate dashboard
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final route = authProvider.user?.isLeadProvider ?? false
          ? AppRoutes.leadDashboard
          : AppRoutes.serviceDashboard;
      Navigator.pushReplacementNamed(context, route);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('KYC submission failed: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KYC Verification'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Complete Your Profile',
                style: AppTextStyles.headlineMedium(context).copyWith(fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                'Verify your identity to start using Brokers Hub',
                style: AppTextStyles.bodyMedium(context).copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Profile Photo Upload
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _handlePhotoUpload,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryBlue,
                            width: 2,
                          ),
                          image: _profileImage != null
                              ? DecorationImage(
                            image: FileImage(_profileImage!),
                            fit: BoxFit.cover,
                          )
                              : null,
                        ),
                        child: _profileImage == null
                            ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: AppColors.primaryBlue,
                        )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Upload Profile Photo',
                      style: AppTextStyles.bodyMedium(context).copyWith(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // CNIC Number
              AppInputField(
                controller: _cnicController,
                label: 'CNIC Number',
                hintText: 'Enter your CNIC without dashes',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your CNIC';
                  }
                  if (value.length < 13) {
                    return 'CNIC must be 13 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Address
              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: 'Enter your complete address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  if (value.length < 10) {
                    return 'Address seems too short';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),

              // Submit Button
              CustomButton(
                onPressed: _isLoading ? null : _submitKyc,
                label: _isLoading ? 'Verifying...' : 'Complete Verification',
                backgroundColor: AppColors.primaryBlue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}