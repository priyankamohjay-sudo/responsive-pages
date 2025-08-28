import 'package:flutter/material.dart';
import 'CourseDetailsPage.dart';
import '../models/course.dart';
import '../services/favorites_service.dart';

class AllCoursesPageTab extends StatefulWidget {
  final String selectedLanguage;

  const AllCoursesPageTab({super.key, required this.selectedLanguage});

  @override
  State<AllCoursesPageTab> createState() => _AllCoursesPageTabState();
}

class _AllCoursesPageTabState extends State<AllCoursesPageTab> {
  final FavoritesService _favoritesService = FavoritesService();
  final TextEditingController _searchController = TextEditingController();

  // Filter variables
  double _minRating = 0.0;
  double _maxPrice = 200.0;
  String _searchQuery = '';

  // All courses data
  late List<Course> _allCourses;
  late List<Course> _filteredCourses;

  @override
  void initState() {
    super.initState();
    _favoritesService.addListener(_onFavoritesChanged);
    _initializeCourses();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _favoritesService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _initializeCourses() {
    _allCourses = [
      Course(
        title: 'Flutter Development Fundamentals',
        author: 'By John Carter',
        imageAsset: 'assets/images/developer.png',
        price: '\$89.99',
        rating: 4.8,
        students: '2.5k',
        duration: '90 days access',
        description: 'Learn Flutter development from scratch',
      ),
      Course(
        title: 'User Experience Design Fundamentals',
        author: 'By John Carter',
        imageAsset: 'assets/images/tester.jpg',
        price: '\$79.99',
        rating: 4.6,
        students: '1.8k',
        duration: '90 days access',
        description: 'Master UX design principles',
      ),
      Course(
        title: 'DevOps and Cloud Computing',
        author: 'By John Carter',
        imageAsset: 'assets/images/devop.jpg',
        price: '\$129.99',
        rating: 4.9,
        students: '3.2k',
        duration: '90 days access',
        description: 'Learn DevOps and cloud technologies',
      ),
      Course(
        title: 'Software Testing and QA',
        author: 'By John Carter',
        imageAsset: 'assets/images/test.png',
        price: '\$69.99',
        rating: 4.5,
        students: '1.5k',
        duration: '90 days access',
        description: 'Comprehensive software testing course',
      ),
      Course(
        title: 'Complete Flutter Development',
        author: 'By Sarah Wilson',
        imageAsset: 'assets/images/developer.png',
        price: '\$149.99',
        rating: 4.9,
        students: '4.1k',
        duration: '90 days access',
        description: 'Advanced Flutter development course',
      ),
      Course(
        title: 'Digital Marketing Mastery',
        author: 'By Mike Johnson',
        imageAsset: 'assets/images/splash1.png',
        price: '\$59.99',
        rating: 4.3,
        students: '2.8k',
        duration: '90 days access',
        description: 'Master digital marketing strategies',
      ),
      Course(
        title: 'Python for Data Science',
        author: 'By Dr. Emily Chen',
        imageAsset: 'assets/images/devop.jpg',
        price: '\$99.99',
        rating: 4.7,
        students: '3.5k',
        duration: '90 days access',
        description: 'Learn Python for data analysis',
      ),
      Course(
        title: 'Web Design Fundamentals',
        author: 'By Alex Rodriguez',
        imageAsset: 'assets/images/homescreen.png',
        price: '\$49.99',
        rating: 4.4,
        students: '1.9k',
        duration: '90 days access',
        description: 'Learn modern web design',
      ),
      Course(
        title: 'Business Analytics',
        author: 'By Jennifer Lee',
        imageAsset: 'assets/images/tester.jpg',
        price: '\$89.99',
        rating: 4.6,
        students: '2.1k',
        duration: '90 days access',
        description: 'Master business analytics',
      ),
      Course(
        title: 'Mobile App Design',
        author: 'By David Kim',
        imageAsset: 'assets/images/splash2.png',
        price: '\$79.99',
        rating: 4.5,
        students: '1.7k',
        duration: '90 days access',
        description: 'Design beautiful mobile apps',
      ),
      Course(
        title: 'Machine Learning Basics',
        author: 'By Dr. Robert Smith',
        imageAsset: 'assets/images/devop.png',
        price: '\$119.99',
        rating: 4.8,
        students: '2.9k',
        duration: '90 days access',
        description: 'Introduction to machine learning',
      ),
      Course(
        title: 'UI/UX Design with Figma',
        author: 'By Maria Garcia',
        imageAsset: 'assets/images/test.png',
        price: '\$69.99',
        rating: 4.7,
        students: '2.3k',
        duration: '90 days access',
        description: 'Master Figma for UI/UX design',
      ),
      Course(
        title: 'Agile Project Management',
        author: 'By Thomas Brown',
        imageAsset: 'assets/images/splash2.png',
        price: '\$59.99',
        rating: 4.4,
        students: '1.6k',
        duration: '90 days access',
        description: 'Learn agile methodologies',
      ),
      Course(
        title: 'DevOps Engineering',
        author: 'By Lisa Anderson',
        imageAsset: 'assets/images/devop.png',
        price: '\$139.99',
        rating: 4.9,
        students: '3.8k',
        duration: '90 days access',
        description: 'Advanced DevOps engineering',
      ),
    ];
    _filteredCourses = List.from(_allCourses);
  }

  void _onFavoritesChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _filterCourses() {
    setState(() {
      _filteredCourses = _allCourses.where((course) {
        // Search filter
        bool matchesSearch =
            _searchQuery.isEmpty ||
            course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            course.author.toLowerCase().contains(_searchQuery.toLowerCase());

        // Rating filter
        bool matchesRating = course.rating >= _minRating;

        // Price filter (extract numeric value from price string)
        double coursePrice =
            double.tryParse(
              course.price.replaceAll('\$', '').replaceAll(',', ''),
            ) ??
            0.0;
        bool matchesPrice = coursePrice <= _maxPrice;

        return matchesSearch && matchesRating && matchesPrice;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _searchQuery = query;
    _filterCourses();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('Filter Courses'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Minimum Rating: ${_minRating.toStringAsFixed(1)}'),
                  Slider(
                    value: _minRating,
                    min: 0.0,
                    max: 5.0,
                    divisions: 50,
                    onChanged: (value) {
                      setDialogState(() {
                        _minRating = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text('Maximum Price: \$${_maxPrice.toStringAsFixed(0)}'),
                  Slider(
                    value: _maxPrice,
                    min: 0.0,
                    max: 200.0,
                    divisions: 40,
                    onChanged: (value) {
                      setDialogState(() {
                        _maxPrice = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _minRating = 0.0;
                      _maxPrice = 200.0;
                    });
                    _filterCourses();
                    Navigator.of(context).pop();
                  },
                  child: Text('Reset'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _filterCourses();
                    Navigator.of(context).pop();
                  },
                  child: Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _toggleFavorite(String title, String author, String imageAsset) {
    final course = Course(
      title: title,
      author: author,
      imageAsset: imageAsset,
      progress: 0.0,
      progressText: '0% completed',
      duration: '90 days access',
    );

    _favoritesService.toggleFavorite(course);

    // Show feedback to user
    final isNowFavorite = _favoritesService.isFavorite(title, author);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isNowFavorite
              ? '$title added to favorites'
              : '$title removed from favorites',
        ),
        backgroundColor: isNowFavorite ? Colors.green : Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Use new design for web/desktop/mac (width > 800px)
        if (screenWidth > 800) {
          return _buildWebLayout();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }

  // Web/Desktop/Mac Layout - New Design matching the image
  Widget _buildWebLayout() {
    return Scaffold(
      body: Column(
        children: [
          // Header Section - Purple background like in image
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF8B5CF6), // Purple
                  Color(0xFF7C3AED), // Darker purple
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row with title and icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Explore All Courses',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.favorite_outline, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                            SizedBox(width: 8),
                            IconButton(
                              icon: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 28),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Subtitle
                    Text(
                      'Start your learning journey with our comprehensive course collection',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 24),
                    // Search bar and filter
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search courses...',
                                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              ),
                              onChanged: _onSearchChanged,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          height: 56,
                          width: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.tune, color: Colors.white, size: 24),
                            onPressed: () {
                              // Show filter options
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content Section
          Expanded(
            child: Container(
              color: Colors.grey[50],
              child: ListView.separated(
                padding: EdgeInsets.all(24),
                itemCount: _filteredCourses.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final course = _filteredCourses[index];
                  return _buildWebCourseCard(course);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Web Course Card - Horizontal Layout like second image
  Widget _buildWebCourseCard(Course course) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                  courseTitle: course.title,
                  courseAuthor: course.author,
                  courseImage: course.imageAsset,
                  progress: course.progress,
                  progressText: course.progressText,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                // Course Image - Left side (larger like in second image)
                Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(course.imageAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),

                // Course Details - Center (like second image layout)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course Title - Larger and bold
                      Text(
                        course.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),

                      // Course Description/Subtitle
                      Text(
                        'Build powerful ${course.title.toLowerCase()} skills. Traditional, Advanced, Multimodal & Agentic AI with comprehensive learning path',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 12),

                      // Author and metadata
                      Row(
                        children: [
                          Text(
                            'By ${course.author}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '• 1 other',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Updated date and course info
                      Row(
                        children: [
                          Text(
                            'Updated August 2025',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            course.duration,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '118 lectures',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'All Levels',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Rating and badge
                      Row(
                        children: [
                          // Rating
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF3CD),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${course.rating}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFD97706),
                                  ),
                                ),
                                SizedBox(width: 2),
                                Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
                                Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
                                Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
                                Icon(Icons.star, color: Color(0xFFFFD700), size: 12),
                                Icon(Icons.star_half, color: Color(0xFFFFD700), size: 12),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '(106)',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          SizedBox(width: 12),
                          // Highest Rated badge
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFE4B5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Highest Rated',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Price and Action - Right side (like second image)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite button - Top right
                    IconButton(
                      icon: Icon(
                        _favoritesService.isFavorite(course.title, course.author)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favoritesService.isFavorite(course.title, course.author)
                            ? Colors.red
                            : Colors.grey[400],
                        size: 24,
                      ),
                      onPressed: () => _toggleFavorite(course.title, course.author, course.imageAsset),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),

                    SizedBox(height: 20),

                    // Price - Large and prominent like second image
                    Text(
                      course.price,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Mobile Layout - Match home screen design
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button like home screen
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Back button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Title
                  Expanded(
                    child: Text(
                      'All Courses',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5F299E), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore All Courses',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Start your learning journey with our comprehensive course collection',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Search and Filter Section
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Search courses...',
                                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF5F299E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: _showFilterDialog,
                            icon: Icon(Icons.filter_list, color: Colors.white),
                            tooltip: 'Filter courses',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Results count
                    Text(
                      '${_filteredCourses.length} courses found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Dynamic course list
                    ..._filteredCourses.map(
                      (course) => Column(
                        children: [
                          _buildCourseCard(context, course: course),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, {required Course course}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(
              courseTitle: course.title,
              courseAuthor: course.author,
              courseImage: course.imageAsset,
              progress: course.progress,
              progressText: course.progressText,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.blue.withValues(alpha: 0.1),
      highlightColor: Colors.blue.withValues(alpha: 0.05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image and Title Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        course.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(
                              Icons.school,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Course Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          course.author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[600],
                          ),
                        ),
                        SizedBox(height: 6),
                        // Rating and Price Row
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(
                              course.rating.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              course.price,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5F299E),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEF3C7), // Light yellow background
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFFF59E0B), // Yellow border
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: Color(0xFFD97706), // Amber color
                              ),
                              SizedBox(width: 4),
                              Text(
                                '90 days access',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFD97706), // Amber color
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Heart Icon for Favorites
                  IconButton(
                    icon: Icon(
                      _favoritesService.isFavorite(course.title, course.author)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color:
                          _favoritesService.isFavorite(
                            course.title,
                            course.author,
                          )
                          ? Colors.red
                          : Colors.grey[400],
                      size: 24,
                    ),
                    onPressed: () => _toggleFavorite(
                      course.title,
                      course.author,
                      course.imageAsset,
                    ),
                    tooltip:
                        _favoritesService.isFavorite(
                          course.title,
                          course.author,
                        )
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                  ),
                ],
              ),
            ),

            // Start Course Button
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailsPage(
                          courseTitle: course.title,
                          courseAuthor: course.author,
                          courseImage: course.imageAsset,
                          progress: course.progress,
                          progressText: course.progressText,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF5F299E),
                    side: BorderSide(color: Color(0xFF5F299E), width: 1.5),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 2,
                    shadowColor: Color(0xFF5F299E).withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Start Course',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
