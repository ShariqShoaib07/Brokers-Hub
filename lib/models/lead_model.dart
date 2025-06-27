class LeadModel {
  final String id;
  final String title;
  final String clientName;
  final String contactInfo;
  final String serviceType;
  final String budgetRange;
  final String urgency;
  final String location;
  final String description;
  final List<String>? attachments;
  final String status; // "pending", "matched", "finalized"
  final DateTime createdAt;

  LeadModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.contactInfo,
    required this.serviceType,
    required this.budgetRange,
    required this.urgency,
    required this.location,
    required this.description,
    this.attachments,
    required this.status,
    required this.createdAt,
  });

  // Convert JSON to LeadModel
  factory LeadModel.fromJson(Map<String, dynamic> json) {
    return LeadModel(
      id: json['id'] as String,
      title: json['title'] as String,
      clientName: json['clientName'] as String,
      contactInfo: json['contactInfo'] as String,
      serviceType: json['serviceType'] as String,
      budgetRange: json['budgetRange'] as String,
      urgency: json['urgency'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'])
          : null,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  // Convert LeadModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'clientName': clientName,
      'contactInfo': contactInfo,
      'serviceType': serviceType,
      'budgetRange': budgetRange,
      'urgency': urgency,
      'location': location,
      'description': description,
      'attachments': attachments,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Factory for creating mock/dummy data
  factory LeadModel.mock({
    String? id,
    String? title,
    String? clientName,
    String? contactInfo,
    String? serviceType,
    String? budgetRange,
    String? urgency,
    String? location,
    String? description,
    List<String>? attachments,
    String? status,
    DateTime? createdAt,
  }) {
    return LeadModel(
      id: id ?? 'lead_${DateTime.now().millisecondsSinceEpoch}',
      title: title ?? 'Website Development Project',
      clientName: clientName ?? 'John Doe',
      contactInfo: contactInfo ?? 'john.doe@example.com',
      serviceType: serviceType ?? 'Web Development',
      budgetRange: budgetRange ?? '\$1,000 - \$5,000',
      urgency: urgency ?? 'Medium',
      location: location ?? 'New York, USA',
      description: description ?? 'Looking for a developer to build an e-commerce website with payment integration.',
      attachments: attachments ?? ['requirements.pdf', 'mockup.jpg'],
      status: status ?? 'pending',
      createdAt: createdAt ?? DateTime.now().subtract(const Duration(days: 2)),
    );
  }

  // You might also want to add copyWith method for immutability
  LeadModel copyWith({
    String? id,
    String? title,
    String? clientName,
    String? contactInfo,
    String? serviceType,
    String? budgetRange,
    String? urgency,
    String? location,
    String? description,
    List<String>? attachments,
    String? status,
    DateTime? createdAt,
  }) {
    return LeadModel(
      id: id ?? this.id,
      title: title ?? this.title,
      clientName: clientName ?? this.clientName,
      contactInfo: contactInfo ?? this.contactInfo,
      serviceType: serviceType ?? this.serviceType,
      budgetRange: budgetRange ?? this.budgetRange,
      urgency: urgency ?? this.urgency,
      location: location ?? this.location,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}