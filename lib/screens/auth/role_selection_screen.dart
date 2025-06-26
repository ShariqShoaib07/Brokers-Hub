import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Select Your Role',
                style: AppTextStyles.headlineLarge(context).copyWith(fontSize: 28),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to use Brokers Hub',
                style: AppTextStyles.bodyMedium(context).copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 40),

              // Role Cards
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lead Provider Card
                      _RoleCard(
                        icon: Icons.person_outline,
                        title: 'Lead Provider',
                        description: 'Refer clients and earn commissions',
                        color: AppColors.primaryBlue,
                        onTap: () => _handleRoleSelection(context, 'lead_provider'),
                      ),
                      const SizedBox(height: 24),

                      // Service Provider Card
                      _RoleCard(
                        icon: Icons.business_center_outlined,
                        title: 'Service Provider',
                        description: 'Find new clients and grow your business',
                        color: AppColors.secondaryPurple,
                        onTap: () => _handleRoleSelection(context, 'service_provider'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleRoleSelection(BuildContext context, String role) {
    Provider.of<AuthProvider>(context, listen: false).selectRole(role);
    Navigator.pushReplacementNamed(
      context,
      role == 'lead_provider'
          ? AppRoutes.leadDashboard
          : AppRoutes.serviceDashboard,
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36,
                color: color,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              style: AppTextStyles.titleLarge(context).copyWith(
                color: color,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: AppTextStyles.bodyMedium(context).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}