// lib/models/service_application_model.dart

class ServiceApplicationModel {
  final String id;
  final String leadId;
  final String providerName;
  final String message;
  final String availability;
  final DateTime appliedAt;
  final String status;
  final double? rating;
  final String? feedback;

  ServiceApplicationModel({
    required this.id,
    required this.leadId,
    required this.providerName,
    required this.message,
    required this.availability,
    required this.appliedAt,
    required this.status,
    this.rating,
    this.feedback,
  });

  factory ServiceApplicationModel.fromJson(Map<String, dynamic> json) {
    return ServiceApplicationModel(
      id: json['id'] as String,
      leadId: json['leadId'] as String,
      providerName: json['providerName'] as String,
      message: json['message'] as String,
      availability: json['availability'] as String,
      appliedAt: DateTime.parse(json['appliedAt'] as String),
      status: json['status'] as String,
      rating: json['rating']?.toDouble(),
      feedback: json['feedback'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadId': leadId,
      'providerName': providerName,
      'message': message,
      'availability': availability,
      'appliedAt': appliedAt.toIso8601String(),
      'status': status,
      'rating': rating,
      'feedback': feedback,
    };
  }

  factory ServiceApplicationModel.dummy() {
    return ServiceApplicationModel(
      id: 'app-12345',
      leadId: 'lead-67890',
      providerName: 'ABC Construction Services',
      message: 'I can complete this project within your budget and timeline. I have 5 years of experience in similar projects.',
      availability: 'Immediate',
      appliedAt: DateTime.now().subtract(const Duration(days: 2)),
      status: 'applied',
      rating: null,
      feedback: null,
    );
  }

  // Copy with method for easy updates
  ServiceApplicationModel copyWith({
    String? id,
    String? leadId,
    String? providerName,
    String? message,
    String? availability,
    DateTime? appliedAt,
    String? status,
    double? rating,
    String? feedback,
  }) {
    return ServiceApplicationModel(
      id: id ?? this.id,
      leadId: leadId ?? this.leadId,
      providerName: providerName ?? this.providerName,
      message: message ?? this.message,
      availability: availability ?? this.availability,
      appliedAt: appliedAt ?? this.appliedAt,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      feedback: feedback ?? this.feedback,
    );
  }
}