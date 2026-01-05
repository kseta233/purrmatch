import 'package:get/get.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/registration/presentation/pages/create_user_profile_page.dart';
import '../features/registration/presentation/pages/add_cat_profile_page.dart';
import '../features/feed/presentation/pages/feed_page.dart';
import '../features/match/presentation/pages/match_celebration_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/my_cats_list_page.dart';
import '../features/profile/presentation/pages/cat_detail_page.dart';
import '../features/profile/presentation/pages/matches_page.dart';
import '../features/profile/presentation/pages/edit_profile_page.dart';

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
  static const String editProfile = '/profile/edit';
  static const String catList = '/profile/cats';
  static const String catDetail = '/profile/cats/:id';
  static const String matches = '/profile/matches';
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
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: catList,
      page: () => const MyCatsListPage(),
    ),
    GetPage(
      name: catDetail,
      page: () => const CatDetailPage(),
    ),
    GetPage(
      name: matches,
      page: () => const MatchesPage(),
    ),
  ];
}

