import 'package:flutter/material.dart';
import 'AddToCart.dart';

class CourseDetailsPage extends StatefulWidget {
  final String courseTitle;
  final String courseAuthor;
  final String courseImage;
  final double progress;
  final String progressText;

  const CourseDetailsPage({
    super.key,
    required this.courseTitle,
    required this.courseAuthor,
    required this.courseImage,
    required this.progress,
    required this.progressText,
  });

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _instructorController = PageController();
  int _currentInstructorIndex = 0;
  final PageController _testimonialController = PageController();
  int _currentTestimonialIndex = 0;
  bool _showCertificatePreview = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _instructorController.dispose();
    _testimonialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Color(0xFF5F299E),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Course Details',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Uncomment if needed
            // actions: [
            //   IconButton(
            //     icon: Icon(Icons.shopping_cart_outlined, color: Colors.white),
            //     onPressed: () {
            //       // Navigate to cart page
            //     },
            //   ),
            // ],
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCourseHeader(),
                _buildCourseInfo(),
                _buildTabSection(),
                _buildCourseFeatures(),
                _buildInstructorSection(),
                _buildCertificationPreviewSection(),
                _buildCertificationSection(),
                _buildTestimonialsSection(),
                _buildContinueButton(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
        // Certificate Preview Lightbox
        if (_showCertificatePreview)
          Container(
                  color: Colors.black.withOpacity(0.8),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close button
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCertificatePreview = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close, size: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Full Certificate Design - Landscape
                    Container(
                      width: double.infinity,
                      height: 400,
                      padding: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        children: [
                          // Header with logos
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: 2),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    'Microsoft',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'mohlay Infotech',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFFFC107),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          // Main content - Center Aligned for lightbox
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'DECLARATION OF',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1565C0),
                                    letterSpacing: 4.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'COMPLETION',
                                  style: TextStyle(
                                    fontSize: 52,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1565C0),
                                    letterSpacing: 3.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 40),
                                Text(
                                  'Your Name',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF1565C0),
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 20),
                                  height: 3,
                                  width: 350,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'has successfully completed the online course',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'FLUTTER DEVELOPMENT',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1565C0),
                                    letterSpacing: 2.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 24),
                                Text(
                                  'This professional has demonstrated initiative and a commitment\nto deepening their skills and advancing their career. Well done!',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
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
            ),
          ),
      ],
    );
  }

  Widget _buildCourseHeader() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                ),
              ),
              child: Image.asset(
                widget.courseImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Color(0xFF4A90E2),
                    child: Icon(Icons.school, size: 60, color: Colors.white),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseTitle,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.courseAuthor,
                      style: TextStyle(fontSize: 14, color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text(
                '4.6',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 16),
              Icon(Icons.people, color: Colors.grey[600], size: 20),
              SizedBox(width: 4),
              Text(
                '564K Learners',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Master the fundamentals of ${widget.courseTitle.toLowerCase()} with hands-on projects and real-world applications. This comprehensive course covers everything from basic concepts to advanced techniques.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue[600],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue[600],
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Curriculum'),
            ],
          ),
          SizedBox(
            height: 330,
            child: TabBarView(
              controller: _tabController,
              children: [_buildOverviewTab(), _buildCurriculumTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildOverviewItem(
            Icons.access_time,
            '4 hours',
            'of self-paced video lessons',
          ),
          SizedBox(height: 12),
          _buildOverviewItem(
            Icons.card_membership,
            'Completion certificate',
            'awarded on course completion',
          ),
          SizedBox(height: 12),
          _buildOverviewItem(
            Icons.calendar_today,
            '90 days access',
            'to your free course',
          ),
          SizedBox(height: 12),
          _buildOverviewItem(
            Icons.trending_up,
            'What Will I Learn?',
            'SMM, SEO, SEM/Paid Ads, Content Marketing, Web Analytics, CRM tools',
          ),
          SizedBox(height: 12),
          _buildOverviewItem(Icons.trending_up, 'Beginner', 'course level'),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[600], size: 20),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCurriculumTab() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCurriculumItem(
            'Introduction to ${widget.courseTitle}',
            '15 min',
          ),
          _buildCurriculumItem('Setting up Development Environment', '20 min'),
          _buildCurriculumItem('Basic Concepts and Fundamentals', '45 min'),
          _buildCurriculumItem('Hands-on Project', '60 min'),
          _buildCurriculumItem('Advanced Techniques', '40 min'),
        ],
      ),
    );
  }

  Widget _buildCurriculumItem(String title, String duration) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, color: Colors.blue[600]),
          SizedBox(width: 12),
          Expanded(child: Text(title, style: TextStyle(fontSize: 14))),
          Text(
            duration,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseFeatures() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768; // Web/Desktop/M sh ok breakpoint

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Features',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          GridView.count(
            crossAxisCount: isWeb ? 3 : 2, // 3 columns on web, 2 on mobile
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: isWeb ? 2.5 : 3, // Adjust aspect ratio for web
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              _buildFeatureCard('918 Enroll', Icons.people, Colors.amber),
              _buildFeatureCard(
                '45 Video Record',
                Icons.video_library,
                Colors.green,
              ),
              _buildFeatureCard('12 Lessons', Icons.book, Colors.blue),
              _buildFeatureCard('120 Note File', Icons.note, Colors.orange),
              _buildFeatureCard('160 Quiz', Icons.quiz, Colors.purple),
              _buildFeatureCard(
                '76 Audio Record',
                Icons.audiotrack,
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(String text, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;

    List<Map<String, String>> instructors = [
      {
        'name': 'Hellio Jamsh',
        'title': 'Basic English',
        'subtitle': 'BSC in EEE from Southeast University',
        'image': 'assets/images/instructor1.png',
      },
      {
        'name': 'Sarah Johnson',
        'title': 'Advanced Programming',
        'subtitle': 'MS in Computer Science from MIT',
        'image': 'assets/images/instructor2.png',
      },
      {
        'name': 'Mike Chen',
        'title': 'UI/UX Design',
        'subtitle': 'Senior Designer at Google',
        'image': 'assets/images/instructor3.png',
      },
      {
        'name': 'Emma Wilson',
        'title': 'Data Science',
        'subtitle': 'PhD in Data Science from Stanford',
        'image': 'assets/images/instructor4.png',
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Instructor',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: PageView.builder(
              controller: _instructorController,
              onPageChanged: (index) {
                setState(() {
                  _currentInstructorIndex = index;
                });
              },
              itemCount: isWeb ? (instructors.length / 2).ceil() : instructors.length,
              itemBuilder: (context, pageIndex) {
                if (isWeb) {
                  // Web: Show 2 instructors per slide
                  final startIndex = pageIndex * 2;
                  final endIndex = (startIndex + 2).clamp(0, instructors.length);
                  final pageInstructors = instructors.sublist(startIndex, endIndex);

                  return Row(
                    children: pageInstructors.asMap().entries.map((entry) {
                      final instructorIndex = entry.key;
                      final instructor = entry.value;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: instructorIndex < pageInstructors.length - 1 ? 8 : 0,
                            left: instructorIndex > 0 ? 8 : 0,
                          ),
                          child: _buildInstructorCard(instructor),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  // Mobile: Show 1 instructor per slide (unchanged)
                  return _buildInstructorCard(instructors[pageIndex]);
                }
              },
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              isWeb ? (instructors.length / 2).ceil() : instructors.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentInstructorIndex == index
                      ? Colors.blue[600]
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructorCard(Map<String, String> instructor) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            backgroundImage: AssetImage(instructor['image']!),
            onBackgroundImageError: (exception, stackTrace) {
              // Fallback to icon if image fails to load
            },
            child: instructor['image'] == null
                ? Icon(Icons.person, size: 30, color: Colors.blue[600])
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  instructor['name']!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  instructor['title']!,
                  style: TextStyle(fontSize: 14, color: Colors.blue[600]),
                ),
                Text(
                  instructor['subtitle']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationPreviewSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isWeb ? _buildWebCertificateLayout() : _buildMobileCertificateLayout(),
    );
  }

  Widget _buildWebCertificateLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side: Text content
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get a completion certificate',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Share your certificate with prospective employers and your professional network on LinkedIn.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showCertificatePreview = true;
                    });
                  },
                  icon: Icon(Icons.visibility, color: Colors.white),
                  label: Text(
                    'Preview Certificate',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E88E5),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right side: Certificate preview
        Expanded(
          flex: 1,
          child: _buildCertificatePreviewCard(),
        ),
      ],
    );
  }

  Widget _buildMobileCertificateLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header text
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get a completion certificate',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Share your certificate with prospective employers and your professional network on LinkedIn.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        _buildCertificatePreviewCard(),
      ],
    );
  }

  Widget _buildCertificatePreviewCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Yellow accent shapes
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFFFFC107).withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFFFFC107).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Yellow bottom accent bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFFFC107),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Certificate Preview
                Container(
                  width: double.infinity,
                  height: 280,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Header with logos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 2),
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Microsoft',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'mohlay Infotech',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFC107),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Main content - Center Aligned
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'DECLARATION OF',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1565C0),
                                letterSpacing: 2.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'COMPLETION',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0),
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Your Name',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1565C0),
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              height: 1,
                              width: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow[700]!,
                                    Colors.black,
                                    Colors.yellow[700]!,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'has successfully completed the online course',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'FLUTTER DEVELOPMENT',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1565C0),
                                letterSpacing: 1.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'This professional has demonstrated initiative and a commitment\nto deepening their skills and advancing their career. Well done!',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Preview button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showCertificatePreview = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      'Preview',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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

  Widget _buildCertificationSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Features & Videos',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          if (isWeb) ...[
            // Web: Single row with 4 cards
            Row(
              children: [
                Expanded(
                  child: _buildCertificationCard(
                    'Skills You Will Gain',
                    'Explore course skills',
                    Icons.card_membership,
                    Colors.amber,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCertificationCard(
                    'Video Lessons',
                    '45+ HD video tutorials',
                    Icons.play_circle_filled,
                    Colors.red,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCertificationCard(
                    'Downloadable Resources',
                    'PDFs, code files & more',
                    Icons.download,
                    Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCertificationCard(
                    'Lifetime Access',
                    'Learn at your own pace',
                    Icons.all_inclusive,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ] else ...[
            // Mobile: Two rows with 2 cards each (unchanged)
            Row(
              children: [
                Expanded(
                  child: _buildCertificationCard(
                    'Skills You Will Gain',
                    'Explore course skills',
                    Icons.card_membership,
                    Colors.amber,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCertificationCard(
                    'Video Lessons',
                    '45+ HD video tutorials',
                    Icons.play_circle_filled,
                    Colors.red,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildCertificationCard(
                    'Downloadable Resources',
                    'PDFs, code files & more',
                    Icons.download,
                    Colors.green,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildCertificationCard(
                    'Lifetime Access',
                    'Learn at your own pace',
                    Icons.all_inclusive,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCertificationCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;

    List<Map<String, String>> testimonials = [
      {
        'name': 'John Smith',
        'rating': '5.0',
        'comment':
            'Excellent course! Very well structured and easy to follow. Highly recommended for beginners.',
        'avatar': 'JS',
      },
      {
        'name': 'Emily Davis',
        'rating': '4.8',
        'comment':
            'Great content and practical examples. The instructor explains concepts very clearly.',
        'avatar': 'ED',
      },
      {
        'name': 'Michael Brown',
        'rating': '4.9',
        'comment':
            'This course helped me land my dream job. The projects were very helpful.',
        'avatar': 'MB',
      },
      {
        'name': 'Sarah Wilson',
        'rating': '4.7',
        'comment':
            'Amazing learning experience with hands-on projects and real-world examples.',
        'avatar': 'SW',
      },
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Testimonials',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: PageView.builder(
              controller: _testimonialController,
              onPageChanged: (index) {
                setState(() {
                  _currentTestimonialIndex = index;
                });
              },
              itemCount: isWeb ? (testimonials.length / 2).ceil() : testimonials.length,
              itemBuilder: (context, pageIndex) {
                if (isWeb) {
                  // Web: Show 2 testimonials per slide
                  final startIndex = pageIndex * 2;
                  final endIndex = (startIndex + 2).clamp(0, testimonials.length);
                  final pageTestimonials = testimonials.sublist(startIndex, endIndex);

                  return Row(
                    children: pageTestimonials.asMap().entries.map((entry) {
                      final testimonialIndex = entry.key;
                      final testimonial = entry.value;
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: testimonialIndex < pageTestimonials.length - 1 ? 8 : 0,
                            left: testimonialIndex > 0 ? 8 : 0,
                          ),
                          child: _buildTestimonialCard(testimonial),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  // Mobile: Show 1 testimonial per slide (unchanged)
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    child: _buildTestimonialCard(testimonials[pageIndex]),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              isWeb ? (testimonials.length / 2).ceil() : testimonials.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentTestimonialIndex == index
                      ? Colors.blue[600]
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(Map<String, String> testimonial) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue[100],
                child: Text(
                  testimonial['avatar']!,
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial['name']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          testimonial['rating']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            testimonial['comment']!,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 768;

    return Container(
      margin: EdgeInsets.all(16),
      child: isWeb ? _buildWebButtons() : _buildMobileButtons(),
    );
  }

  Widget _buildWebButtons() {
    return Center(
      child: Container(
        width: 400, // Fixed width for web
        child: Column(
          children: [
            // First Row - Buy Now and Add To Cart buttons
            Row(
              children: [
                // Buy Now Button
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle buy now action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Purchasing ${widget.courseTitle}...'),
                            backgroundColor: Colors.green[600],
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        shadowColor: Colors.blue.withValues(alpha: 0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.flash_on_rounded, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'BUY NOW',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Add To Cart Button
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToCartPage(
                              courseTitle: widget.courseTitle,
                              courseAuthor: widget.courseAuthor,
                              courseImage: widget.courseImage,
                              coursePrice: '\$99.99',
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue[600],
                        side: BorderSide(color: Colors.blue[600]!, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'ADD TO CART',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            // Second Row - Ask Query button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: _showQueryDialog,
                icon: Icon(Icons.help_outline, size: 18),
                label: Text(
                  'Ask Query About Course',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileButtons() {
    return Column(
      children: [
        // First Row - Buy Now and Add To Cart buttons
        Row(
          children: [
            // Buy Now Button
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle buy now action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Purchasing ${widget.courseTitle}...'),
                        backgroundColor: Colors.green[600],
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    shadowColor: Colors.blue.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flash_on_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'BUY NOW',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            // Add To Cart Button
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Add to Cart page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToCartPage(
                          courseTitle: widget.courseTitle,
                          courseAuthor: widget.courseAuthor,
                          courseImage: widget.courseImage,
                          coursePrice: '\$99.00', // You can make this dynamic
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5F299E),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    shadowColor: Color(0xFF5F299E).withValues(alpha: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_rounded, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'ENROLL NOW',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        // Second Row - Have a Query button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () {
              // Handle query action
              _showQueryDialog();
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Color(0xFF5F299E), width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF5F299E),
              elevation: 2,
              shadowColor: Color(0xFF5F299E).withValues(alpha: 0.15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.help_outline_rounded,
                  size: 22,
                  color: Color(0xFF5F299E),
                ),
                SizedBox(width: 10),
                Text(
                  'HAVE A QUERY?',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: Color(0xFF5F299E),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showQueryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.help_outline_rounded, color: Colors.blue[600]),
              SizedBox(width: 8),
              Text(
                'Have a Query?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How can we help you with "${widget.courseTitle}"?',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Opening chat support...'),
                            backgroundColor: Colors.green[600],
                          ),
                        );
                      },
                      icon: Icon(Icons.chat_bubble_outline, size: 18),
                      label: Text('Chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Opening email support...'),
                            backgroundColor: Colors.blue[600],
                          ),
                        );
                      },
                      icon: Icon(Icons.email_outlined, size: 18),
                      label: Text('Email'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey[600])),
            ),
          ],
        );
      }, 
    );
  }
}
