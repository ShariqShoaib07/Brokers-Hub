import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/widgets/layout/bottom_nav_bar.dart';

class LDashboardScreen extends StatelessWidget {
  const LDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lead Provider Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.name ?? 'Lead Provider'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/post-lead'),
              child: const Text('Post New Lead'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}