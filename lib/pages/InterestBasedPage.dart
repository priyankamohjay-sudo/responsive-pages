import 'package:flutter/material.dart';

class InterestBasedPage extends StatefulWidget {
  const InterestBasedPage({super.key});

  @override
  _InterestBasedPageState createState() => _InterestBasedPageState();
}

class _InterestBasedPageState extends State<InterestBasedPage>
    with TickerProviderStateMixin { 
  String _selectedLanguage = '';
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> interests = [
    {
      'title': 'Web Development',
      'subtitle': 'Build amazing web applications',
      'icon': Icons.web,
      'color': Color.fromARGB(255, 4, 125, 158),
      'route': '/developerpage',
      'description':
          'Create responsive websites and web apps using modern frameworks',
    },
    {
      'title': 'Testing & QA',
      'subtitle': 'Ensure quality & reliability',
      'icon': Icons.bug_report,
      'color': Color.fromARGB(255, 24, 94, 9),
      'route': '/testerpage',
      'description':
          'Test applications and ensure they work perfectly for users',
    },
    {
      'title': 'DevOps & Cloud',
      'subtitle': 'Deploy & manage infrastructure',
      'icon': Icons.cloud,
      'color': Color.fromARGB(255, 19, 63, 160),
      'route': '/devoppage',
      'description': 'Manage servers, deployments and cloud infrastructure',
    },
    {
      'title': 'Digital Marketing',
      'subtitle': 'Grow brands & reach audiences',
      'icon': Icons.campaign,
      'color': Color.fromARGB(255, 163, 12, 63),
      'route': '/digitalmarketingpage',
      'description':
          'Create campaigns and grow business through digital channels',
    },
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWeb = constraints.maxWidth > 800;

          if (isWeb) {
            return _buildWebLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  // Mobile layout - fixed for overflow prevention
  Widget _buildMobileLayout() {
    return SafeArea(
      child: Column(
        children: [
          // Top decorative image with animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Image.asset(
                'assets/images/shape8.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    // Title
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF5F299E).withValues(alpha: 0.1),
                            const Color(0xFF5F299E).withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: const Color(0xFFF7B440).withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: const Text(
                        'Select Your Interest',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3748),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      'Swipe to explore different career paths',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Card Slider with SpringBoot style
                    SizedBox(
                      height: 110,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemCount: interests.length,
                        itemBuilder: (context, index) {
                          final interest = interests[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildInterestCard(interest),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Dots Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        interests.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentIndex == index ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? const Color(0xFF5F299E)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Next Button
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 60),
                      height: 56,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: _selectedLanguage.isNotEmpty
                            ? const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF5F299E),
                                  Color(0xFF5F299E),
                                ],
                              )
                            : null,
                        color: _selectedLanguage.isEmpty
                            ? Colors.grey[300]
                            : null,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: _selectedLanguage.isNotEmpty
                            ? [
                                BoxShadow(
                                  color: const Color(0xFFF7B440).withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: _selectedLanguage.isNotEmpty ? _handleNext : null,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: _selectedLanguage.isNotEmpty
                                        ? Colors.white
                                        : Colors.grey[500],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  color: _selectedLanguage.isNotEmpty
                                      ? Colors.white
                                      : Colors.grey[500],
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer image with animation
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              child: Image.asset(
                'assets/images/shape9.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Web layout - with interest-background2 image
  Widget _buildWebLayout() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive design based on screen size
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        // Determine responsive values
        double maxWidth = 1000;
        double horizontalPadding = 40;
        double verticalPadding = 60;
        double titleFontSize = 28;
        double subtitleFontSize = 16;
        double titlePadding = 40;
        double buttonWidth = 280;

        // Adjust for different screen sizes
        if (screenWidth < 900) {
          // Small web screens / tablets
          maxWidth = 700;
          horizontalPadding = 30;
          verticalPadding = 40;
          titleFontSize = 24;
          subtitleFontSize = 14;
          titlePadding = 30;
          buttonWidth = 240;
        }

        if (screenWidth < 600) {
          // Very small web screens
          maxWidth = 500;
          horizontalPadding = 20;
          verticalPadding = 30;
          titleFontSize = 22;
          subtitleFontSize = 13;
          titlePadding = 25;
          buttonWidth = 200;
        }

        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/interest-backgound2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                ),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Title with white background
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: titlePadding,
                                vertical: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Select Your Interest',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2D3748),
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Subtitle in white text
                            Text(
                              'Choose your career path to get started',
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: 50),

                            // Interest Cards Grid - 2x2 layout
                            _buildWebInterestGrid(),

                            const SizedBox(height: 50),

                            // Continue Button - stays white background, purple text when selected
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: buttonWidth,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white, // Always white background
                                borderRadius: BorderRadius.circular(28),
                                border: Border.all(
                                  color: _selectedLanguage.isNotEmpty
                                      ? const Color(0xFF7B3FB8) // Purple border when selected
                                      : Colors.grey[300]!, // Grey border when not selected
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: _selectedLanguage.isNotEmpty
                                        ? const Color(0xFF7B3FB8).withValues(alpha: 0.2)
                                        : Colors.black.withValues(alpha: 0.1),
                                    blurRadius: _selectedLanguage.isNotEmpty ? 20 : 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(28),
                                  onTap: _selectedLanguage.isNotEmpty ? _handleNext : null,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Continue",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: _selectedLanguage.isNotEmpty
                                                ? const Color(0xFF7B3FB8) // Purple text when selected
                                                : Colors.grey[500], // Grey text when not selected
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          color: _selectedLanguage.isNotEmpty
                                              ? const Color(0xFF7B3FB8) // Purple icon when selected
                                              : Colors.grey[500], // Grey icon when not selected
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Web Interest Grid - responsive layout for web and desktop
  Widget _buildWebInterestGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive grid based on screen width
        int crossAxisCount = 2; // Default 2x2 for web
        double childAspectRatio = 2.8;
        double crossAxisSpacing = 30;
        double mainAxisSpacing = 25;

        // Adjust for different screen sizes
        if (constraints.maxWidth > 1200) {
          // Large desktop screens
          crossAxisCount = 2;
          crossAxisSpacing = 50;
          mainAxisSpacing = 35;
          childAspectRatio = 3.5;
        } else if (constraints.maxWidth > 900) {
          // Standard desktop/laptop screens
          crossAxisCount = 2;
          crossAxisSpacing = 40;
          mainAxisSpacing = 30;
          childAspectRatio = 3.0;
        } else if (constraints.maxWidth > 700) {
          // Small desktop/large tablet screens
          crossAxisCount = 2;
          crossAxisSpacing = 30;
          mainAxisSpacing = 25;
          childAspectRatio = 2.8;
        } else if (constraints.maxWidth > 500) {
          // Small web screens/tablets
          crossAxisCount = 2;
          crossAxisSpacing = 20;
          mainAxisSpacing = 20;
          childAspectRatio = 2.5;
        } else {
          // Very small web screens
          crossAxisCount = 1; // Single column for very small screens
          crossAxisSpacing = 0;
          mainAxisSpacing = 15;
          childAspectRatio = 3.0;
        }

        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth > 800 ? 800 : constraints.maxWidth,
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: interests.length,
            itemBuilder: (context, index) {
              final interest = interests[index];
              return _buildWebInterestCard(interest);
            },
          ),
        );
      },
    );
  }

  // Web Interest Card - with color changing selection like mobile
  Widget _buildWebInterestCard(Map<String, dynamic> interest) {
    final isSelected = _selectedLanguage == interest['title'];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive sizing based on available width
        double cardPadding = 20;
        double iconSize = 48;
        double titleFontSize = 16;
        double descriptionFontSize = 12;
        double iconPadding = 16;

        // Adjust for smaller screens
        if (constraints.maxWidth < 300) {
          cardPadding = 15;
          iconSize = 40;
          titleFontSize = 14;
          descriptionFontSize = 11;
          iconPadding = 12;
        } else if (constraints.maxWidth < 400) {
          cardPadding = 18;
          iconSize = 44;
          titleFontSize = 15;
          descriptionFontSize = 11;
          iconPadding = 14;
        }

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedLanguage = interest['title'];
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              // Change background color when selected, like mobile
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        interest['color'],
                        interest['color'].withValues(alpha: 0.8),
                      ],
                    )
                  : const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected
                    ? interest['color'].withValues(alpha: 0.3)
                    : Colors.grey[200]!,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? interest['color'].withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.08),
                  blurRadius: isSelected ? 25 : 20,
                  offset: Offset(0, isSelected ? 12 : 8),
                  spreadRadius: isSelected ? 0 : -2,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(cardPadding),
              child: Row(
                children: [
                  // Icon with dynamic background based on selection
                  Container(
                    width: iconSize,
                    height: iconSize,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.2)
                          : interest['color'].withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.3)
                            : interest['color'].withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      interest['icon'],
                      color: isSelected ? Colors.white : interest['color'],
                      size: 24,
                    ),
                  ),

                  SizedBox(width: iconPadding),

                  // Text content with dynamic colors
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          interest['title'],
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : const Color(0xFF2D3748),
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          interest['description'],
                          style: TextStyle(
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.w400,
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.9)
                                : Colors.grey[600],
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Selection indicator (radio button style)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Colors.white
                            : Colors.grey[400]!,
                        width: 2,
                      ),
                      color: isSelected
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16,
                            color: interest['color'],
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Build interest card widget - Simple SpringBoot style (Mobile)
  Widget _buildInterestCard(Map<String, dynamic> interest) {
    final isSelected = _selectedLanguage == interest['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = interest['title'];
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 90,
        decoration: BoxDecoration(
          // Selected: Gradient background, Unselected: White background
          gradient: isSelected
              ? LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    interest['color'],
                    interest['color'].withValues(alpha: 0.8),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.grey[50],
          borderRadius: BorderRadius.circular(25),
          border: isSelected
              ? null
              : Border.all(color: Colors.grey[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? interest['color'].withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: isSelected ? 15 : 12,
              offset: Offset(0, isSelected ? 8 : 6),
              spreadRadius: isSelected ? -2 : -1,
            ),
            // Additional subtle shadow for unselected cards
            if (!isSelected)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              // Left icon
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  // Selected: Semi-transparent white, Unselected: Very light colored background
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : interest['color'].withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  interest['icon'],
                  // Selected: White icon, Unselected: Colored icon
                  color: isSelected ? Colors.white : interest['color'],
                  size: 24,
                ),
              ),

              const SizedBox(width: 30),

              // Title and description in center
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      interest['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // Selected: White text, Unselected: Dark text
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF2D3748),
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      interest['description'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        // Selected: Light white text, Unselected: Grey text
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.8)
                            : Colors.grey[600],
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              // Right selection indicator
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  // Selected: Semi-transparent white, Unselected: Very light grey
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      )
                    : Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey[400]!,
                            width: 2,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    final selectedInterest = interests.firstWhere(
      (interest) => interest['title'] == _selectedLanguage,
    );

    Navigator.pushReplacementNamed(context, selectedInterest['route']);
  }
}

// Custom painter for top curved purple shape
class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5F299E),
          Color(0xFF7B3FB8),
          Color(0xFF9B59D1),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Start from top left
    path.moveTo(0, 0);

    // Top edge
    path.lineTo(size.width, 0);

    // Right edge going down slightly
    path.lineTo(size.width, size.height * 0.3);

    // Create elegant curved bottom edge
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.7,
      size.width * 0.5, size.height * 0.85,
    );

    path.quadraticBezierTo(
      size.width * 0.2, size.height * 1.0,
      0, size.height * 0.6,
    );

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for bottom curved purple shape
class BottomCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF9B59D1),
          Color(0xFF7B3FB8),
          Color(0xFF5F299E),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    // Start from bottom left
    path.moveTo(0, size.height);

    // Bottom edge
    path.lineTo(size.width, size.height);

    // Right edge going up slightly
    path.lineTo(size.width, size.height * 0.7);

    // Create elegant curved top edge
    path.quadraticBezierTo(
      size.width * 0.8, size.height * 0.3,
      size.width * 0.5, size.height * 0.15,
    );

    path.quadraticBezierTo(
      size.width * 0.2, size.height * 0.0,
      0, size.height * 0.4,
    );

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
