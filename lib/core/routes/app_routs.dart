import 'package:flutter/material.dart';
import 'package:flutter_practical_test/features/favorites/presentation/pages/favorites_page.dart';
import '../../features/book_details/presentaion/pages/book_details_page.dart';
import '../transition/custome_fade_route.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String bookDetails = '/bookDetails';
  static const String favorites = '/favorites';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case bookDetails:
        return CustomFadeTransition(page: const BookDetails());
      case favorites:
        return CustomFadeTransition(page: const FavoritesPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
