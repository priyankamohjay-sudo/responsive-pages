import 'package:flutter/material.dart';
import 'CourseDetailsPage.dart';

class AllCoursesPage extends StatefulWidget {
  const AllCoursesPage({super.key});

  @override
  State<AllCoursesPage> createState() => _AllCoursesPageState();
}

class _AllCoursesPageState extends State<AllCoursesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
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
    if (_searchQuery.isEmpty) {
      return courses;
    }
    return courses.where((course) {
      return course['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
             course['author'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  Widget _buildNavItem(IconData icon, int index, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          // Home - go back to Dashboard
          Navigator.pop(context);
        } else if (index == 1) {
          // Already on All Courses page, do nothing
        }
        // Add other navigation logic as needed
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.25)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            icon,
            color: isSelected
                ? Colors.white
                : Colors.white.withValues(alpha: 0.7),
            size: isSelected ? 28 : 24,
          ),
        ),
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
      backgroundColor: Colors.white,
      body: Column(
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
                // Top row with title and action icons
                Row(
                  children: [
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
                              color: Colors.white.withValues(alpha: 0.9),
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
                  color: Colors.black.withValues(alpha: 0.05),
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
                        onPressed: () {},
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
      ),
    );
  }

  // Web Course Card - Exact Design from Image
  Widget _buildWebCourseCard(Map<String, dynamic> course) {
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
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                // Course Image - Left side
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(course['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                
                // Course Details - Center
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        course['author'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Color(0xFFFFD700), size: 18),
                          SizedBox(width: 4),
                          Text(
                            '${course['rating']}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '\$${course['price']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B5CF6),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF3CD),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Color(0xFFFFC107),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: Color(0xFFD97706),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${course['accessDays']} days access',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFD97706),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Action buttons - Right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Favorite button - Top right
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.grey[400],
                          size: 20,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                    // Start Course button - Bottom right
                    ElevatedButton(
                      onPressed: () {
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8B5CF6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        elevation: 2,
                        minimumSize: Size(0, 36),
                      ),
                      child: Text(
                        'Start Course',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
                      color: Colors.white.withValues(alpha: 0.9),
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
            )).toList(),

            SizedBox(height: 20),
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
                _buildNavItem(Icons.home_rounded, 0, isSelected: false),
                _buildNavItem(
                  Icons.language_rounded,
                  1,
                  isSelected: true,
                ), // Current page
                _buildNavItem(Icons.play_circle_fill, 2, isSelected: false),
                _buildNavItem(Icons.bookmark_rounded, 3, isSelected: false),
                _buildNavItem(Icons.person_rounded, 4, isSelected: false),
              ],
            ),
          ),
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
