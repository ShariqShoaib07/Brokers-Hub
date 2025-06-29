import 'package:flutter/material.dart';
import 'package:brokers_hub/screens/auth/login_screen.dart';
import 'package:brokers_hub/screens/auth/register_screen.dart';
import 'package:brokers_hub/screens/auth/onboarding_screen.dart';
import 'package:brokers_hub/screens/common/splash_screen.dart';
import 'package:brokers_hub/screens/auth/kyc_verification_screen.dart';
import 'package:brokers_hub/screens/auth/role_selection_screen.dart';
import 'package:brokers_hub/screens/lead_provider/L_dashboard_screen.dart'; // Fixed import name
import 'package:brokers_hub/screens/service_provider/s_dashboard_screen.dart'; // Fixed import name
import 'package:brokers_hub/screens/lead_provider/commission_screen.dart';
import 'package:brokers_hub/screens/service_provider/my_deals_screen.dart';
import 'package:brokers_hub/screens/service_provider/rating_tracker_screen.dart';
import 'package:brokers_hub/screens/admin/admin_dashboard.dart';
import 'package:brokers_hub/screens/admin/manage_users_screen.dart';
import 'package:brokers_hub/screens/admin/lead_approval_screen.dart';
import 'package:brokers_hub/screens/admin/payout_requests_screen.dart';
import 'package:brokers_hub/screens/admin/reports_screen.dart';
import 'package:brokers_hub/screens/common/wallet_screen.dart';
import 'package:brokers_hub/screens/common/referral_screen.dart';
import 'package:brokers_hub/screens/lead_provider/post_lead_screen.dart';
import 'package:brokers_hub/screens/lead_provider/my_leads_screen.dart';
import 'package:brokers_hub/screens/lead_provider/lead_detail_screen.dart';
import 'package:brokers_hub/screens/service_provider/available_leads_screen.dart';
import 'package:brokers_hub/screens/service_provider/lead_application_screen.dart';
import 'package:brokers_hub/screens/service_provider/earnings_screen.dart';
import 'package:brokers_hub/screens/common/chat_screen.dart';
import 'package:brokers_hub/screens/common/settings_screen.dart';
import 'package:brokers_hub/models/lead_model.dart';


class AppRoutes {
  // Static route names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String kycVerification = '/kyc-verification';
  static const String roleSelection = '/role-selection';
  static const String leadDashboard = '/lead-dashboard';
  static const String serviceDashboard = '/service-dashboard';
  static const String commission = '/commission'; // Added commission route
  static const String myDeals = '/my-deals';
  static const String ratingTracker = '/rating-tracker';
  static const String adminDashboard = '/admin-dashboard';
  static const String manageUsers = '/manage-users';
  static const String leadApproval = '/lead-approval';
  static const String payoutRequests = '/payout-requests';
  static const String reports = '/reports';
  static const String wallet = '/wallet'; // Added wallet route
  static const String referral = '/referral'; // Added referral route
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String availableLeads = '/available-leads';
  static const String leadApplication = '/lead-application';
  static const String earnings = '/earnings';
  static const String postLead = '/post-lead';
  static const String myLeads = '/my-leads';
  static const String leadDetail = '/lead-detail';



  // Helper to get all routes (might be useful for route guards)
  static List<String> get routes => [
    splash,
    onboarding,
    login,
    register,
    kycVerification,
    roleSelection,
    leadDashboard,
    serviceDashboard,
    myDeals,
    ratingTracker,
    adminDashboard,
    manageUsers,
    leadApproval,
    payoutRequests,
    reports,
    commission,
    wallet,
    referral,
    postLead,
    myLeads,
    leadDetail,
    availableLeads,
    leadApplication,
    earnings,
    profile,
    chat,
    settings,
  ];
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case AppRoutes.kycVerification:
        return MaterialPageRoute(builder: (_) => const KYCVerificationScreen());
      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      case AppRoutes.commission:
        return MaterialPageRoute(builder: (_) => CommissionScreen()); // Removed const
      case AppRoutes.leadDashboard:
        return MaterialPageRoute(builder: (_) => const LeadDashboardScreen());
      case AppRoutes.serviceDashboard:
        return MaterialPageRoute(builder: (_) => const SDashboardScreen());
      case AppRoutes.myDeals:
        return MaterialPageRoute(builder: (_) => const MyDealsScreen());
      case AppRoutes.ratingTracker:
        return MaterialPageRoute(builder: (_) => RatingTrackerScreen());
      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());
      case AppRoutes.manageUsers:
        return MaterialPageRoute(builder: (_) => const ManageUsersScreen());
      case AppRoutes.leadApproval:
        return MaterialPageRoute(builder: (_) => const LeadApprovalScreen());
      case AppRoutes.payoutRequests:
        return MaterialPageRoute(builder: (_) => const PayoutRequestsScreen());
      case AppRoutes.reports:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      case AppRoutes.wallet:
        return MaterialPageRoute(builder: (_) => const WalletScreen());
      case AppRoutes.referral:
        return MaterialPageRoute(builder: (_) => const ReferralScreen());
      case AppRoutes.postLead:
        return MaterialPageRoute(builder: (_) => const PostLeadScreen());
      case AppRoutes.myLeads:
        return MaterialPageRoute(builder: (_) => const MyLeadsScreen());
      case AppRoutes.leadDetail:
        final lead = settings.arguments as LeadModel;
        return MaterialPageRoute(
          builder: (_) => LeadDetailScreen(lead: lead),
        );
      case AppRoutes.availableLeads:
        return MaterialPageRoute(builder: (_) => const AvailableLeadsScreen());
      case AppRoutes.leadApplication:
        final lead = settings.arguments as LeadModel;
        return MaterialPageRoute(
          builder: (_) => LeadApplicationScreen(lead: lead),
        );
      case AppRoutes.earnings:
        return MaterialPageRoute(builder: (_) => EarningsScreen());

    // Common Routes
      case AppRoutes.profile:
        //return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case AppRoutes.chat:
      final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => ChatScreen(
          conversationId: args['conversationId'],
          currentUser: args['currentUser'],
        ),
      );
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for $routeName'),
        ),
      ),
    );
  }
}