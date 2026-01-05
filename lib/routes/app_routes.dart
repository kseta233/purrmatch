import 'package:get/get.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/registration/presentation/pages/create_user_profile_page.dart';
import '../features/registration/presentation/pages/add_cat_profile_page.dart';
import '../features/feed/presentation/pages/feed_page.dart';
import '../features/match/presentation/pages/match_celebration_page.dart';

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
    ),
    GetPage(
      name: createUserProfile,
      page: () => const CreateUserProfilePage(),
    ),
    GetPage(
      name: addCatProfile,
      page: () => const AddCatProfilePage(),
    ),
    GetPage(
      name: feed,
      page: () => const FeedPage(),
    ),
    GetPage(
      name: matchCelebration,
      page: () => const MatchCelebrationPage(),
    ),
    // TODO: Add remaining routes
    /*
    GetPage(
      name: profile,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    */
  ];
}
