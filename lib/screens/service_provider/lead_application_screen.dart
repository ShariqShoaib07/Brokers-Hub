import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/models/lead_model.dart';
import 'package:brokers_hub/models/service_application_model.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/widgets/common/app_input_field.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/core/utils/validators.dart';

class LeadApplicationScreen extends StatefulWidget {
  final LeadModel lead;

  const LeadApplicationScreen({super.key, required this.lead});

  @override
  State<LeadApplicationScreen> createState() => _LeadApplicationScreenState();
}

class _LeadApplicationScreenState extends State<LeadApplicationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _messageController = TextEditingController();
  String? _selectedAvailability;
  bool _isSubmitting = false;

  // Availability options
  final List<String> availabilityOptions = [
    'Immediate',
    'Within 2 Days',
    'Within 1 Week',
    'Within 2 Weeks',
    'Custom Timeline'
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply to Lead',
          style: AppTextStyles.titleLarge(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lead info section
              Text(
                widget.lead.title,
                style: AppTextStyles.headlineSmall(context),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.darkTextSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.lead.location,
                    style: AppTextStyles.bodySmall(context),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.attach_money,
                    size: 16,
                    color: AppColors.darkTextSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.lead.budgetRange,
                    style: AppTextStyles.bodyMedium(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Application form
              Text(
                'Application Details',
                style: AppTextStyles.titleMedium(context),
              ),
              const SizedBox(height: 16),

              // Message field
              AppInputField(
                controller: _messageController,
                label: 'Your Message',
                hintText: 'Explain why you\'re the best for this job...',
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Availability dropdown
              DropdownButtonFormField<String>(
                value: _selectedAvailability,
                decoration: InputDecoration(
                  labelText: 'Availability',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                items: availabilityOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAvailability = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select availability' : null,
              ),
              const SizedBox(height: 32),

              // Submit button
              CustomButton(
                onPressed: _isSubmitting ? null : _submitApplication,
                label: 'Submit Application',
                backgroundColor: AppColors.primaryBlue,
                textColor: Colors.white,
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Create application model
      final application = ServiceApplicationModel(
        id: 'app-${DateTime.now().millisecondsSinceEpoch}',
        leadId: widget.lead.id,
        providerName: 'Current User', // Replace with actual provider name
        message: _messageController.text,
        availability: _selectedAvailability!,
        appliedAt: DateTime.now(),
        status: 'applied',
      );

      // Submit application through provider
      await Provider.of<LeadProvider>(context, listen: false)
          .applyToLead(widget.lead.id, application);

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Application submitted successfully!',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.successGreen,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit application: ${e.toString()}',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}