import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final isLeadProvider = Provider.of<AuthProvider>(context, listen: false)
        .user
        ?.isLeadProvider ??
        false;

    switch (index) {
      case 0: // Dashboard
        Navigator.pushReplacementNamed(
          context,
          isLeadProvider ? AppRoutes.leadDashboard : AppRoutes.serviceDashboard,
        );
        break;
      case 1: // Leads
        Navigator.pushReplacementNamed(
          context,
          isLeadProvider ? AppRoutes.myLeads : AppRoutes.availableLeads,
        );
        break;
      case 2: // Profile
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLeadProvider = Provider.of<AuthProvider>(context, listen: true)
        .user
        ?.isLeadProvider ??
        false;

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.dashboard_outlined),
          activeIcon: const Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.list_alt_outlined),
          activeIcon: const Icon(Icons.list_alt),
          label: isLeadProvider ? 'My Leads' : 'Browse Leads',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          activeIcon: const Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}