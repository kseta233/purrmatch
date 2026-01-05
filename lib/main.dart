import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/services/supabase_service.dart';
import 'core/services/firebase_service.dart';
import 'core/services/deep_link_service.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await _initializeServices();

  runApp(const PurrMatchApp());
}

/// Initialize all app services
Future<void> _initializeServices() async {
  try {
    // Initialize Supabase
    await SupabaseService.initialize();
    
    // Initialize Firebase
    await FirebaseService.initialize();
    
    // Initialize Deep Link service
    await DeepLinkService.initialize();
    
    print('All services initialized successfully');
  } catch (e) {
    print('Error initializing services: $e');
    // Continue app initialization even if some services fail
  }
}

class PurrMatchApp extends StatelessWidget {
  const PurrMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PurrMatch',
      debugShowCheckedModeBanner: false,
      
      // Theme configuration
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Follow system theme
      
      // Routing
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
      
      // Default transition
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
