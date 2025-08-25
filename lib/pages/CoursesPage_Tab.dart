import 'package:flutter/material.dart';
import 'CourseDetailsPage.dart';

class CoursesPageTab extends StatelessWidget {
  final String selectedLanguage;

  const CoursesPageTab({super.key, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header for All Courses
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[200]!, width: 1),
            ),
            child: Text(
              'Learning Courses',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),

          // Course 1: Flutter Development Fundamentals
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/developer.png',
            title: 'Flutter Development Fundamentals',
            author: 'By John Carter',
            progress: 0.31,
            progressText: '31% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 62,
          ),

          SizedBox(height: 16),

          // Course 2: User Experience Design Fundamentals
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/tester.jpg',
            title: 'User Experience Design Fundamentals',
            author: 'By John Carter',
            progress: 0.08,
            progressText: '8% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 83,
          ),

          SizedBox(height: 16),

          // Course 3: DevOps and Cloud Computing
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/devop.jpg',
            title: 'DevOps and Cloud Computing',
            author: 'By John Carter',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),
          // Course 4: Software Testing and QA
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/test.png',
            title: 'Software Testing and QA',
            author: 'By John Carter',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),

          SizedBox(height: 16),

          // Course 5: Complete Flutter Development
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/developer.png',
            title: 'Complete Flutter Development',
            author: 'By Sarah Wilson',
            progress: 0.65,
            progressText: '65% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 23,
          ),

          SizedBox(height: 16),

          // Course 6: Digital Marketing Mastery
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/splash1.png',
            title: 'Digital Marketing Mastery',
            author: 'By Mike Johnson',
            progress: 0.42,
            progressText: '42% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 52,
          ),

          SizedBox(height: 16),

          // Course 7: Python for Data Science
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/devop.jpg',
            title: 'Python for Data Science',
            author: 'By Dr. Emily Chen',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),

          SizedBox(height: 16),

          // Course 8: Web Design Fundamentals
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/homescreen.png',
            title: 'Web Design Fundamentals',
            author: 'By Alex Rodriguez',
            progress: 0.23,
            progressText: '23% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 69,
          ),

          SizedBox(height: 16),

          // Course 9: Business Analytics
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/tester.jpg',
            title: 'Business Analytics',
            author: 'By Jennifer Lee',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),

          SizedBox(height: 16),

          // Course 10: Mobile App Design
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/splash2.png',
            title: 'Mobile App Design',
            author: 'By David Kim',
            progress: 0.78,
            progressText: '78% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 20,
          ),

          SizedBox(height: 16),

          // Course 11: Machine Learning Basics
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/devop.png',
            title: 'Machine Learning Basics',
            author: 'By Dr. Robert Smith',
            progress: 0.15,
            progressText: '15% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 76,
          ),

          SizedBox(height: 16),

          // Course 12: UI/UX Design with Figma
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/test.png',
            title: 'UI/UX Design with Figma',
            author: 'By Maria Garcia',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),

          SizedBox(height: 16),

          // Course 13: Agile Project Management
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/splash2.png',
            title: 'Agile Project Management',
            author: 'By Thomas Brown',
            progress: 0.89,
            progressText: '89% completed',
            buttonText: 'Continue Course',
            progressColor: Color(0xFF5F299E),
            daysRemaining: 10,
          ),

          SizedBox(height: 16),

          // Course 14: DevOps Engineering
          _buildCourseCard(
            context,
            imageAsset: 'assets/images/devop.png',
            title: 'DevOps Engineering',
            author: 'By Lisa Anderson',
            progress: 0.0,
            progressText: '0% completed',
            buttonText: 'Start Course',
            progressColor: Color(0xFF5F299E),

            daysRemaining: 90,
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    BuildContext context, {
    required String imageAsset,
    required String title,
    required String author,
    required double progress,
    required String progressText,
    required String buttonText,
    required Color progressColor,
    required int daysRemaining,
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
              progress: progress,
              progressText: progressText,
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
                        imageAsset,
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
                                '$daysRemaining days left out of 90 days',
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

            // Progress Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          color: progressColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    progressText,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // Continue/Start Course Button
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
                          progress: progress,
                          progressText: progressText,
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
                    padding: EdgeInsets.symmetric(vertical: 12),
                    elevation: 0,
                  ),
                  child: Text(
                    buttonText,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
