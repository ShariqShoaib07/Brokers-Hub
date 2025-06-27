import 'package:flutter/foundation.dart';
import '../models/lead_model.dart';

class LeadProvider with ChangeNotifier {
  final List<LeadModel> _leads = [];

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
  }

  // Getter for leads (returns a copy to prevent external modification)
  List<LeadModel> get leads => List.from(_leads);

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