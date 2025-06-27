import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/models/lead_model.dart';
import 'package:brokers_hub/providers/lead_provider.dart';
import 'package:brokers_hub/widgets/common/app_input_field.dart';
import 'package:brokers_hub/widgets/common/custom_button.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';

class PostLeadScreen extends StatefulWidget {
  const PostLeadScreen({super.key});

  @override
  State<PostLeadScreen> createState() => _PostLeadScreenState();
}

class _PostLeadScreenState extends State<PostLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientNameController = TextEditingController();
  final _contactInfoController = TextEditingController();
  final _budgetRangeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _serviceType;
  String? _urgency;
  List<String>? _attachments;

  final List<String> _serviceTypes = [
    'Construction',
    'Web Development',
    'Interior Design',
    'Cleaning',
    'Electrical',
    'Plumbing',
    'Other'
  ];

  final List<String> _urgencyOptions = [
    'Low',
    'Medium',
    'High',
    'Urgent'
  ];

  @override
  void dispose() {
    _clientNameController.dispose();
    _contactInfoController.dispose();
    _budgetRangeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newLead = LeadModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '${_serviceType} - ${_clientNameController.text}',
        clientName: _clientNameController.text,
        contactInfo: _contactInfoController.text,
        serviceType: _serviceType!,
        budgetRange: _budgetRangeController.text,
        urgency: _urgency!,
        location: _locationController.text,
        description: _descriptionController.text,
        attachments: _attachments,
        status: 'pending',
        createdAt: DateTime.now(),
      );

      Provider.of<LeadProvider>(context, listen: false).addLead(newLead);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Lead posted successfully!'),
          backgroundColor: AppColors.successGreen,
        ),
      );

      Navigator.pop(context);
    }
  }

  void _mockAddAttachment() {
    setState(() {
      _attachments ??= [];
      _attachments!.add('attachment_${_attachments!.length + 1}.pdf');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post New Lead'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Client Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _clientNameController,
                label: 'Client Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter client name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _contactInfoController,
                label: 'Contact Info (Phone/Email)',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Lead Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _serviceType,
                decoration: InputDecoration(
                  label: const Text('Service Type'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _serviceTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _serviceType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a service type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _budgetRangeController,
                label: 'Budget Range',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter budget range';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _urgency,
                decoration: InputDecoration(
                  label: const Text('Urgency'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: _urgencyOptions.map((urgency) {
                  return DropdownMenuItem(
                    value: urgency,
                    child: Text(urgency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _urgency = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select urgency';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _locationController,
                label: 'Location',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AppInputField(
                controller: _descriptionController,
                label: 'Description',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Attachments (Optional)',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              if (_attachments != null && _attachments!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._attachments!.map((file) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.attach_file, size: 16),
                          const SizedBox(width: 8),
                          Text(file),
                        ],
                      ),
                    )),
                    const SizedBox(height: 8),
                  ],
                ),
              OutlinedButton(
                onPressed: _mockAddAttachment,
                child: const Text('Add Attachment'),
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: _submitForm,
                label: 'Post Lead',
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