import 'package:flutter/foundation.dart';
import '../models/lead_model.dart';
import '../models/service_application_model.dart';

class LeadProvider with ChangeNotifier {
  final List<LeadModel> _leads = [];
  final List<ServiceApplicationModel> _applications = [];

  // Initialize with dummy data
  LeadProvider() {
    _leads.addAll([
      LeadModel(
        id: '1',
        title: 'House Construction',
        clientName: 'Mr. Ali',
        contactInfo: '03001234567',
        serviceType: 'Construction',
        budgetRange: '10-15 Lacs',
        urgency: 'High',
        location: 'DHA Lahore',
        description: 'A 5-marla house, grey structure required',
        status: 'pending',
        createdAt: DateTime.now(),
      ),
      LeadModel(
        id: '2',
        title: 'Website Development',
        clientName: 'Tech Solutions Inc.',
        contactInfo: 'info@techsolutions.com',
        serviceType: 'Web Development',
        budgetRange: '50,000 - 100,000 PKR',
        urgency: 'Medium',
        location: 'Islamabad',
        description: 'E-commerce website with payment integration',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      LeadModel(
        id: '3',
        title: 'Interior Design',
        clientName: 'Mrs. Khan',
        contactInfo: '03331234567',
        serviceType: 'Interior Design',
        budgetRange: '5-8 Lacs',
        urgency: 'Low',
        location: 'Gulberg, Lahore',
        description: 'Complete home interior for 10-marla house',
        status: 'matched',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ]);
    _applications.addAll([
      ServiceApplicationModel(
        id: 'app1',
        leadId: '1',
        providerName: 'Construction Pro',
        message: 'I can start immediately',
        availability: 'Immediate',
        appliedAt: DateTime.now().subtract(Duration(days: 2)),
        status: 'in_progress',
        rating: 4.5,
        feedback: 'Great communication',
      ),
      ServiceApplicationModel(
        id: 'app2',
        leadId: '2',
        providerName: 'Web Dev Team',
        message: 'We specialize in e-commerce',
        availability: 'Within 1 Week',
        appliedAt: DateTime.now().subtract(Duration(days: 5)),
        status: 'finalized',
        rating: 5.0,
        feedback: 'Excellent work!',
      ),
    ]);
  }

  // Getter for leads (returns a copy to prevent external modification)
  List<LeadModel> get leads => List.from(_leads);

  // Getter for applications
  List<ServiceApplicationModel> get applications => List.from(_applications);

  // Add a new lead
  void addLead(LeadModel newLead) {
    _leads.add(newLead);
    notifyListeners();
  }

  // Update lead status
  void updateLeadStatus(String leadId, String newStatus) {
    final index = _leads.indexWhere((lead) => lead.id == leadId);
    if (index != -1) {
      _leads[index] = _leads[index].copyWith(status: newStatus);
      notifyListeners();
    }
  }

  List<ServiceApplicationModel> get myDeals {
    return _applications.where((app) =>
        ['applied', 'in_progress', 'finalized'].contains(app.status)
    ).toList();
  }

  // Apply to a lead
  Future<void> applyToLead(String leadId, ServiceApplicationModel application) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Add the application
    _applications.add(application);

    // Update lead status
    final leadIndex = _leads.indexWhere((lead) => lead.id == leadId);
    if (leadIndex != -1) {
      _leads[leadIndex] = _leads[leadIndex].copyWith(status: 'in_progress');
    }

    notifyListeners();
  }

  // NEW: Add rating to finalized application
  void addRating(String applicationId, double rating, String feedback) {
    final index = _applications.indexWhere((app) => app.id == applicationId);
    if (index != -1) {
      _applications[index] = _applications[index].copyWith(
        rating: rating,
        feedback: feedback,
        status: 'finalized',
      );
      notifyListeners();
    }
  }

  // NEW: Get applications by provider
  List<ServiceApplicationModel> getApplicationsByProvider(String providerName) {
    return _applications.where(
            (app) => app.providerName == providerName
    ).toList();
  }

  // Get applications for a specific lead
  List<ServiceApplicationModel> getApplicationsForLead(String leadId) {
    return _applications.where((app) => app.leadId == leadId).toList();
  }

  // Optional: Get lead by ID
  LeadModel? getLeadById(String id) {
    try {
      return _leads.firstWhere((lead) => lead.id == id);
    } catch (e) {
      return null;
    }
  }

  // Optional: Filter leads by status
  List<LeadModel> getLeadsByStatus(String status) {
    return _leads.where((lead) => lead.status == status).toList();
  }
}