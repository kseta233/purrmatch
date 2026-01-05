// Temporarily disabled for web compatibility
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

/// Firebase service for Cloud Messaging and notifications
/// Temporarily disabled for web compatibility - will be enabled for mobile builds
class FirebaseService {
  // static FirebaseMessaging? _messaging;

  /// Initialize Firebase
  static Future<void> initialize() async {
    print('Firebase temporarily disabled for web - will be enabled for mobile builds');
    print('Firebase temporarily disabled for web - will be enabled for mobile builds');
    /*
    try {
      // Note: Firebase options will be configured via FlutterFire CLI
      // For now, we'll initialize with default options
      await Firebase.initializeApp();
      print('Firebase initialized successfully');
      
      await _setupFCM();
    } catch (e) {
      print('Firebase initialization skipped (not configured): $e');
      // Not critical for frontend development
    }
    */
  }

  /// Setup Firebase Cloud Messaging (disabled for web)
  static Future<void> _setupFCM() async {
    /*
    try {
      _messaging = FirebaseMessaging.instance;

      // Request notification permissions
      NotificationSettings settings = await _messaging!.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted notification permission');
        
        // Get FCM token
        String? token = await _messaging!.getToken();
        print('FCM Token: $token');
        
        // TODO: Save token to user profile in Supabase
      } else {
        print('User declined or has not accepted notification permission');
      }

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);

      // Handle notification taps (when app is in background)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Check if app was opened from terminated state via notification
      RemoteMessage? initialMessage = await _messaging!.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }
    } catch (e) {
      print('FCM setup error (expected if Firebase not configured): $e');
    }
    */
  }

  /*
  /// Handle foreground messages
  static void _handleForegroundMessage(RemoteMessage message) {
    print('Foreground message received: ${message.notification?.title}');
    
    // TODO: Show in-app notification
    if (message.notification != null) {
      print('Notification: ${message.notification!.title}');
      print('Body: ${message.notification!.body}');
    }

    // Handle match notification
    if (message.data['type'] == 'match') {
      final matchId = message.data['match_id'];
      print('Match notification received: $matchId');
      // Navigate to match page handled by deep link service
    }
  }

  /// Handle background messages (must be top-level function)
  static Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print('Background message received: ${message.notification?.title}');
    // Background messages are handled by the system
  }

  /// Handle notification tap (app opened from notification)
  static void _handleNotificationTap(RemoteMessage message) {
    print('Notification tapped: ${message.notification?.title}');
    
    // Handle match notification
    if (message.data['type'] == 'match') {
      final matchId = message.data['match_id'];
      print('Opening match: $matchId');
      // TODO: Navigate to match celebration page
      // This will be handled in deep link service
    }
  }

  /// Get FCM token
  static Future<String?> getToken() async {
    if (_messaging == null) return null;
    return await _messaging!.getToken();
  }

  /// Subscribe to topic
  static Future<void> subscribeToTopic(String topic) async {
    if (_messaging == null) return;
    await _messaging!.subscribeToTopic(topic);
  }

  /// Unsubscribe from topic
  static Future<void> unsubscribeFromTopic(String topic) async {
    if (_messaging == null) return;
    await _messaging!.unsubscribeFromTopic(topic);
  }
  */
}
