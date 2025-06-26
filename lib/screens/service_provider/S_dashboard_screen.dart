import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/widgets/layout/bottom_nav_bar.dart';

class SDashboardScreen extends StatelessWidget {
  const SDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Provider Dashboard'),
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
            Text('Welcome, ${user?.name ?? 'Service Provider'}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/available-leads'),
              child: const Text('Browse Available Leads'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}