import 'package:get/get.dart';
import '../features/auth/presentation/pages/login_page.dart';

/// App routes configuration
class AppRoutes {
  AppRoutes._(); // Private constructor

  // Route names
  static const String login = '/login';
  static const String register = '/register';
  static const String createUserProfile = '/register/user-profile';
  static const String addCatProfile = '/register/cat-profile';
  static const String feed = '/feed';
  static const String profile = '/profile';
  static const String catList = '/profile/cats';
  static const String catDetail = '/profile/cats/:id';
  static const String matchCelebration = '/match/celebration';
  static const String matchList = '/match/list/:catId';

  // GetX Pages
  static List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
      // binding: AuthBinding(), // TODO: Add when controller is ready
    ),
    // TODO: Add other routes as pages are created
    /*
    GetPage(
      name: createUserProfile,
      page: () => CreateUserProfilePage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: addCatProfile,
      page: () => AddCatProfilePage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: feed,
      page: () => FeedPage(),
      binding: FeedBinding(),
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: matchCelebration,
      page: () => MatchCelebrationPage(),
    ),
    */
  ];
}
