import 'package:flutter/material.dart';
import 'OfferPage.dart';
import 'CategoriesPage.dart';
import 'SubcategoryPage.dart';
import 'AllCoursesPage_Tab.dart';
import '../services/categories_service.dart';

class HomePageTab extends StatefulWidget {
  final String selectedLanguage;

  const HomePageTab({super.key, required this.selectedLanguage});

  @override
  State<HomePageTab> createState() => _HomePageTabState();
}

class _HomePageTabState extends State<HomePageTab>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Page controller for offers
  late PageController _offersPageController;
  int _currentOfferIndex = 0;

  // Page controller for categories
  late PageController _categoriesPageController;
  int _currentCategoryIndex = 0;

  // Page controller for progress cards
  late PageController _progressPageController;
  int _currentProgressIndex = 0;

  // Categories data
  final CategoriesService _categoriesService = CategoriesService();
  List<CategoryModel> _categories = [];
  bool _categoriesLoading = true;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize page controllers
    _offersPageController = PageController();
    _categoriesPageController = PageController();
    _progressPageController = PageController();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();

    // Load categories
    _loadCategories();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _offersPageController.dispose();
    _categoriesPageController.dispose();
    _progressPageController.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _categoriesService.getCategories();
      if (mounted) {
        setState(() {
          _categories = categories; // Show all categories in scrollable v
          _categoriesLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _categoriesLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey[50]!, Colors.white, Colors.grey[50]!],
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // Welcome Header with Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildWelcomeHeader(),
                ),
              ),
              const SizedBox(height: 20),

              // Special Offers Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSectionHeader(
                  'Special Offers',
                  'View All',
                  Icons.local_offer_rounded,
                ),
              ),
              const SizedBox(height: 12),

              // Special Offers Horizontal List
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildSpecialOffersSection(),
                ),
              ),
              const SizedBox(height: 20),

              // Categories Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSectionHeader(
                  'All Category',
                  'View All',
                  Icons.category_rounded,
                ),
              ),
              const SizedBox(height: 12),

              // Categories Grid
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildCategoriesSection(),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Stats Cards with Scale Animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildQuickStatsSection(),
                ),
              ),
              const SizedBox(height: 20),

              // Featured Course Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSectionHeader(
                  'Featured Course',
                  'View All',
                  Icons.star_rounded,
                ),
              ),
              const SizedBox(height: 12),

              // Enhanced Featured Course Cards (2 courses)
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildFeaturedCoursesSection(),
                ),
              ),
              const SizedBox(height: 24),

              // Popular Courses Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSectionHeader(
                  'Popular Courses',
                  'View All', 
                  Icons.trending_up_rounded,
                ),
              ),
              const SizedBox(height: 12),

              // Popular Courses List
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildCompactCourseCard(
                        'Java Programming Fundamentals',
                        '\$25.00',
                        'assets/images/java.png',
                        4.5,
                        '2.5k',
                      ),
                      _buildCompactCourseCard(
                        'DevOps Engineering',
                        '\$18.00',
                        'assets/images/devop.png',
                        4.7,
                        '1.8k',
                      ),
                      _buildCompactCourseCard(
                        'Software Testing',
                        '\$35.00',
                        'assets/images/test.png',
                        4.9,
                        '3.2k',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Learning Progress Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: _buildProgressSection(),
                ),
              ),
              const SizedBox(height: 24),

              // Recommended Courses Section
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildSectionHeader(
                  'Recommended for You',
                  'View All',
                  Icons.recommend_rounded,
                ),
              ),
              const SizedBox(height: 12),

              // Recommended Courses
              FadeTransition(
                opacity: _fadeAnimation,
                child: _buildRecommendedCourses(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // Welcome Header Section
  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A4C93), // Deep purple
            Color(0xFF8B5CF6), // Bright purple
            Color(0xFFA855F7), // Light purple
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 119, 95, 53).withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Continue your Flutter journey',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(Icons.school_rounded, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  // Quick Stats Section
  Widget _buildQuickStatsSection() {
    return SizedBox(
      height: 90, // Even more compact height
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildStatCard(
              '12',
              'Courses',
              Icons.school_rounded,
              Colors.blue[600]!,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              '48h',
              'Learning',
              Icons.access_time_rounded,
              Colors.green[600]!,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildStatCard(
              '4.8',
              'Rating',
              Icons.star_rounded,
              Color(0xFF5F299E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container( 
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(

            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16), 
          ),
          const SizedBox(height: 3), 
          Text(
            value,
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12, 
              color: Colors.grey[600],
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Featured Courses Section (2 courses)
  Widget _buildFeaturedCoursesSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    final featuredCourses = [
      {
        'title': 'Flutter Development Fundamentals',
        'price': '\$100.00',
        'rating': '4.8',
        'image': 'assets/images/developer.png',
        'gradient': [Color(0xFF5F299E), Color(0xFFFFD700)],
      },
      {
        'title': 'UI/UX Design Masterclass',
        'price': '\$85.00',
        'rating': '4.9',
        'image': 'assets/images/test.png',
        'gradient': [Color(0xFFEC4899), Color(0xFF06B6D4)],
      },
    ];

    if (isMobile) {
      // Mobile: Show courses vertically (unchanged)
      return Column(
        children: featuredCourses.map((course) => 
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _buildFeaturedCourseCard(
              title: course['title'] as String,
              price: course['price'] as String,
              rating: course['rating'] as String,
              image: course['image'] as String,
              gradient: course['gradient'] as List<Color>,
            ),
          ),
        ).toList(),
      );
    } else {
      // Web: Show 2 courses side by side
      return Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: _buildFeaturedCourseCard(
                title: featuredCourses[0]['title'] as String,
                price: featuredCourses[0]['price'] as String,
                rating: featuredCourses[0]['rating'] as String,
                image: featuredCourses[0]['image'] as String,
                gradient: featuredCourses[0]['gradient'] as List<Color>,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: _buildFeaturedCourseCard(
                title: featuredCourses[1]['title'] as String,
                price: featuredCourses[1]['price'] as String,
                rating: featuredCourses[1]['rating'] as String,
                image: featuredCourses[1]['image'] as String,
                gradient: featuredCourses[1]['gradient'] as List<Color>,
              ),
            ),
          ),
        ],
      );
    }
  }

  // Featured Course Card
  Widget _buildFeaturedCourseCard({
    required String title,
    required String price,
    required String rating,
    required String image,
    required List<Color> gradient,
  }) {
    return Container(
      height: 180, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: gradient,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          price,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFF5F299E),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundImage: AssetImage(
                          'assets/images/homescreen.png',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Robert Ransdell',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      Spacer(),
                      Text(
                        '1,847 Students',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced Section Header
  Widget _buildSectionHeader(String title, String actionText, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5F299E), Color(0xFFFFD700)],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF5F299E).withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Navigate to appropriate pages based on section
            if (title == 'Special Offers') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OfferPage()),
              );
            } else if (title == 'All Category') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesPage()),
              );
            } else if (title == 'Popular Courses' || title == 'Recommended for You' || title == 'Featured Course') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllCoursesPageTab(selectedLanguage: 'Flutter')),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF5F299E).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFF5F299E).withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              actionText,
              style: const TextStyle(
                color: Color(0xFF5F299E),
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Categories Section - Similar to Special Offers
  Widget _buildCategoriesSection() {
    if (_categoriesLoading) {
      return SizedBox(
        height: 160,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF5F299E)),
          ),
        ),
      );
    }

    if (_categories.isEmpty) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.category_outlined, size: 48, color: Colors.grey[400]),
              SizedBox(height: 8),
              Text(
                'No categories available',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final categoriesPerPage = isMobile ? 2 : 3; // Mobile: 2, Web: 3 categories per slide

    return Column(
      children: [
        // Categories PageView - Responsive
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _categoriesPageController,
            onPageChanged: (index) {
              setState(() {
                _currentCategoryIndex = index;
              });
            },
            itemCount: (_categories.length / categoriesPerPage).ceil(),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * categoriesPerPage;
              final endIndex = (startIndex + categoriesPerPage).clamp(0, _categories.length);
              final pageCategories = _categories.sublist(startIndex, endIndex);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: pageCategories.asMap().entries.map((entry) {
                    final categoryIndex = entry.key;
                    final category = entry.value;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: categoryIndex < pageCategories.length - 1 ? 8 : 0,
                          left: categoryIndex > 0 ? 8 : 0,
                        ),
                        child: _buildCategoryCard(category),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),

        // Page Indicators for Categories
        if ((_categories.length / categoriesPerPage).ceil() > 1) ...[
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              (_categories.length / categoriesPerPage).ceil(),
              (index) => GestureDetector(
                onTap: screenWidth >= 768 ? () {
                  // Only enable tap functionality for web/desktop screens
                  _categoriesPageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } : null,
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentCategoryIndex == index
                        ? Color(0xFF5F299E)
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  // Enhanced Category Card - Similar to Special Offers Style
  Widget _buildCategoryCard(CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubcategoryPage(
              categoryName: category.name,
              categoryIcon: category.icon.toString(),
              categoryColor: category.color,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [category.color.withValues(alpha: 0.8), category.color],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.color.withValues(alpha: 0.3),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with background
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(category.icon, size: 28, color: Colors.white),
              ),
              SizedBox(height: 12),

              // Category name
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),

              // Course count with badge style
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${category.courseCount} courses',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Compact Course Card for Popular Courses
  Widget _buildCompactCourseCard(
    String title,
    String price,
    String imagePath,
    double rating,
    String students,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;
    
    return Container(
      width: isWeb ? 180 : 150, // Match recommended course size on web
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80, // Reduced height
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        color: Color(0xFF5F299E),
                        fontWeight: FontWeight.bold,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFF5F299E),
                          size: 10,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$students students',
                      style: TextStyle(fontSize: 8, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Learning Progress Section with Slider
  Widget _buildProgressSection() {
    final screenWidth = MediaQuery.of(context).size.width;

    final progressData = [
      {
        'title': 'Flutter Development Course',
        'progress': 0.75,
        'percentage': '75%',
        'completed': '3 of 4 modules completed',
        'gradient': [Colors.purple[400]!, Colors.purple[300]!],
        'icon': Icons.trending_up_rounded,
      },
      {
        'title': 'UI/UX Design Fundamentals',
        'progress': 0.60,
        'percentage': '60%',
        'completed': '6 of 10 lessons completed',
        'gradient': [Colors.blue[400]!, Colors.blue[300]!],
        'icon': Icons.design_services_rounded,
      },
      {
        'title': 'Data Structures & Algorithms',
        'progress': 0.40,
        'percentage': '40%',
        'completed': '4 of 10 chapters completed',
        'gradient': [Colors.green[400]!, Colors.green[300]!],
        'icon': Icons.code_rounded,
      },
      {
        'title': 'Mobile App Development',
        'progress': 0.85,
        'percentage': '85%',
        'completed': '8 of 10 projects completed',
        'gradient': [Colors.orange[400]!, Colors.orange[300]!],
        'icon': Icons.phone_android_rounded,
      },
    ];

    // Both mobile and web: Show progress cards in slider with 2-2 per slide
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _progressPageController,
            onPageChanged: (index) {
              setState(() {
                _currentProgressIndex = index;
              });
            },
            itemCount: (progressData.length / 2).ceil(),
            itemBuilder: (context, pageIndex) {
              final startIndex = pageIndex * 2;
              final endIndex = (startIndex + 2).clamp(0, progressData.length);
              final pageProgress = progressData.sublist(startIndex, endIndex);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: pageProgress.asMap().entries.map((entry) {
                    final progressIndex = entry.key;
                    final progress = entry.value;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: progressIndex < pageProgress.length - 1 ? 8 : 0,
                          left: progressIndex > 0 ? 8 : 0,
                        ),
                        child: _buildProgressCard(
                          title: progress['title'] as String,
                          progress: progress['progress'] as double,
                          percentage: progress['percentage'] as String,
                          completed: progress['completed'] as String,
                          gradient: progress['gradient'] as List<Color>,
                          icon: progress['icon'] as IconData,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
          // Progress indicators
          if ((progressData.length / 2).ceil() > 1) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                (progressData.length / 2).ceil(),
                (index) => GestureDetector(
                  onTap: screenWidth >= 768 ? () {
                    // Only enable tap functionality for web/desktop screens
                    _progressPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } : null,
                  child: Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentProgressIndex == index
                          ? Color(0xFF5F299E)
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      );
    }

  // Individual Progress Card
  Widget _buildProgressCard({
    required String title,
    required double progress,
    required String percentage,
    required String completed,
    required List<Color> gradient,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient[0].withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  percentage,
                  style: TextStyle(
                    color: gradient[0],
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            completed,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // Recommended Courses
  Widget _buildRecommendedCourses() {
    return SizedBox(
      height: 170, // More compact height
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _buildEnhancedCourseCard(
            'Advanced Flutter',
            '\$45.00',
            'assets/images/developer.png',
            4.9,
            '2.1k',
            Colors.blue[600]!,
          ),
          _buildEnhancedCourseCard(
            'Data Structures',
            '\$55.00',
            'assets/images/java.png',
            4.8,
            '1.9k',
            Colors.green[600]!,
          ),
          _buildEnhancedCourseCard(
            'Mobile App Development',
            '\$65.00',
            'assets/images/devop.png',
            4.7,
            '3.2k',
            Color(0xFF5F299E),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedCourseCard(
    String title,
    String price,
    String imagePath,
    double rating,
    String students,
    Color accentColor,
  ) {
    return Container(
      width: 180, // More compact width
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 85, // More compact height
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    accentColor.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        price,
                        style: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          color: Color(0xFF5F299E),
                          size: 13,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '$students students',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Special Offers Section
  Widget _buildSpecialOffersSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768; // Mobile breakpoint

    final offers = [
      {
        'percentage': '35%',
        'title': 'Today\'s Special!',
        'subtitle': 'Get discount for every course',
        'backgroundColor': const Color(0xFF8B5CF6),
        'imageAsset': 'assets/images/developer.png',
      },
      {
        'percentage': '25%',
        'title': 'Friday Special!',
        'subtitle': 'Limited time coding courses',
        'backgroundColor': const Color(0xFFEC4899),
        'imageAsset': 'assets/images/tester.jpg',
      },
      {
        'percentage': '30%',
        'title': 'New Promo!',
        'subtitle': 'Design course bundle discount',
        'backgroundColor': const Color(0xFF06B6D4),
        'imageAsset': 'assets/images/devop.jpg',
      },
      {
        'percentage': '45%', 
        'title': 'Weekend Special!',
        'subtitle': 'Biggest programming discount',
        'backgroundColor': const Color(0xFFF59E0B),
        'imageAsset': 'assets/images/splash1.png',
      },
    ];

    return Column(
      children: [
        // Responsive offer slider with proper height for mobile
        SizedBox(
          height: isMobile ? 220 : 160, // Increased height for mobile to fit content properly
          child: PageView.builder(
            controller: _offersPageController,
            physics: const BouncingScrollPhysics(), // Better scroll physics for mobile
            onPageChanged: (index) {
              setState(() {
                _currentOfferIndex = index;
              });
            },
            itemCount: isMobile ? offers.length : (offers.length / 2).ceil(), // Web shows 2 cards per slide
            itemBuilder: (context, index) {
              if (isMobile) {
                // Mobile: 1 card per slide horizontally
                final offer = offers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: _buildOfferCard(
                    percentage: offer['percentage'] as String? ?? '',
                    title: offer['title'] as String? ?? '',
                    subtitle: offer['subtitle'] as String? ?? '',
                    backgroundColor: offer['backgroundColor'] as Color? ?? Colors.grey,
                    imageAsset: offer['imageAsset'] as String? ?? '',
                    shapeIndex: index,
                    isMobile: isMobile,
                  ),
                );
              } else {
                // Web: 2 cards per slide
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      // First card
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: _buildOfferCard(
                            percentage: offers[index * 2]['percentage'] as String? ?? '',
                            title: offers[index * 2]['title'] as String? ?? '',
                            subtitle: offers[index * 2]['subtitle'] as String? ?? '',
                            backgroundColor: offers[index * 2]['backgroundColor'] as Color? ?? Colors.grey,
                            imageAsset: offers[index * 2]['imageAsset'] as String? ?? '',
                            shapeIndex: index * 2,
                            isMobile: isMobile,
                          ),
                        ),
                      ),
                      // Second card (if exists)
                      if (index * 2 + 1 < offers.length)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: _buildOfferCard(
                              percentage: offers[index * 2 + 1]['percentage'] as String? ?? '',
                              title: offers[index * 2 + 1]['title'] as String? ?? '',
                              subtitle: offers[index * 2 + 1]['subtitle'] as String? ?? '',
                              backgroundColor: offers[index * 2 + 1]['backgroundColor'] as Color? ?? Colors.grey,
                              imageAsset: offers[index * 2 + 1]['imageAsset'] as String? ?? '',
                              shapeIndex: index * 2 + 1,
                              isMobile: isMobile,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        SizedBox(height: isMobile ? 16 : 12), // More spacing on mobile
        // Dots indicator
        _buildOffersDotsIndicator(isMobile ? offers.length : (offers.length / 2).ceil(), isMobile),
      ],
    );
  }

  // Dots Indicator for Offers
  Widget _buildOffersDotsIndicator(int itemCount, bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => GestureDetector(
          onTap: isMobile ? null : () {
            // Only enable tap functionality for web/desktop screens
            _offersPageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 4), // More spacing on mobile
            width: _currentOfferIndex == index ? (isMobile ? 24 : 20) : (isMobile ? 10 : 8), // Bigger dots on mobile
            height: isMobile ? 10 : 8, // Bigger height on mobile
            decoration: BoxDecoration(
              color: _currentOfferIndex == index
                  ? const Color(0xFF5F299E)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(isMobile ? 5 : 4), // Bigger radius on mobile
            ),
          ),
        ),
      ),
    );
  }

  String _generateCouponCode(String percentage) {
    // Generate coupon codes based on percentage
    switch (percentage) {
      case '25%':
        return 'FRIDAY25';
      case '30%':
        return 'DESIGN30';
      case '35%':
        return 'TODAY35';
      default:
        return 'SAVE${percentage.replaceAll('%', '')}';
    }
  }

  // Full width Offer Card for PageView
  Widget _buildOfferCard({
    required String percentage,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required String imageAsset,
    required int shapeIndex,
    bool isMobile = false,
  }) {
    String couponCode = _generateCouponCode(percentage);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 8), // No margin on mobile for full width appearance
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(isMobile ? 20 : 16), // Bigger radius on mobile
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isMobile ? 20 : 16), // Match main container radius
              gradient: LinearGradient(
                colors: [
                  backgroundColor,
                  backgroundColor.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Decorative background shapes
          _buildBackgroundShapes(shapeIndex, backgroundColor),
          // Content
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 16), // More padding on mobile
            child: Row(
              children: [
                // Left side - Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween, // Center content on mobile
                    children: [
                      // Top content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            percentage,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 32 : 24, // Bigger on mobile
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isMobile ? 8 : 6), // More spacing on mobile
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 16 : 14, // Bigger on mobile
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: isMobile ? 6 : 4), // More spacing on mobile
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 14 : 12, // Bigger on mobile
                              fontWeight: FontWeight.w500,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Coupon code box
                      Container(
                        margin: EdgeInsets.only(top: isMobile ? 12 : 8), // More margin on mobile
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 8, // More padding on mobile
                          vertical: isMobile ? 6 : 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(isMobile ? 8 : 6), // Bigger radius on mobile
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_offer,
                              color: backgroundColor,
                              size: isMobile ? 16 : 14, // Bigger icon on mobile
                            ),
                            SizedBox(width: isMobile ? 6 : 4), // More spacing on mobile
                            Text(
                              couponCode,
                              style: TextStyle(
                                color: backgroundColor,
                                fontSize: isMobile ? 13 : 11, // Bigger text on mobile
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: isMobile ? 16 : 12), // More spacing on mobile
                // Right side - Image
                Container(
                  width: isMobile ? 100 : 80, // Bigger image on mobile
                  height: isMobile ? 100 : 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isMobile ? 16 : 12), // Bigger radius on mobile
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isMobile ? 16 : 12), // Match container radius
                    child: Image.asset(
                      imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(isMobile ? 16 : 12), // Match container radius
                          ),
                          child: const Icon(
                            Icons.local_offer,
                            color: Colors.white,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Background shapes for offer cards
  Widget _buildBackgroundShapes(int shapeIndex, Color backgroundColor) {
    switch (shapeIndex % 4) {
      case 0: // Circles and dots pattern - positioned in center blank space
        return Positioned(
          top: 15,
          left: 140, // Position in the center area between text and image
          right: 100, // Leave space for the image
          bottom: 15,
          child: Stack(
            children: [
              // Large decorative circle in center
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.25),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 2,
                    ),
                  ),
                ),
              ),
              // Medium circle with gradient
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.3),
                        Colors.white.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
              ),
              // Small decorative dots
              Positioned(
                top: 35,
                right: 20,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 30,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ],
          ),
        );
      case 1: // Bubble and geometric pattern - positioned in center blank space (Pink card)
        return Positioned(
          top: 15,
          left: 130, // Position in the center area between text and image
          right: 90, // Leave space for the image
          bottom: 15,
          child: Stack(
            children: [
              // Large bubble shape (like cyan card style)
              Positioned(
                top: 15,
                left: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.25),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.15),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.1),
                        blurRadius: 12,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
              // Medium bubble
              Positioned(
                top: 30,
                right: 15,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.2),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.08),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
              // Small accent bubble
              Positioned(
                bottom: 20,
                left: 30,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.18),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Tiny floating dots
              Positioned(
                top: 45,
                left: 40,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
              ),
              Positioned(
                bottom: 35,
                right: 30,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.12),
                  ),
                ),
              ),
            ],
          ),
        );
      case 2: // Infinity and tech shapes - positioned in center blank space (Cyan card)
        return Positioned(
          top: 12,
          left: 140, // Position in the center area between text and image
          right: 100, // Leave space for the image
          bottom: 12,
          child: Stack(
            children: [
              // Infinity symbol shape
              Positioned(
                top: 12,
                left: 6,
                child: Container(
                  width: 45,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.28),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Hexagonal tech shape
              Positioned(
                bottom: 10,
                right: 6,
                child: Transform.rotate(
                  angle: 0.3,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(14),
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.15),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Small gear-like accent
              Positioned(
                top: 38,
                right: 20,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.32),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(2),
                      bottomLeft: Radius.circular(2),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                      width: 1,
                    ),
                  ),
                ),
              ),
              // Circuit-like line accent
              Positioned(
                bottom: 28,
                left: 12,
                child: Container(
                  width: 20,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Container(
                        width: 4,
                        height: 4,
                        margin: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 3: // Layered wave patterns
        return Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Large wave shape
                Positioned(
                  top: -25,
                  right: -35,
                  child: Container(
                    width: 130,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(65),
                        topRight: Radius.circular(45),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.1),
                          blurRadius: 15,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                // Medium curved element
                Positioned(
                  bottom: -25,
                  left: -25,
                  child: Container(
                    width: 90,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45),
                        bottomLeft: Radius.circular(35),
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.white.withValues(alpha: 0.15),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                // Small flowing accent
                Positioned(
                  top: 45,
                  left: 45,
                  child: Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
