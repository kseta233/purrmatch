import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Supabase service for authentication, database, and storage
class SupabaseService {
  static SupabaseClient get client => Supabase.instance.client;

  /// Initialize Supabase
  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    
    final supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
    final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

    if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
      print('Warning: Supabase credentials not configured in .env file');
      return;
    }

    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );

    print('Supabase initialized successfully');
  }

  // ========== Auth Methods ==========

  /// Sign in with email and password
  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// Sign up with email and password
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  /// Sign in with Google
  static Future<bool> signInWithGoogle() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'purrmatch://callback',
    );
  }

  /// Sign in with Apple
  static Future<bool> signInWithApple() async {
    return await client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectTo: 'purrmatch://callback',
    );
  }

  /// Sign out
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  /// Get current user
  static User? get currentUser => client.auth.currentUser;

  /// Listen to auth state changes
  static Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;

  // ========== Database Methods (Placeholder) ==========

  /// Get cat stack for swiping (placeholder)
  static Future<List<Map<String, dynamic>>> getCatStack() async {
    // TODO: Implement actual query when backend is ready
    // return await client.from('cats').select().limit(10);
    
    // Placeholder mock data
    return [
      {
        'id': '1',
        'name': 'Mochi',
        'breed': 'British Shorthair',
        'age': 2,
        'gender': 'Male',
        'location': 'Jakarta, 2km away',
        'photos': ['https://placekitten.com/400/600'],
        'verified': true,
      },
      {
        'id': '2',
        'name': 'Luna',
        'breed': 'Persian',
        'age': 3,
        'gender': 'Female',
        'location': 'Bandung, 5km away',
        'photos': ['https://placekitten.com/401/601'],
        'verified': false,
      },
    ];
  }

  /// Like a cat
  static Future<void> likeCat(String catId) async {
    // TODO: Implement actual mutation when backend is ready
    // await client.from('likes').insert({'cat_id': catId});
    print('Liked cat: $catId');
  }

  /// Pass a cat
  static Future<void> passCat(String catId) async {
    // TODO: Implement actual mutation when backend is ready
    print('Passed cat: $catId');
  }

  // ========== Storage Methods (Placeholder) ==========

  /// Upload cat photo
  static Future<String> uploadCatPhoto(String filepath, String catId) async {
    // TODO: Implement actual upload when backend is ready
    /*
    final file = File(filepath);
    final path = 'cats/$catId/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await client.storage.from('cat-photos').upload(path, file);
    return client.storage.from('cat-photos').getPublicUrl(path);
    */
    
    // Placeholder
    print('Uploading photo for cat: $catId');
    return 'https://placekitten.com/400/600';
  }

  /// Upload user profile photo
  static Future<String> uploadUserPhoto(String filepath, String userId) async {
    // TODO: Implement actual upload when backend is ready
    print('Uploading photo for user: $userId');
    return 'https://i.pravatar.cc/150?img=1';
  }
}
