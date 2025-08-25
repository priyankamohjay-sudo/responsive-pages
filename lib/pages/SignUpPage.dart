import 'package:flutter/material.dart';
import 'package:fluttertest/Wedgets/BoldText.dart';
import 'package:fluttertest/models/user.dart';
import 'package:fluttertest/pages/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  bool tracker = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define breakpoints (same as LoginPage)
    final isSmallPhone = screenWidth < 360;
    final isVerySmallPhone = screenHeight < 650; // For very small height screens
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        height: screenHeight,
        color: Colors.white,
        child: Stack(
          children: [
            // Fixed layout without scrolling
            Column(
              children: [
                // Main signup content with animation - centered
                Expanded(
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _signUpPage(context, isSmallPhone, isVerySmallPhone),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _signUpPage(BuildContext context, bool isSmallPhone, bool isVerySmallPhone) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isVerySmallPhone ? 12 : (isSmallPhone ? 16 : 14)),
      padding: EdgeInsets.all(isVerySmallPhone ? 16 : (isSmallPhone ? 20 : 28)),
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome text with enhanced styling
          Center(
            child: Column(
              children: [
                BoldText(
                  font: 'YourFontFamily',
                  text: 'Create Account',
                  size: isVerySmallPhone ? 18 : (isSmallPhone ? 19 : 20),
                  color: Theme.of(context).textTheme.titleLarge?.color ?? const Color(0xFF2D3748),
                ),
                SizedBox(height: isVerySmallPhone ? 3 : (isSmallPhone ? 3 : 4)),
                Text(
                  'Follow simple Steps',
                  style: TextStyle(
                    fontSize: isVerySmallPhone ? 13 : (isSmallPhone ? 14 : 15),
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isVerySmallPhone ? 14 : (isSmallPhone ? 16 : 18)),

          // Social login buttons
          _buildSocialButton(
            'Sign in With Google',
            Colors.blue[400]!,
            Icons.g_mobiledata_outlined,
            () {
              // Handle Google sign in
            },
            isSmallPhone,
            isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 8 : (isSmallPhone ? 9 : 10)),

          _buildSocialButton(
            'Sign in With Facebook',
            const Color.fromARGB(255, 21, 47, 192),
            Icons.facebook,
            () {
              // Handle Facebook sign in
            },
            isSmallPhone,
            isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 8 : (isSmallPhone ? 9 : 10)),

          _buildSocialButton(
            'Sign in With Apple',
            Colors.black,
            Icons.apple,
            () {
              // Handle Apple sign in
            },
            isSmallPhone,
            isVerySmallPhone,
          ),

          SizedBox(height: isVerySmallPhone ? 10 : (isSmallPhone ? 12 : 14)),

          // OR divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[300])),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isVerySmallPhone ? 12 : (isSmallPhone ? 14 : 16)),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: isVerySmallPhone ? 14 : (isSmallPhone ? 15 : 16),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey[300])),
            ],
          ),

          SizedBox(height: isVerySmallPhone ? 14 : (isSmallPhone ? 16 : 18)),

          // Enhanced form fields
          _buildEnhancedTextField(
            controller: fullNameController,
            label: "Name",
            icon: Icons.person_outline,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 10 : (isSmallPhone ? 12 : 14)),

          _buildEnhancedTextField(
            controller: emailController,
            label: "Email",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 10 : (isSmallPhone ? 12 : 14)),

          _buildEnhancedTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),

          SizedBox(height: isVerySmallPhone ? 16 : (isSmallPhone ? 18 : 20)),

          // Enhanced create account button with gradient
          Container(
            height: isVerySmallPhone ? 45 : (isSmallPhone ? 50 : 56),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF5F299E), Color(0xFF5F299E)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5F299E).withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  String email = emailController.text.trim();
                  String fullName = fullNameController.text.trim();
                  String password = passwordController.text;

                  if (email.isEmpty || fullName.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("All fields are required"),
                        backgroundColor: Colors.red[400],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    return;
                  }

                  // Simple registration - just add to list
                  registeredUsers.add(
                    User(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: fullName,
                      email: email,
                      avatar: 'assets/images/homescreen.png',
                      role: '',
                      joinDate: DateTime.now(),
                      isVerified: false,
                      password: password, // Store password for simple testing
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("User Registered Successfully"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                  );
                },
                child: Center(
                  child: BoldText(
                    font: "YourFontFamily",
                    text: "Create Account",
                    size: isVerySmallPhone ? 14 : (isSmallPhone ? 14.5 : 15),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: isVerySmallPhone ? 16 : (isSmallPhone ? 18 : 20)),

          // Enhanced login section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: TextStyle(fontSize: isVerySmallPhone ? 13 : (isSmallPhone ? 14 : 15), color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: BoldText(
                  font: 'YourFontFamily',
                  text: 'Login',
                  size: isVerySmallPhone ? 13 : (isSmallPhone ? 14 : 15),
                  color: const Color(0xFF5F299E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Terms and Privacy Policy
          // Center(
          //   child: RichText(
          //     textAlign: TextAlign.center,
          //     text: TextSpan(
          //       style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          //       children: [
          //         const TextSpan(
          //           text: 'By Signing/Logging in, You agree to our ',
          //         ),
          //         TextSpan(
          //           text: 'Terms of Service',
          //           style: TextStyle(
          //             color: const Color(0xFF5F299E),
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         const TextSpan(text: ' and '),
          //         TextSpan(
          //           text: 'Privacy Policy',
          //           style: TextStyle(
          //             color: const Color(0xFF5F299E),
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Social login button widget
  Widget _buildSocialButton(
    String text,
    Color color,
    IconData icon,
    VoidCallback onTap,
    bool isSmallPhone,
    bool isVerySmallPhone,
  ) {
    return Container(
      height: isVerySmallPhone ? 42 : (isSmallPhone ? 46 : 50),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: isVerySmallPhone ? 18 : (isSmallPhone ? 19 : 20)),
              SizedBox(width: isVerySmallPhone ? 8 : (isSmallPhone ? 9 : 10)),
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Enhanced text field widget with proper alignment
  Widget _buildEnhancedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    bool isSmallPhone = false,
    bool isVerySmallPhone = false,
  }) {
    return Container(
      height: isVerySmallPhone ? 45 : (isSmallPhone ? 47 : 50),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          // Icon container with proper alignment
          Container(
            width: isVerySmallPhone ? 45 : (isSmallPhone ? 47 : 50),
            height: isVerySmallPhone ? 45 : (isSmallPhone ? 47 : 50),
            decoration: BoxDecoration(
              color: const Color(0xFF5F299E).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(icon, color: const Color(0xFF5F299E), size: isVerySmallPhone ? 18 : (isSmallPhone ? 19 : 20)),
          ),
          // Text field with proper alignment
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: isVerySmallPhone ? 13 : (isSmallPhone ? 13.5 : 14),
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: isVerySmallPhone ? 13 : (isSmallPhone ? 13.5 : 14),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 14),
                  vertical: isVerySmallPhone ? 14 : (isSmallPhone ? 15 : 16),
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
