import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertest/pages/GroupsPage_Tab.dart';
import 'package:fluttertest/providers/app_state_provider.dart';
import 'package:fluttertest/providers/navigation_provider.dart';
import 'AllCoursesPage.dart';
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
            return AllCoursesPage(
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
            if (index == 1) {
              // Navigate to AllCoursesPage when globe icon is clicked
              Navigator.pushNamed(context, '/all-courses');
            } else {
              // Normal tab navigation for other tabs
              navigation.setCurrentIndex(index);
            }
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        // Use sidebar layout for web/desktop/macbook (width > 800px)
        if (screenWidth > 800) {
          return _buildWebLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }

  // Web Layout with Sidebar
  Widget _buildWebLayout() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: Offset(2, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Logo/Brand Section
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5F299E), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.school,
                          color: Color(0xFF5F299E),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'MI SKILLS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Navigation Menu
                Expanded(
                  child: Consumer<NavigationProvider>(
                    builder: (context, navigation, child) {
                      return Column(
                        children: [
                          SizedBox(height: 20),
                          _buildSidebarItem(Icons.dashboard_outlined, 'Dashboard', 0, navigation.currentIndex == 0),
                          _buildSidebarItem(Icons.language_outlined, 'All Courses', 1, navigation.currentIndex == 1),
                          _buildSidebarItem(Icons.play_circle_outline, 'My Courses', 2, navigation.currentIndex == 2),
                          _buildSidebarItem(Icons.group_outlined, 'Groups', 3, navigation.currentIndex == 3),
                          _buildSidebarItem(Icons.person_outline, 'Profile', 4, navigation.currentIndex == 4),
                          
                          Divider(height: 40, color: Colors.grey[300]),
                          
                          // Additional Menu Items
                          _buildSidebarItem(Icons.favorite_outline, 'Favorites', -1, false, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                          }),
                          _buildSidebarItem(Icons.shopping_cart_outlined, 'Cart', -1, false, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                          }),
                        ],
                      );
                    },
                  ),
                ),
                
                // User Profile Section at Bottom
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[200]!)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF5F299E),
                        child: Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Student',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications_outlined, color: Colors.grey[600]),
                              onPressed: () {},
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.favorite_border, color: Colors.grey[600]),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
                              },
                            ),
                            SizedBox(width: 8),
                            Stack(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[600]),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                                  },
                                ),
                                if (_cartCount > 0)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        _cartCount > 99 ? '99+' : _cartCount.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Content Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(24),
                    child: _getCurrentTabContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Mobile Layout (unchanged)
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // Fixed App Bar that stays on top
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
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

  // Sidebar Menu Item
  Widget _buildSidebarItem(IconData icon, String title, int index, bool isSelected, {VoidCallback? onTap}) {
    return Consumer<NavigationProvider>(
      builder: (context, navigation, child) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onTap ?? () {
                if (index == 1) {
                  Navigator.pushNamed(context, '/all-courses');
                } else if (index >= 0) {
                  navigation.setCurrentIndex(index);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF5F299E).withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: isSelected ? Color(0xFF5F299E) : Colors.grey[600],
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Text(
                      title,
                      style: TextStyle(
                        color: isSelected ? Color(0xFF5F299E) : Colors.grey[700],
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
