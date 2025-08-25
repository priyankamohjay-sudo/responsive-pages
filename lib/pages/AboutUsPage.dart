import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Color(0xFF5F299E),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF5F299E),
                    Color(0xFF5F299E).withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF5F299E).withValues(alpha: 0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.school, size: 60, color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    'EduApp',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Empowering Learning Through Technology',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // About Content
            _buildSection(
              'Our Mission',
              'We are dedicated to making quality education accessible to everyone, everywhere. Our platform connects learners with expert instructors and cutting-edge content to help them achieve their goals.',
              Icons.flag_outlined,
            ),

            _buildSection(
              'Our Story',
              'Founded in 2020, EduApp started with a simple vision: to democratize education and make learning more engaging and effective. Today, we serve millions of learners worldwide across various disciplines.',
              Icons.history,
            ),

            _buildSection(
              'What We Offer',
              '• Expert-led courses in technology, business, and creative fields\n• Interactive learning experiences with hands-on projects\n• Personalized learning paths tailored to your goals\n• Community support and peer-to-peer learning\n• Certificates and credentials recognized by industry leaders',
              Icons.star_outline,
            ),

            _buildSection(
              'Our Values',
              '• Excellence: We strive for the highest quality in everything we do\n• Accessibility: Education should be available to everyone\n• Innovation: We embrace new technologies to enhance learning\n• Community: Learning is better when we support each other\n• Growth: We believe in continuous improvement and lifelong learning',
              Icons.favorite_outline,
            ),

            // Team Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        color: Color(0xFF5F299E),
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Our Team',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5F299E),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTeamMember(
                          'Sarah Johnson',
                          'CEO & Founder',
                          'assets/images/instructor1.png',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTeamMember(
                          'Mike Chen',
                          'CTO',
                          'assets/images/instructor2.png',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTeamMember(
                          'Emily Davis',
                          'Head of Education',
                          'assets/images/instructor3.png',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTeamMember(
                          'Alex Rodriguez',
                          'Lead Developer',
                          'assets/images/homescreen.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Contact Section
            _buildSection(
              'Get in Touch',
              'Have questions or suggestions? We\'d love to hear from you!\n\nEmail: hello@eduapp.com\nPhone: +1 (555) 123-4567\nAddress: 123 Education Street, Learning City, LC 12345\n\nFollow us on social media for updates and learning tips!',
              Icons.contact_mail_outlined,
            ),

            SizedBox(height: 20),

            // App Info
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'EduApp Version 1.0.0',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '© 2024 EduApp. All rights reserved.',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Color(0xFF5F299E), size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5F299E),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            content,
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

  Widget _buildTeamMember(String name, String role, String imagePath) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage(imagePath)),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
