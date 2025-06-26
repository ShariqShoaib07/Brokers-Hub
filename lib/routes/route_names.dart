class RouteNames {
  // Auth Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String kycVerification = '/kyc-verification';
  static const String roleSelection = '/role-selection';

  // Dashboard Routes
  static const String leadDashboard = '/lead-dashboard';
  static const String serviceDashboard = '/service-dashboard';

  // Lead Provider Routes
  static const String postLead = '/post-lead';
  static const String myLeads = '/my-leads';
  static const String leadDetail = '/lead-detail';
  static const String commission = '/commission';

  // Service Provider Routes
  static const String availableLeads = '/available-leads';
  static const String leadApplication = '/lead-application';
  static const String myDeals = '/my-deals';
  static const String earnings = '/earnings';

  // Common Routes
  static const String profile = '/profile';
  static const String chat = '/chat';
  static const String settings = '/settings';

  // Admin Routes
  static const String adminDashboard = '/admin-dashboard';
  static const String manageUsers = '/manage-users';
  static const String leadApproval = '/lead-approval';
  static const String payoutRequests = '/payout-requests';
  static const String reports = '/reports';

  // Get all routes
  static List<String> get allRoutes => [
    splash,
    onboarding,
    login,
    register,
    kycVerification,
    roleSelection,
    leadDashboard,
    serviceDashboard,
    postLead,
    myLeads,
    leadDetail,
    commission,
    availableLeads,
    leadApplication,
    myDeals,
    earnings,
    profile,
    chat,
    settings,
    adminDashboard,
    manageUsers,
    leadApproval,
    payoutRequests,
    reports,
  ];
}