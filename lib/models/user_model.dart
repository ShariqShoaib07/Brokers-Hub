class UserModel {
  final String name;
  final String email;
  final String role; // 'lead_provider' or 'service_provider'
  final String? phone;
  final String? address;
  final String? cnic;
  final String? profilePhoto;

  // Constructor with required fields and optional fields
  UserModel({
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.address,
    this.cnic,
    this.profilePhoto,
  });

  // Factory constructor to create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'lead_provider',
      phone: json['phone'],
      address: json['address'],
      cnic: json['cnic'],
      profilePhoto: json['profilePhoto'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
      'cnic': cnic,
      'profilePhoto': profilePhoto,
    };
  }

  // Static dummy user for testing
  static final dummyUser = UserModel(
    name: "Ali",
    email: "ali@email.com",
    role: "lead_provider",
    phone: "+923001234567",
    address: "123 Main St, Lahore",
    cnic: "12345-6789012-3",
    profilePhoto: "https://example.com/profile.jpg",
  );

  // Helper method to check if user is a lead provider
  bool get isLeadProvider => role == 'lead_provider';

  // Helper method to check if user is a service provider
  bool get isServiceProvider => role == 'service_provider';

  // CopyWith method for easy updates
  UserModel copyWith({
    String? name,
    String? email,
    String? role,
    String? phone,
    String? address,
    String? cnic,
    String? profilePhoto,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      cnic: cnic ?? this.cnic,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }
}