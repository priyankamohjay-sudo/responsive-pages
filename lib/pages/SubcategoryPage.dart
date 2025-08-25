import 'package:flutter/material.dart';
import '../widgets/app_layout.dart';

class SubcategoryPage extends StatefulWidget {
  final String categoryName;
  final String categoryIcon;
  final Color categoryColor;

  const SubcategoryPage({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });

  @override
  State<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  bool showCourses = true; // toggle for tabs

  // Courses dummy data 
  List<Map<String, dynamic>> _getSubcategories(String categoryName) {
    return [
      {'name': '$categoryName Basics', 'courses': '10 courses', 'color': const Color(0xFF6C5CE7), 'icon': '📘'},
      {'name': 'Intermediate $categoryName', 'courses': '8 courses', 'color': const Color(0xFFE17055), 'icon': '📗'},
      {'name': 'Advanced $categoryName', 'courses': '12 courses', 'color': const Color(0xFF00B894), 'icon': '📕'},
      {'name': '$categoryName Tools', 'courses': '7 courses', 'color': const Color(0xFFFF6B6B), 'icon': '🛠️'},
      {'name': '$categoryName Projects', 'courses': '9 courses', 'color': const Color(0xFF45B7D1), 'icon': '📂'},
      {'name': 'Mastering $categoryName', 'courses': '11 courses', 'color': const Color(0xFFFECA57), 'icon': '🎓'},
      {'name': '$categoryName Career Path', 'courses': '6 courses', 'color': const Color(0xFFA29BFE), 'icon': '🚀'},
    ];
  }

  // Quizzes dummy data 
  List<Map<String, dynamic>> _getQuizzes(String categoryName) {
    return [
      {'name': '$categoryName Basics Quiz', 'quizzes': '5 quizzes', 'color': const Color(0xFF6C5CE7), 'icon': '❓'},
      {'name': 'Intermediate $categoryName Quiz', 'quizzes': '4 quizzes', 'color': const Color(0xFFE17055), 'icon': '📝'},
      {'name': 'Advanced $categoryName Quiz', 'quizzes': '3 quizzes', 'color': const Color(0xFF00B894), 'icon': '🏆'},
      {'name': '$categoryName Mock Test', 'quizzes': '2 quizzes', 'color': const Color(0xFFFF6B6B), 'icon': '🧪'},
      {'name': '$categoryName Final Exam', 'quizzes': '1 quiz', 'color': const Color(0xFF45B7D1), 'icon': '📊'},
    ];
  }

  // Card builder 
  Widget _buildItemCard(Map<String, dynamic> item, {bool isQuiz = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: item['color'].withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(item['icon'], style: const TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isQuiz ? item['quizzes'] : item['courses'],
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subcategories = _getSubcategories(widget.categoryName);
    final quizzes = _getQuizzes(widget.categoryName);

    return AppLayout(
      title: widget.categoryName,
      currentIndex: 1,
      showBackButton: true,
      showBottomNavigation: false,
      showHeaderActions: false,
      child: Column(
        children: [
          // 🔹 Header with toggle
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5F299E), Color(0xFF7B68EE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Text(
                  widget.categoryName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Toggle tabs
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => showCourses = true),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                            color: showCourses ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Courses',
                            style: TextStyle(
                              color: showCourses ? const Color(0xFF5F299E) : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => showCourses = false),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: !showCourses ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Quizzes',
                            style: TextStyle(
                              color: !showCourses ? const Color(0xFF5F299E) : Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Progress bar 
                Row(
                  children: const [
                    Text('Learn 50% left', style: TextStyle(color: Colors.white, fontSize: 14)),
                    Spacer(),
                    Text('Next 50% left', style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: const LinearGradient(colors: [Colors.pink, Colors.blue]),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Body (List of courses/quizzes)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: showCourses ? subcategories.length : quizzes.length,
                itemBuilder: (context, index) {
                  final item = showCourses ? subcategories[index] : quizzes[index];
                  return _buildItemCard(item, isQuiz: !showCourses);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
