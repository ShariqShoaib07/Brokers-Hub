import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';
import 'package:brokers_hub/providers/theme_provider.dart';
import 'package:brokers_hub/providers/auth_provider.dart';
import 'package:brokers_hub/routes/app_routes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '1.0.0';
  String _buildNumber = '1';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppTextStyles.headlineSmall(context),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            Text(
              'Appearance',
              style: AppTextStyles.titleLarge(context),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    title: Text(
                      'Dark Mode',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme(
                        value ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                    activeColor: AppColors.primaryBlue,
                  ),
                  const Divider(height: 1),
                  SwitchListTile.adaptive(
                    title: Text(
                      'Use System Theme',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    value: themeProvider.isSystemTheme,
                    onChanged: (value) {
                      themeProvider.setSystemThemeMode(value);
                    },
                    activeColor: AppColors.primaryBlue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Section
            Text(
              'Account',
              style: AppTextStyles.titleLarge(context),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Logout',
                      style: AppTextStyles.bodyMedium(context)?.copyWith(
                        color: AppColors.errorRed,
                      ),
                    ),
                    leading: Icon(
                      Icons.logout,
                      color: AppColors.errorRed,
                    ),
                    onTap: () => _showLogoutDialog(context, authProvider),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // About Section
            Text(
              'About',
              style: AppTextStyles.titleLarge(context),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Version',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    trailing: Text(
                      '$_appVersion (build $_buildNumber)',
                      style: AppTextStyles.bodyMedium(context)?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(
                      'Contact Support',
                      style: AppTextStyles.bodyMedium(context),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: Implement contact support
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: AppTextStyles.headlineSmall(context),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium(context),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              authProvider.logout();
              Navigator.popUntil(context, ModalRoute.withName(AppRoutes.login));
            },
            child: Text(
              'Logout',
              style: AppTextStyles.bodyMedium(context)?.copyWith(
                color: AppColors.errorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}