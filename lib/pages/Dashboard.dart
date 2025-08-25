import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/pages/GroupsPage_Tab.dart';
import 'package:fluttertest/providers/app_state_provider.dart';
import 'package:fluttertest/providers/navigation_provider.dart';
import 'AllCoursesPage_Tab.dart';
import 'HomePage_Tab.dart';
import 'CoursesPage_Tab.dart';
import 'ProfilePage_Tab.dart';
import 'CartPage.dart';
import 'AddToCart.dart';
import 'FavoritesPage.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  final CartService _cartService = CartService();
  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // Initialize cart count and listen to changes
    _cartCount = _cartService.cartCount;
    _cartService.addListener(_onCartChanged);
  }


  void _onCartChanged() {
    if (mounted) {
      setState(() {
        _cartCount = _cartService.cartCount;
      });
    }
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final appState = Provider.of<AppStateProvider>(context, listen: false);
      appState.setSelectedRole(args['role'] ?? '');
      appState.setSelectedLanguage(args['language'] ?? '');
    }
  }

  // Method to get current tab content with animation
  Widget _getCurrentTabContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _getTabWidget(),
    );
  }

  Widget _getTabWidget() {
    return Consumer2<AppStateProvider, NavigationProvider>(
      builder: (context, appState, navigation, child) {
        final currentIndex = navigation.currentIndex;
        final selectedLanguage = appState.selectedLanguage;
        final selectedRole = appState.selectedRole;

        switch (currentIndex) {
          case 0:
            return HomePageTab(
              key: const ValueKey(0),
              selectedLanguage: selectedLanguage,
            );
          case 1:
            return AllCoursesPageTab(
              key: const ValueKey(1),
              selectedLanguage: selectedLanguage,
            );
          case 2:
            return CoursesPageTab(
              key: const ValueKey(2),
              selectedLanguage: selectedLanguage,
            );
          case 3:
            return GroupPageTab(
              key: const ValueKey(3),
              selectedLanguage: selectedLanguage,
            );
          case 4:
            return ProfilePageTab(
              key: const ValueKey(4),
              selectedRole: selectedRole,
              selectedLanguage: selectedLanguage,
            );
          default:
            return HomePageTab(
              key: const ValueKey(0),
              selectedLanguage: selectedLanguage,
            );
        }
      },
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return GestureDetector(
      onTap: () => HapticFeedback.lightImpact(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildFavoritesIcon() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FavoritesPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.favorite_border, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildCartIcon() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 22),
            if (_cartCount > 0)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(),
                  child: Text(
                    _cartCount > 99 ? '99+' : _cartCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      height: 0.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    return Consumer<NavigationProvider>(
      builder: (context, navigation, child) {
        final isSelected = navigation.currentIndex == index;

        return GestureDetector(
          onTap: () {
            navigation.setCurrentIndex(index);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.25)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.7),
              size: isSelected ? 28 : 24,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Fixed App Bar that stays on top
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Color.fromARGB(255, 240, 189, 101),
                Color(0xFF5F299E),

                Color(0xFF5F299E),
                Color(0xFF5F299E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),

                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildHeaderIcon(Icons.notifications_outlined),
                      const SizedBox(width: 12),
                      _buildFavoritesIcon(),
                      const SizedBox(width: 12),
                      _buildCartIcon(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Separate Greeting Card with full curves
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   width: double.infinity,
            //   height: 140,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [
            //         Colors.blue[100]!,
            //         Colors.blue[400]!,
            //         Colors.blue[600]!,
            //       ],
            //       begin: Alignment.topLeft,
            //       end: Alignment.bottomRight,
            //     ),
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   padding: const EdgeInsets.all(24),
            //   child: FadeTransition(
            //     opacity: _fadeAnimation,
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           'Hi Robert Ransdell 👋',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 28,
            //             fontWeight: FontWeight.bold,
            //             letterSpacing: 0.5,
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           'Ready to master $selectedLanguage today?',
            //           style: TextStyle(
            //             color: Colors.white.withValues(alpha: 0.9),
            //             fontSize: 16,
            //             fontWeight: FontWeight.w400,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // Search Bar Section
            // Container(
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(30),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withValues(alpha: 0.1),
            //         spreadRadius: 0,
            //         blurRadius: 10,
            //         offset: const Offset(0, 5),
            //       ),
            //     ],
            //   ),
            //   child: TextField(
            //     controller: _searchController,
            //     decoration: InputDecoration(
            //       hintText: 'What do you want to learn today?',
            //       hintStyle: TextStyle(
            //         color: Colors.grey[500],
            //         fontSize: 16,
            //       ),
            //       border: InputBorder.none,
            //       prefixIcon: Icon(
            //         Icons.search,
            //         color: Colors.blue[600],
            //         size: 24,
            //       ),
            //       suffixIcon: Icon(
            //         Icons.tune,
            //         color: Colors.grey[400],
            //         size: 20,
            //       ),
            //       contentPadding: const EdgeInsets.symmetric(vertical: 16),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 20),

            // Content Section with enhanced transition
            Transform.translate(
              offset: const Offset(0, -25),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: _getCurrentTabContent(),
              ),
            ),
          ],
        ),
      ),

      // Enhanced Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5F299E), Color(0xFF5F299E), Color(0xFF5F299E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF5F299E).withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home_rounded, 0),
                _buildNavItem(
                  Icons.language_rounded,
                  1,
                ), // Globe icon for All Courses
                _buildNavItem(Icons.play_circle_fill, 2),
                _buildNavItem(Icons.groups, 3), // Groups icon
                _buildNavItem(Icons.person_rounded, 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
