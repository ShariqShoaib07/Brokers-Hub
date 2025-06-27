import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/widgets/common/custom_card.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<Map<String, String>> users = [
    {"name": "Ali", "email": "ali@example.com", "status": "active"},
    {"name": "Sara", "email": "sara@example.com", "status": "suspended"},
    {"name": "John", "email": "john@example.com", "status": "active"},
    {"name": "Emma", "email": "emma@example.com", "status": "active"},
    {"name": "Mike", "email": "mike@example.com", "status": "suspended"},
  ];

  void _toggleUserStatus(int index) {
    setState(() {
      users[index]['status'] =
      users[index]['status'] == 'active' ? 'suspended' : 'active';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'User ${users[index]['name']} status changed to ${users[index]['status']}'),
        backgroundColor: users[index]['status'] == 'active'
            ? AppColors.successGreen
            : AppColors.warningYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Users',
          style: AppTextStyles.headlineSmall(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CustomCard(
              title: user['name']!,
              subtitle: user['email']!,
              badgeText: user['status']!,
              onTap: () => _toggleUserStatus(index),
            ),
          );
        },
      ),
    );
  }
}