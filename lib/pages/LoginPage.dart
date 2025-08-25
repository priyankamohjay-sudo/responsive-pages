import 'package:flutter/material.dart';

import 'package:fluttertest/Wedgets/BoldText.dart';
import 'package:fluttertest/models/user.dart';
import 'package:fluttertest/pages/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final emailController = TextEditingController();
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

    // Define breakpoints
    final isSmallPhone = screenWidth < 360;
    final isVerySmallPhone = screenHeight < 650; // For very small height screens
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildResponsiveLayout(context, screenWidth, screenHeight, isSmallPhone, isVerySmallPhone, isMobile, isTablet, isDesktop),
    );
  }

  Widget _buildResponsiveLayout(BuildContext context, double screenWidth, double screenHeight,
      bool isSmallPhone, bool isVerySmallPhone, bool isMobile, bool isTablet, bool isDesktop) {

    if (isDesktop || isTablet) {
      // Desktop and Tablet Layout - Split screen with form on left, illustration on right
      return Container(
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE8E2F7),
              Color(0xFFF3F0FF),
              Color(0xFFE8E2F7),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: screenWidth * (isDesktop ? 0.9 : 0.95),
            height: screenHeight * (isDesktop ? 0.85 : 0.9),
            constraints: BoxConstraints(
              maxWidth: isDesktop ? 1200 : 900,
              maxHeight: isDesktop ? 700 : 650,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isDesktop ? 32 : 24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: isDesktop ? 40 : 30,
                  offset: const Offset(0, 20),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              children: [
                // Left side - Login Form with improved spacing
                Expanded(
                  flex: isDesktop ? 5 : 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 60 : 40,
                      vertical: isDesktop ? 40 : 30,
                    ),
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: _buildWebLoginForm(context, isDesktop),
                        ),
                      ),
                    ),
                  ),
                ),
                // Right side - Illustration with improved proportions
                Expanded(
                  flex: isDesktop ? 6 : 5,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF7C3AED),
                          Color(0xFF5F299E),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(isDesktop ? 32 : 24),
                        bottomRight: Radius.circular(isDesktop ? 32 : 24),
                      ),
                    ),
                    child: _buildIllustrationSection(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Mobile Layout - Original design preserved
      return Container(
        height: screenHeight,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Column(
              children: [
                // Top decorative shape with responsive height
                SizedBox(
                  height: isVerySmallPhone ? 100 : (isSmallPhone ? 120 : 180),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/shape7.png",
                        width: double.infinity,
                        height: isVerySmallPhone ? 100 : (isSmallPhone ? 120 : 180),
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main login content with animation - centered
                Expanded(
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: _buildMobileLoginForm(context, isSmallPhone, isVerySmallPhone),
                      ),
                    ),
                  ),
                ),

                // Bottom decorative shape with responsive height
                SizedBox(
                  height: isVerySmallPhone ? 60 : (isSmallPhone ? 80 : 120),
                  child: Image.asset(
                    "assets/images/shape6.png",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }



  Widget _buildWebLoginForm(BuildContext context, bool isDesktop) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 16 : 12),
      padding: EdgeInsets.all(isDesktop ? 24 : 20),
      constraints: BoxConstraints(
        maxWidth: isDesktop ? 380 : 340,
        maxHeight: isDesktop ? 520 : 460,
      ),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome text with enhanced styling (same as mobile)
          Center(
            child: Column(
              children: [
                BoldText(
                  font: 'YourFontFamily',
                  text: 'Welcome MI SKILLS!',
                  size: isDesktop ? 24 : 22,
                  color: Theme.of(context).textTheme.titleLarge?.color ?? const Color(0xFF2D3748),
                ),
                SizedBox(height: isDesktop ? 6 : 4),
                Text(
                  'Sign in to continue your journey',
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 13,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Enhanced form fields (same as mobile)
          _buildEnhancedTextField(
            controller: emailController,
            label: "Email Address",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            isSmallPhone: false,
            isVerySmallPhone: false,
          ),
          SizedBox(height: isDesktop ? 12 : 10),

          _buildEnhancedTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            isSmallPhone: false,
            isVerySmallPhone: false,
          ),
          SizedBox(height: isDesktop ? 10 : 8),

          // Enhanced remember me section (same as mobile)
          Row(
            children: [
              Transform.scale(
                scale: isDesktop ? 1.2 : 1.0,
                child: Checkbox(
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(
                    color: tracker
                        ? const Color(0xFF5F299E)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  activeColor: const Color(0xFF5F299E),
                  value: tracker,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        tracker = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: isDesktop ? 8 : 4),
              BoldText(
                font: "YourFontFamily",
                text: "Remember Me",
                color: const Color(0xFF4A5568),
                size: isDesktop ? 14 : 13,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Add forgot password functionality
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: const Color(0xFF5F299E),
                    fontSize: isDesktop ? 13 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isDesktop ? 16 : 12),
          // Enhanced login button with gradient and animation (same as mobile)
          Container(
            height: isDesktop ? 52 : 50,
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
                onTap: () => _handleLogin(context),
                child: Center(
                  child: BoldText(
                    font: "YourFontFamily",
                    text: "Sign In",
                    size: isDesktop ? 16 : 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Enhanced sign up section (same as mobile)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 13,
                  color: Colors.grey[600]
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: BoldText(
                  font: 'YourFontFamily',
                  text: 'Sign Up',
                  size: isDesktop ? 14 : 13,
                  color: const Color(0xFF5F299E),
                ),
              ),
            ],
          ),
          ],
        ),
      );
  }

  Widget _buildMobileLoginForm(BuildContext context, bool isSmallPhone, bool isVerySmallPhone) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isVerySmallPhone ? 12 : (isSmallPhone ? 16 : 24)),
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
                  text: 'Welcome Back!',
                  size: isVerySmallPhone ? 20 : (isSmallPhone ? 22 : 26),
                  color: Theme.of(context).textTheme.titleLarge?.color ?? const Color(0xFF2D3748),
                ),
                SizedBox(height: isVerySmallPhone ? 3 : (isSmallPhone ? 4 : 6)),
                Text(
                  'Sign in to continue your journey',
                  style: TextStyle(
                    fontSize: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 15),
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isVerySmallPhone ? 18 : (isSmallPhone ? 24 : 32)),

          // Enhanced form fields
          _buildEnhancedTextField(
            controller: emailController,
            label: "Email Address",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 8 : (isSmallPhone ? 12 : 16)),

          _buildEnhancedTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
            isSmallPhone: isSmallPhone,
            isVerySmallPhone: isVerySmallPhone,
          ),
          SizedBox(height: isVerySmallPhone ? 6 : (isSmallPhone ? 8 : 12)),

          // Enhanced remember me section
          Row(
            children: [
              Transform.scale(
                scale: isVerySmallPhone ? 0.9 : (isSmallPhone ? 1.0 : 1.2),
                child: Checkbox(
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(
                    color: tracker
                        ? const Color(0xFF5F299E)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  activeColor: const Color(0xFF5F299E),
                  value: tracker,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        tracker = value;
                      });
                    }
                  },
                ),
              ),
              SizedBox(width: isVerySmallPhone ? 3 : (isSmallPhone ? 4 : 8)),
              BoldText(
                font: "YourFontFamily",
                text: "Remember Me",
                color: const Color(0xFF4A5568),
                size: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 15),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Add forgot password functionality
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: const Color(0xFF5F299E),
                    fontSize: isVerySmallPhone ? 11 : (isSmallPhone ? 12 : 14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: isVerySmallPhone ? 16 : (isSmallPhone ? 20 : 24)),

          // Enhanced login button with gradient and animation
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
                onTap: () => _handleLogin(context),
                child: Center(
                  child: BoldText(
                    font: "YourFontFamily",
                    text: "Sign In",
                    size: isVerySmallPhone ? 15 : (isSmallPhone ? 16 : 18),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: isVerySmallPhone ? 12 : (isSmallPhone ? 16 : 20)),

          // Enhanced sign up section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 15),
                  color: Colors.grey[600]
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: BoldText(
                  font: 'YourFontFamily',
                  text: 'Sign Up',
                  size: isVerySmallPhone ? 12 : (isSmallPhone ? 13 : 15),
                  color: const Color(0xFF5F299E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text with enhanced styling
            Center(
              child: Column(
                children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'How to I get started lorem ipsum dolor sit?',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

          // Enhanced form fields
          _buildDesktopTextField(
            controller: emailController,
            label: "Username",
            icon: Icons.person_outline,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          _buildDesktopTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
          ),
          const SizedBox(height: 24),

          // Enhanced login button
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF7C3AED), Color(0xFF5F299E)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5F299E).withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  String email = emailController.text.trim();
                  String password = passwordController.text;

                  // Check against registered users
                  bool found = false;

                  for (var user in registeredUsers) {
                    if (user.email == email && user.password == password) {
                      found = true;
                      break;
                    }
                  }

                  if (found) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Login Successful"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/interestpage',
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Invalid email or password"),
                        backgroundColor: Colors.red[400],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                child: const Center(
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Login with Others section
          Center(
            child: Column(
              children: [
                Text(
                  'Login with Others',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),

                // Google Login Button
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // Handle Google login
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Flexible(
                            child: Text(
                              'Login with Google',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF2D3748),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Facebook Login Button
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1877F2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        // Handle Facebook login
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'f',
                                style: TextStyle(
                                  color: Color(0xFF1877F2),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Flexible(
                            child: Text(
                              'Login with Facebook',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
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
        ],
      ),
    ),
    );
  }

  Widget _loginPage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(28),
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
                  text: 'Welcome Back!',
                  size: 26,
                  color: Theme.of(context).textTheme.titleLarge?.color ?? const Color(0xFF2D3748),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign in to continue your journey',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Enhanced form fields
          _buildEnhancedTextField(
            controller: emailController,
            label: "Email Address",
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          _buildEnhancedTextField(
            controller: passwordController,
            label: "Password",
            icon: Icons.lock_outline_rounded,
            obscureText: true,
          ),
          const SizedBox(height: 12),

          // Enhanced remember me section
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: BorderSide(
                    color: tracker
                        ? const Color(0xFF5F299E)
                        : Colors.grey[400]!,
                    width: 2,
                  ),
                  activeColor: const Color(0xFF5F299E),
                  value: tracker,
                  onChanged: (bool? value) {
                    if (value != null) {
                      setState(() {
                        tracker = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              const BoldText(
                font: "YourFontFamily",
                text: "Remember Me",
                color: Color(0xFF4A5568),
                size: 15,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Add forgot password functionality
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFF5F299E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Enhanced login button with gradient and animation
          Container(
            height: 56,
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
                  String password = passwordController.text;

                  // Check against registered users
                  bool found = false;

                  for (var user in registeredUsers) {
                    if (user.email == email && user.password == password) {
                      found = true;
                      break;
                    }
                  }

                  if (found) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Login Successful"),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/interestpage',
                        );
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text("Invalid email or password"),
                        backgroundColor: Colors.red[400],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }
                },
                child: const Center(
                  child: BoldText(
                    font: "YourFontFamily",
                    text: "Sign In",
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Enhanced sign up section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(fontSize: 15, color: Colors.grey[600]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const BoldText(
                  font: 'YourFontFamily',
                  text: 'Sign Up',
                  size: 15,
                  color: Color(0xFF5F299E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Handle login logic
  void _handleLogin(BuildContext context) {
    String email = emailController.text.trim();
    String password = passwordController.text;

    // Check against registered users
    bool found = false;

    for (var user in registeredUsers) {
      if (user.email == email && user.password == password) {
        found = true;
        break;
      }
    }

    if (found) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Login Successful"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/interestpage',
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Invalid email or password"),
          backgroundColor: Colors.red[400],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  // Social login buttons
  Widget _buildSocialLoginButtons(bool isDesktop) {
    return Column(
      children: [
        // Google Login Button
        Container(
          height: isDesktop ? 48 : 44,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // Handle Google login
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: isDesktop ? 16 : 14,
                    height: isDesktop ? 16 : 14,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'G',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 10 : 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 8 : 6),
                  Flexible(
                    child: Text(
                      'Login with Google',
                      style: TextStyle(
                        fontSize: isDesktop ? 12 : 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2D3748),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: isDesktop ? 8 : 6),

        // Facebook Login Button
        Container(
          height: isDesktop ? 48 : 44,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1877F2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // Handle Facebook login
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: isDesktop ? 16 : 14,
                    height: isDesktop ? 16 : 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'f',
                        style: TextStyle(
                          color: const Color(0xFF1877F2),
                          fontSize: isDesktop ? 10 : 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isDesktop ? 8 : 6),
                  Flexible(
                    child: Text(
                      'Login with Facebook',
                      style: TextStyle(
                        fontSize: isDesktop ? 12 : 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
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

  // Web text field widget
  Widget _buildWebTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required bool isDesktop,
  }) {
    return Container(
      height: isDesktop ? 56 : 50,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: isDesktop ? 50 : 45,
            height: isDesktop ? 56 : 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5F299E).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF5F299E),
              size: isDesktop ? 20 : 18
            ),
          ),
          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: isDesktop ? 14 : 13,
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: isDesktop ? 14 : 13,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 16 : 14,
                  vertical: isDesktop ? 16 : 14,
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Desktop text field widget
  Widget _buildDesktopTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 50,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF5F299E).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Icon(icon, color: const Color(0xFF5F299E), size: 20),
          ),
          // Text field
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF2D3748),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Illustration section for desktop
  Widget _buildIllustrationSection(BuildContext context) {
    return Stack(
      children: [
        // Background decorative elements with improved positioning
        Positioned(
          top: 30,
          left: 30,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 40,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),

        // Main illustration content with improved size and quality
        Center(
          child: Stack(
            children: [
              // Larger clean rounded container with high-quality image
              Container(
                width: 420, // Increased from 350
                height: 480, // Increased from 400
                decoration: BoxDecoration(
                  color: const Color(0xFFB19CD9).withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(40), // Slightly larger radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 25,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    width: 420,
                    height: 480,
                    child: Image.asset(
                      'assets/images/login_web_image.png',
                      fit: BoxFit.cover, // Use cover for better quality
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      cacheWidth: 840, // Cache at 2x resolution for crisp display
                      cacheHeight: 960, // Cache at 2x resolution for crisp display
                      errorBuilder: (context, error, stackTrace) {
                        // Try alternative image name
                        return Image.asset(
                          'assets/images/login-web image.png',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                          cacheWidth: 840, // Cache at 2x resolution for crisp display
                          cacheHeight: 960, // Cache at 2x resolution for crisp display
                          errorBuilder: (context, error2, stackTrace2) {
                            // Clean fallback placeholder with larger size
                            return Container(
                              width: 420,
                              height: 480,
                              decoration: BoxDecoration(
                                color: const Color(0xFFB19CD9).withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 240, // Increased proportionally
                                    height: 300, // Increased proportionally
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 140, // Increased icon size
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Professional Woman\nwith Tablet',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20, // Slightly larger text
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Lightning bolt icon with improved positioning and size
              Positioned(
                bottom: 80, // Adjusted for larger container
                left: 40, // Adjusted for larger container
                child: Container(
                  width: 65, // Slightly larger
                  height: 65, // Slightly larger
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withValues(alpha: 0.5),
                        blurRadius: 22,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.flash_on,
                    size: 35, // Slightly larger icon
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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
    final height = isVerySmallPhone ? 45.0 : (isSmallPhone ? 50.0 : 56.0);
    final iconSize = isVerySmallPhone ? 40.0 : (isSmallPhone ? 45.0 : 50.0);
    final fontSize = isVerySmallPhone ? 13.0 : (isSmallPhone ? 14.0 : 16.0);
    final iconSizeIcon = isVerySmallPhone ? 18.0 : (isSmallPhone ? 20.0 : 22.0);
    final padding = isVerySmallPhone ? 12.0 : (isSmallPhone ? 14.0 : 16.0);

    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          // Icon container with proper alignment
          Container(
            width: iconSize,
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF5F299E).withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(icon, color: const Color(0xFF5F299E), size: iconSizeIcon),
          ),
          // Text field with proper alignment
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: fontSize,
                color: const Color(0xFF2D3748),
                height: 1.2,
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding,
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
