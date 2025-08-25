import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getAllCourses();
  Future<List<Course>> getCoursesByCategory(String category);
  Future<List<Course>> searchCourses(String query);
  Future<Course?> getCourseById(String id);
  Future<List<Course>> getFeaturedCourses();
  Future<List<Course>> getRecommendedCourses();
  Future<bool> enrollInCourse(String courseId);
  Future<bool> updateCourseProgress(String courseId, double progress);
}

class CourseRepositoryImpl implements CourseRepository {
  static const String _coursesKey = 'cached_courses';
  static const String _enrolledCoursesKey = 'enrolled_courses';
  static const String _courseProgressKey = 'course_progress';
  
  final Duration _cacheExpiry = const Duration(hours: 1);
  DateTime? _lastFetchTime;
  List<Course>? _cachedCourses;
  
  // Simulate network delay
  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  
  @override
  Future<List<Course>> getAllCourses() async {
    // Check cache first
    if (_cachedCourses != null && _lastFetchTime != null) {
      final timeDifference = DateTime.now().difference(_lastFetchTime!);
      if (timeDifference < _cacheExpiry) {
        return _cachedCourses!;
      }
    }
    
    await _simulateNetworkDelay();
    
    // Generate sample courses
    final courses = _generateSampleCourses();
    
    // Cache the results
    _cachedCourses = courses;
    _lastFetchTime = DateTime.now();
    await _saveCourseCache(courses);
    
    return courses;
  }
  
  @override
  Future<List<Course>> getCoursesByCategory(String category) async {
    final allCourses = await getAllCourses();
    
    // Simple category filtering based on course title/description
    return allCourses.where((course) {
      final categoryLower = category.toLowerCase();
      final titleLower = course.title.toLowerCase();
      final descriptionLower = course.description.toLowerCase();
      
      return titleLower.contains(categoryLower) || 
             descriptionLower.contains(categoryLower);
    }).toList();
  }
  
  @override
  Future<List<Course>> searchCourses(String query) async {
    if (query.trim().isEmpty) {
      return await getAllCourses();
    }
    
    final allCourses = await getAllCourses();
    final queryLower = query.toLowerCase();
    
    return allCourses.where((course) {
      return course.title.toLowerCase().contains(queryLower) ||
             course.author.toLowerCase().contains(queryLower) ||
             course.description.toLowerCase().contains(queryLower);
    }).toList();
  }
  
