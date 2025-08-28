import 'package:flutter/material.dart';
import 'CourseDetailsPage.dart';

class AllCoursesPage extends StatefulWidget {
  final String selectedLanguage;

  const AllCoursesPage({super.key, required this.selectedLanguage});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter variables
  double _minRating = 0.0;
  double _maxPrice = 200.0;
  
  // Sample course data with ratings and prices
  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Flutter Development Fundamentals',
      'author': 'By John Carter',
      'image': 'assets/images/developer.png',
      'rating': 4.8,
      'price': 59.99,
      'accessDays': 80,
    },
    {
      'title': 'User Experience Design Fundamentals',
      'author': 'By John Carter',
      'image': 'assets/images/tester.jpg',
      'rating': 4.6,
      'price': 79.99,
      'accessDays': 80,
    },
    {
      'title': 'DevOps and Cloud Computing',
      'author': 'By John Carter',
      'image': 'assets/images/devop.jpg',
      'rating': 4.7,
      'price': 89.99,
      'accessDays': 90,
    },
    {
      'title': 'Software Testing and QA',
      'author': 'By John Carter',
      'image': 'assets/images/test.png',
      'rating': 4.5,
      'price': 69.99,
      'accessDays': 75,
    },
    {
      'title': 'Complete Flutter Development',
      'author': 'By Sarah Wilson',
      'image': 'assets/images/developer.png',
      'rating': 4.9,
      'price': 99.99,
      'accessDays': 120,
    },
    {
      'title': 'Digital Marketing Mastery',
      'author': 'By Mike Johnson',
      'image': 'assets/images/splash1.png',
      'rating': 4.4,
      'price': 49.99,
      'accessDays': 60,
    },
    {
      'title': 'Python for Data Science',
      'author': 'By Dr. Emily Chen',
      'image': 'assets/images/devop.jpg',
      'rating': 4.8,
      'price': 84.99,
      'accessDays': 100,
    },
    {
      'title': 'Web Design Fundamentals',
      'author': 'By Alex Rodriguez',
      'image': 'assets/images/homescreen.png',
      'rating': 4.3,
      'price': 54.99,
      'accessDays': 70,
    },
    {
      'title': 'Business Analytics',
      'author': 'By Jennifer Lee',
      'image': 'assets/images/tester.jpg',
      'rating': 4.6,
      'price': 74.99,
      'accessDays': 85,
    },
    {
      'title': 'Mobile App Design',
      'author': 'By David Kim',
      'image': 'assets/images/splash2.png',
      'rating': 4.7,
      'price': 64.99,
      'accessDays': 80,
    },
    {
      'title': 'Machine Learning Basics',
      'author': 'By Dr. Robert Smith',
      'image': 'assets/images/devop.png',
      'rating': 4.8,
      'price': 94.99,
      'accessDays': 110,
    },
    {
      'title': 'UI/UX Design with Figma',
      'author': 'By Maria Garcia',
      'image': 'assets/images/test.png',
      'rating': 4.5,
      'price': 59.99,
      'accessDays': 75,
    },
    {
      'title': 'Agile Project Management',
      'author': 'By Thomas Brown',
      'image': 'assets/images/splash2.png',
      'rating': 4.4,
      'price': 44.99,
      'accessDays': 65,
    },
    {
      'title': 'DevOps Engineering',
      'author': 'By Lisa Anderson',
      'image': 'assets/images/devop.png',
      'rating': 4.7,
      'price': 79.99,
      'accessDays': 90,
    },
  ];

  List<Map<String, dynamic>> get filteredCourses {
    return courses.where((course) {
      // Search filter
      bool matchesSearch = _searchQuery.isEmpty ||
          course['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course['author'].toLowerCase().contains(_searchQuery.toLowerCase());

      // Rating filter
      bool matchesRating = course['rating'] >= _minRating;

      // Price filter
      bool matchesPrice = course['price'] <= _maxPrice;

      return matchesSearch && matchesRating && matchesPrice;
    }).toList();
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
                children: [
                  Text('Minimum Rating: ${_minRating.toStringAsFixed(1)}'),
                  Slider(
                    value: _minRating,
                    min: 0.0,
                    max: 5.0,
                    divisions: 10,
                    onChanged: (value) {
                      setDialogState(() {
                        _minRating = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Maximum Price: \$${_maxPrice.toStringAsFixed(0)}'),
                  Slider(
                    value: _maxPrice,
                    min: 0.0,
                    max: 200.0,
                    divisions: 20,
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
                    Navigator.of(context).pop();
                  },
                  child: Text('Reset'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        
        // Use new design for web/desktop/mac (width > 800px)
        if (screenWidth > 800) {
          return _buildWebContent();
        } else {
          return _buildMobileLayout();
        }
      },
    );
  }

  // Web/Desktop/Mac Content - New Design matching the image
  Widget _buildWebContent() {
    return Column(
        children: [
          // Header Section - Purple background like in image
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row with back button, title and action icons
                Row(
                  children: [
                    // Back button - Left side
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 24),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                    ),
                    SizedBox(width: 16),
                    // Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Explore All Courses',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Start your learning journey with our comprehensive course collection',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Action icons - Top right
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border, color: Colors.white, size: 24),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 24),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Search bar - Below the header
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[600], size: 24),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search courses...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xFF8B5CF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.tune, color: Colors.white, size: 20),
                        onPressed: _showFilterDialog,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Course list
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 20),
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  final course = filteredCourses[index];
                  return _buildWebCourseCard(course);
                },
              ),
            ),
          ),
        ],
      );
  }

  // Web Course Card - Horizontal Layout like second image
  Widget _buildWebCourseCard(Map<String, dynamic> course) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
                  color: Colors.black.withOpacity(0.08),
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
                  courseTitle: course['title'],
                  courseAuthor: course['author'],
                  courseImage: course['image'],
                  progress: 0.0,
                  progressText: '0% completed',
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
                      image: AssetImage(course['image']),
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
                        course['title'],
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
                        'Build powerful ${course['title'].toLowerCase()} skills. Traditional, Advanced, Multimodal & Agentic AI with comprehensive learning path',
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
                            course['author'],
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
                            '${course['accessDays']} total hours',
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
                                  '${course['rating']}',
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
                        Icons.favorite_border,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),

                    SizedBox(height: 20),

                    // Start Course button and Price row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Start Course button - Left of price
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed( 
                              context, 
                              '/addtocart',
                              arguments: {
                                'courseTitle': course['title'],
                                'courseAuthor': course['author'],
                                'courseImage': course['image'],
                                'coursePrice': '₹499',
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5F299E),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: 2,
                            minimumSize: Size(0, 32),
                          ),
                          child: Text(
                            'Start Course',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        
                        // Price - Large and prominent like second image
                        Text(
                          '₹499',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Mobile Content - For use as tab content (no Scaffold/AppBar)
  Widget _buildMobileContent() {
    return SingleChildScrollView(
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
                      color: Colors.white.withOpacity(0.9),
                    ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Course list using new data but keeping mobile design
          ...filteredCourses.map((course) => Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: _buildCourseCard(
              context,
              imageAsset: course['image'],
              title: course['title'],
              author: course['author'],
            ),
          )),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Mobile Layout - Keep existing design unchanged
  Widget _buildMobileLayout() {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF5F299E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'All Courses',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Course list using new data but keeping mobile design
            ...filteredCourses.map((course) => Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: _buildCourseCard(
                context,
                imageAsset: course['image'],
                title: course['title'],
                author: course['author'],
              ),
            )),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String imageAsset,
    required String title,
    required String author,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(
              courseTitle: title,
              courseAuthor: author,
              courseImage: imageAsset,
              progress: 0.0,
              progressText: '0% completed',
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
                      splashColor: Colors.blue.withOpacity(0.1),
                      highlightColor: Colors.blue.withOpacity(0.05),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
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
                      image: DecorationImage(
                        image: AssetImage(imageAsset),
                        fit: BoxFit.cover,
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
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          author,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[600],
                          ),
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
                ],
              ),
            ),

            // Start Course Button (No Progress Bar)
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
                          courseTitle: title,
                          courseAuthor: author,
                          courseImage: imageAsset,
                          progress: 0.0,
                          progressText: '0% completed',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5F299E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    elevation: 2,
                    shadowColor: Color(0xFF5F299E).withOpacity(0.3),
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
