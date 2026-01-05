import 'package:get/get.dart';

/// Deep link service for handling app navigation from external links
/// Supports both Firebase Dynamic Links (mobile) and URL parameters (web)
class DeepLinkService {
  /// Initialize deep link listeners
  static Future<void> initialize() async {
    try {
      // For web: Handle URL parameters
      _handleInitialWebLink();
      
      // For mobile: Firebase Dynamic Links
      // TODO: Implement when Firebase is fully configured
      // await _setupDynamicLinks();
      
      print('Deep link service initialized');
    } catch (e) {
      print('Deep link initialization error (expected on web): $e');
    }
  }

  /// Handle initial web link (URL parameters)
  static void _handleInitialWebLink() {
    // Check if app opened with URL parameters
    final uri = Uri.base;
    
    if (uri.queryParameters.containsKey('match_id')) {
      final matchId = uri.queryParameters['match_id']!;
      _handleMatchDeepLink(matchId);
    }
    
    if (uri.queryParameters.containsKey('cat_id')) {
      final catId = uri.queryParameters['cat_id']!;
      _handleCatDetailDeepLink(catId);
    }
  }

  /// Setup Firebase Dynamic Links (mobile only)
  static Future<void> _setupDynamicLinks() async {
    // TODO: Uncomment when Firebase Dynamic Links is configured
    /*
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _handleDeepLink(dynamicLinkData.link);
    }).onError((error) {
      print('Dynamic link error: $error');
    });

    // Check if app opened from terminated state via dynamic link
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      _handleDeepLink(data.link);
    }
    */
  }

  /// Handle deep link URI
  static void _handleDeepLink(Uri deepLink) {
    print('Deep link received: $deepLink');

    // Parse URL: purrmatch://match/:matchId
    if (deepLink.pathSegments.contains('match')) {
      final matchId = deepLink.pathSegments.last;
      _handleMatchDeepLink(matchId);
    }

    // Parse URL: purrmatch://cat/:catId
    if (deepLink.pathSegments.contains('cat')) {
      final catId = deepLink.pathSegments.last;
      _handleCatDetailDeepLink(catId);
    }
  }

  /// Handle match deep link
  static void _handleMatchDeepLink(String matchId) {
    print('Navigating to match: $matchId');
    
    // Navigate to match celebration page
    // TODO: Uncomment when routes are set up
    // Get.toNamed(
    //   AppRoutes.matchCelebration,
    //   arguments: {'matchId': matchId},
    // );
  }

  /// Handle cat detail deep link
  static void _handleCatDetailDeepLink(String catId) {
    print('Navigating to cat detail: $catId');
    
    // Navigate to cat detail page
    // TODO: Uncomment when routes are set up
    // Get.toNamed(
    //   AppRoutes.catDetail,
    //   arguments: {'catId': catId},
    // );
  }

  /// Create dynamic link (for sharing)
  static Future<String> createMatchLink(String matchId) async {
    // TODO: Implement when Firebase Dynamic Links is configured
    /*
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://purrmatch.page.link',
      link: Uri.parse('https://purrmatch.com/match/$matchId'),
      androidParameters: AndroidParameters(
        packageName: 'com.purrmatch.purrmatch',
      ),
      iosParameters: IOSParameters(
        bundleId: 'com.purrmatch.purrmatch',
      ),
    );

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    return shortLink.shortUrl.toString();
    */
    
    // Placeholder for web
    return 'https://purrmatch.com/?match_id=$matchId';
  }
}
