import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/pages/AddToCart.dart';
import 'package:fluttertest/pages/CartPage.dart';
import 'package:fluttertest/pages/Dashboard.dart';
import 'package:fluttertest/pages/DevOP.dart';
import 'package:fluttertest/pages/DeveloperPage.dart';
import 'package:fluttertest/pages/DigitalMarketing.dart';
import 'package:fluttertest/pages/InterestBasedPage.dart';
import 'package:fluttertest/pages/LoginPage.dart';
import 'package:fluttertest/pages/SignUpPage.dart';
import 'package:fluttertest/pages/TesterPage.dart';
import 'package:fluttertest/providers/theme_provider.dart';
import 'package:fluttertest/providers/app_state_provider.dart';
import 'package:fluttertest/providers/navigation_provider.dart';
import 'package:fluttertest/providers/chat_provider.dart';
import 'package:fluttertest/services/favorites_service.dart';
import 'package:fluttertest/repositories/course_repository.dart';
import 'package:fluttertest/repositories/user_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // State Providers
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesService()),

        // Repository Providers
        Provider<CourseRepository>(create: (context) => CourseRepositoryImpl()),
        Provider<UserRepository>(create: (context) => UserRepositoryImpl()),
      ],
      child: const ScreenPage(),
    ),
  );
}

class ScreenPage extends StatelessWidget {
  const ScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          home: LoginPage(),
          routes: {
            '/loginpage': (context) => LoginPage(),
            '/signuppage': (context) => SignUpPage(),
            '/interestpage': (context) => InterestBasedPage(),
            '/developerpage': (context) => DeveloperPages(),
            '/testerpage': (context) => TesterPages(),
            '/digitalmarketingpage': (context) => DigitalMarketingPages(),
            '/devoppage': (context) => DevOpPages(),
            '/dashboard': (context) => Dashboard(),
            '/addtocart': (context) => AddToCartPage(
              courseTitle: 'Sample Course',
              courseAuthor: 'Sample Author',
              courseImage: 'assets/images/developer.png',
              coursePrice: '\$99.00',
            ),
            '/cart': (context) => CartPage(),
          },
        );
      },
    );
  }
}