  @override
  Future<Course?> getCourseById(String id) async {
    final allCourses = await getAllCourses();
    
    try {
      return allCourses.firstWhere((course) => course.title.hashCode.toString() == id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Course>> getFeaturedCourses() async {
    final allCourses = await getAllCourses();
    
    // Return courses with high ratings
    return allCourses.where((course) => course.rating >= 4.7).take(5).toList();
  }
  
  @override
  Future<List<Course>> getRecommendedCourses() async {
    final allCourses = await getAllCourses();
    
    // Simple recommendation: return random courses
    final shuffled = List<Course>.from(allCourses)..shuffle();
    return shuffled.take(6).toList();
  }
  
  @override
  Future<bool> enrollInCourse(String courseId) async {
    try {
      await _simulateNetworkDelay();
      
      final prefs = await SharedPreferences.getInstance();
      final enrolledCourses = prefs.getStringList(_enrolledCoursesKey) ?? [];
      
      if (!enrolledCourses.contains(courseId)) {
        enrolledCourses.add(courseId);
        await prefs.setStringList(_enrolledCoursesKey, enrolledCourses);
      }
      
      return true;
    } catch (e) {
      debugPrint('Error enrolling in course: $e');
      return false;
    }
  }
  
  @override
  Future<bool> updateCourseProgress(String courseId, double progress) async {
    try {
      await _simulateNetworkDelay();
      
      final prefs = await SharedPreferences.getInstance();
      final progressMap = prefs.getString(_courseProgressKey);
      
      Map<String, double> courseProgress = {};
      if (progressMap != null) {
        final decoded = json.decode(progressMap) as Map<String, dynamic>;
        courseProgress = decoded.map((key, value) => MapEntry(key, value.toDouble()));
      }
      
      courseProgress[courseId] = progress;
      await prefs.setString(_courseProgressKey, json.encode(courseProgress));
      
      return true;
    } catch (e) {
      debugPrint('Error updating course progress: $e');
      return false;
    }
  }
  
  // Helper methods
  Future<void> _saveCourseCache(List<Course> courses) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final coursesJson = json.encode(courses.map((c) => c.toMap()).toList());
      await prefs.setString(_coursesKey, coursesJson);
    } catch (e) {
      debugPrint('Error saving course cache: $e');
    }
  }
  
  Future<List<Course>?> _loadCourseCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final coursesJson = prefs.getString(_coursesKey);
      
      if (coursesJson != null) {
        final coursesList = json.decode(coursesJson) as List;
        return coursesList.map((c) => Course.fromMap(c)).toList();
      }
    } catch (e) {
      debugPrint('Error loading course cache: $e');
    }
    return null;
  }
  
  List<Course> _generateSampleCourses() {
    return [
      Course(
        title: 'Complete Flutter Development',
        author: 'John Carter',
        imageAsset: 'assets/images/developer.png',
        price: '\$89.99',
        rating: 4.8,
        students: '2.5k',
        duration: '90 days access',
        description: 'Master Flutter development from basics to advanced concepts',
      ),
      Course(
        title: 'Advanced React Native',
        author: 'Sarah Johnson',
        imageAsset: 'assets/images/tester.jpg',
        price: '\$99.99',
        rating: 4.7,
        students: '1.8k',
        duration: '60 days access',
        description: 'Build professional mobile apps with React Native',
      ),
      Course(
        title: 'UI/UX Design Masterclass',
        author: 'Mike Wilson',
        imageAsset: 'assets/images/test.png',
        price: '\$79.99',
        rating: 4.9,
        students: '3.2k',
        duration: '45 days access',
        description: 'Learn modern UI/UX design principles and tools',
      ),
      Course(
        title: 'DevOps with Docker & Kubernetes',
        author: 'Alex Rodriguez',
        imageAsset: 'assets/images/devop.jpg',
        price: '\$129.99',
        rating: 4.6,
        students: '1.5k',
        duration: '120 days access',
        description: 'Master containerization and orchestration',
      ),
      Course(
        title: 'Full Stack Web Development',
        author: 'Emma Davis',
        imageAsset: 'assets/images/developer.png',
        price: '\$149.99',
        rating: 4.8,
        students: '4.1k',
        duration: '180 days access',
        description: 'Complete web development with modern technologies',
      ),
      Course(
        title: 'Mobile App Testing',
        author: 'David Brown',
        imageAsset: 'assets/images/tester.jpg',
        price: '\$69.99',
        rating: 4.5,
        students: '980',
        duration: '30 days access',
        description: 'Comprehensive mobile app testing strategies',
      ),
      Course(
        title: 'Digital Marketing Strategy',
        author: 'Lisa Anderson',
        imageAsset: 'assets/images/digital.jpg',
        price: '\$59.99',
        rating: 4.7,
        students: '2.8k',
        duration: '60 days access',
        description: 'Modern digital marketing techniques and strategies',
      ),
      Course(
        title: 'Python for Data Science',
        author: 'Robert Taylor',
        imageAsset: 'assets/images/developer.png',
        price: '\$109.99',
        rating: 4.8,
        students: '3.5k',
        duration: '90 days access',
        description: 'Data science and machine learning with Python',
      ),
    ];
  }
  
  // Public utility methods
  Future<List<String>> getEnrolledCourseIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_enrolledCoursesKey) ?? [];
  }
  
  Future<double> getCourseProgress(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final progressMap = prefs.getString(_courseProgressKey);
    
    if (progressMap != null) {
      final decoded = json.decode(progressMap) as Map<String, dynamic>;
      return decoded[courseId]?.toDouble() ?? 0.0;
    }
    
    return 0.0;
  }
  
  Future<void> clearCache() async {
    _cachedCourses = null;
    _lastFetchTime = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_coursesKey);
  }
}
