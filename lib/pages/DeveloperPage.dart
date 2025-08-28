import 'package:flutter/material.dart';
import 'package:fluttertest/pages/InterestBasedPage.dart';

class DeveloperPages extends StatefulWidget {
  const DeveloperPages({super.key});

  @override
  _DeveloperPagesState createState() => _DeveloperPagesState();
}

// Custom painter for the top curved shape - matching second image design
class TopCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    
    // Start from top left
    path.moveTo(0, 0);
    
    // Draw top edge
    path.lineTo(size.width, 0);
    
    // Draw right edge down
    path.lineTo(size.width, size.height * 0.6);
    
    // Create the curved bottom - matching second image curve
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.85,  // Control point
      size.width * 0.5, size.height * 0.9,    // Mid point
    );
    
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.95,  // Control point
      0, size.height * 0.75,                  // End point
    );
    
    // Close the path
    path.close();
    
    // Create a white fill for the curved area below the purple
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _DeveloperPagesState extends State<DeveloperPages>
    with TickerProviderStateMixin {
  String _selectedLanguage = '';
  int _currentSlide = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> languages = [
    { 
      'name': 'Java',
      'icon': Icons.coffee,  
      
      'color': Color.fromARGB(255, 151, 88, 0),
    },
    {
      'name': 'Kotlin',
      'icon': Icons.android,
      'color': Color.fromARGB(255, 115, 65, 252),
    },
    {
      'name': 'Swift',
      'icon': Icons.phone_iphone,
      'color': Color.fromARGB(255, 37, 148, 179),
    },
    {
      'name': 'MEAN',  
      'icon': Icons.code,
      'color': Color.fromARGB(255, 143, 0, 31),
    },
    {
      'name': 'Python',
      'icon': Icons.code,
      'color': Color.fromARGB(255, 55, 118, 171), 
    },
    {
      'name': 'React Native',
      'icon': Icons.phone_android,
      'color': Color.fromARGB(255, 97, 218, 251),
    },
    {  
      'name': 'Flutter',
      'icon': Icons.flutter_dash,
      'color': Color.fromARGB(255, 0, 188, 212),
    },
    {
      'name': 'Node.js',
      'icon': Icons.settings,
      'color': Color.fromARGB(255, 104, 159, 56),
    },
    {
      'name': 'Django',
      'icon': Icons.dns,
      'color': Color.fromARGB(255, 44, 62, 80),
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
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // Method to handle continuous scrolling
  void _handleSlideChange(int index) {
    setState(() {
      _currentSlide = index;
    });
    
    // Debug print to see slide changes
    print('Slide changed to: $index');
    
    // If we're at the last slide, we can optionally loop back to first
    // This is handled by the PageView itself when swiping
  }

  Widget _buildLanguageCard(Map<String, dynamic> lang) {
    final isSelected = _selectedLanguage == lang['name'];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Responsive values based on available width - adjusted for better spacing
        double horizontalMargin = constraints.maxWidth < 300 ? 12 : 18; 
      double verticalPadding = constraints.maxWidth < 300 ? 16 : 20; 
      double horizontalPadding = constraints.maxWidth < 300 ? 22 : 28; 
      double iconSize = constraints.maxWidth < 300 ? 28 : 34; 
      double iconPadding = constraints.maxWidth < 300 ? 14 : 18; 
      double fontSize = constraints.maxWidth < 300 ? 18 : 20; 
      double indicatorSize = constraints.maxWidth < 300 ? 30 : 36; 
      double checkIconSize = constraints.maxWidth < 300 ? 14 : 16; 

        return Container(
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 6), // Reduced vertical margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFF5F299E).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                setState(() {
                  _selectedLanguage = lang['name'];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [Color(0xFF5F299E), Color(0xFF5F299E)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [Colors.white, Colors.grey[50]!],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF5F299E) : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding
                  ),
                  child: Row(
                    children: [
                      // Technology icon - responsive
                      Container(
                        width: iconSize,
                        height: iconSize,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.2)
                              : lang['color'].withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          lang['icon'],
                          color: isSelected ? Colors.white : lang['color'],
                          size: iconSize * 0.65,
                        ),
                      ),
                      SizedBox(width: iconPadding),

                      // Language name - responsive
                      Expanded(
                        child: Text(
                          lang['name'],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF2D3748),
                            fontWeight: FontWeight.bold,
                            fontSize: fontSize,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),

                      // Selection indicator - responsive
                      Container(
                        width: indicatorSize,
                        height: indicatorSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.white : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? Colors.white : Colors.grey[400]!,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: const Color(0xFF5F299E),
                                size: checkIconSize,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDotIndicators() {
    // Calculate how many cards to show per slide based on screen width
    int cardsPerSlide;
    int totalSlides;
    
    if (MediaQuery.of(context).size.width <= 800) {
      // Mobile layout: 1 card per slide
      cardsPerSlide = 1;
      totalSlides = languages.length;
    } else {
      // Web layout: exactly 4 cards per slide
      cardsPerSlide = 4;
      totalSlides = (languages.length / cardsPerSlide).ceil();
    }
    
    // Debug print to see the values
    print('Cards per slide: $cardsPerSlide, Total slides: $totalSlides, Current slide: $_currentSlide');
    
    // Only show dots if there are multiple slides
    if (totalSlides <= 1) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalSlides,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _currentSlide = index;
              });
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: _currentSlide == index ? 30 : 12,
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: _currentSlide == index
                    ? const Color(0xFF5F299E)
                    : Colors.grey[400],
                boxShadow: _currentSlide == index
                    ? [
                        BoxShadow(
                          color: const Color(0xFF5F299E).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          // Define responsive breakpoints
          if (screenWidth > 800) {
            return _buildWebLayout(screenWidth, screenHeight);
          } else {
            return _buildMobileLayout(screenWidth, screenHeight);
          }
        },
      ),
    );
  }


  Widget _buildMobileLayout(double screenWidth, double screenHeight) {
    
    double horizontalPadding = screenWidth < 360 ? 20 : 30;
    double titleFontSize = screenWidth < 360 ? 18 : 20;
    double subtitleFontSize = screenWidth < 360 ? 12 : 14;
    double imageHeight = screenHeight < 700 ? 100 : 120; 
    double cardHeight = screenHeight < 700 ? 80 : 130; 
    double topCurveHeight = screenHeight * 0.25; // Increased curve height to match second image

    return Stack(
      children: [
        // Purple curved background shape - matching second image
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: topCurveHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5F299E),
                    Color(0xFF7B3FB8),
                  ],
                ),
              ),
              child: CustomPaint(
                painter: TopCurvePainter(),
                size: Size(screenWidth, topCurveHeight),
              ),
            ),
          ),
        ),

        // Content with SafeArea
        SafeArea(
          child: Column(
            children: [
              // Back button for mobile
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Developer Courses",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Invisible container to balance the layout
                    Container(width: 44, height: 44),
                  ],
                ),
              ),
              
              // Add spacing to push content down below the curve
              SizedBox(height: topCurveHeight * 0.2),
              
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: screenHeight * 0.015), 

                          // Title container with enhanced styling
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth < 360 ? 15 : 20,
                              vertical: screenWidth < 360 ? 8 : 10, 
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
                            child: Text(
                              "Select Your Programming Language",
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D3748),
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.008),

                          Text(
                            "Choose your preferred technology stack",
                            style: TextStyle(
                              fontSize: subtitleFontSize,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          // Enhanced developer image - responsive
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFF7B440).withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/developer.png',
                                height: imageHeight,
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          // Language cards - fixed height instead of Expanded
                          Container(
                            height: cardHeight,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: FadeTransition(
                                opacity: _fadeAnimation,
                                child: PageView.builder(
                                  controller: _pageController,
                                  onPageChanged: _handleSlideChange,
                                  itemCount: languages.length,
                                  itemBuilder: (context, slideIndex) {
                                    return Center(
                                      child: _buildLanguageCard(languages[slideIndex]),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.015),

                          // Dot indicators
                          _buildDotIndicators(),

                          SizedBox(height: screenHeight * 0.02),

                          // Enhanced navigation buttons
                          _buildNavigationButtons(),

                          SizedBox(height: screenHeight * 0.015),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Web layout - fixed layout like the image, no scrolling
  Widget _buildWebLayout(double screenWidth, double screenHeight) {
    // Calculate responsive values to fit everything in viewport - adjusted to prevent overflow
    double availableHeight = screenHeight;
    double topShapeHeight = availableHeight * 0.12; // Reduced from 15% to 12%
    double contentHeight = availableHeight - topShapeHeight;

    // Responsive sizing based on screen width - adjusted to prevent overflow
    double titleFontSize = screenWidth < 1000 ? 20 : screenWidth < 1200 ? 24 : 28;
    double subtitleFontSize = screenWidth < 1000 ? 12 : screenWidth < 1200 ? 14 : 16;
    double imageHeight = contentHeight * 0.30; // Reduced from 30% to 25%
    double cardHeight = contentHeight * 0.25; // Reduced from 24% to 20%
    double horizontalPadding = screenWidth < 1000 ? 20 : screenWidth < 1200 ? 40 : 60;

    return Stack(
      children: [
        // Background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF5F299E).withValues(alpha: 0.05),
                Colors.white,
                const Color(0xFF5F299E).withValues(alpha: 0.02),
              ],
            ),
          ),
        ),

        // Top purple curved shape
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: topShapeHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5F299E),
                    Color(0xFF7B3FB8),
                    Color(0xFF9B59D1),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
          ),
        ),

        // Main content area 
        Positioned(
          top: topShapeHeight,
          left: 0,
          right: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Top spacing - reduced
                      SizedBox(height: screenWidth < 1000 ? 10 : screenWidth < 1200 ? 15 : 20),
                      // Title section 
                      Transform.translate(
                        offset: const Offset(0, -50), // Reduced from -70 to -50
                        child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth < 1000 ? 20 : 30,
                          vertical: screenWidth < 1000 ? 12 : 16, // Reduced padding
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF5F299E).withValues(alpha: 0.2),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF5F299E).withValues(alpha: 0.1),
                              blurRadius: 25,
                              offset: const Offset(0, 15),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Select Your Programming Language",
                              style: TextStyle(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D3748),
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 6), // Reduced spacing
                            Text(
                              "Choose your preferred technology stack",
                              style: TextStyle(
                                fontSize: subtitleFontSize,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        ),
                      ),

                      // Developer image - adjusted positioning
                      Transform.translate(
                        offset: const Offset(0, -10), // Reduced from -20 to -10
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF5F299E).withValues(alpha: 0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 15),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/images/developer.png',
                              height: imageHeight,
                            ),
                          ),
                        ),
                      ),

                      // Spacing between image and technology boxes - reduced
                      SizedBox(height: screenWidth < 1000 ? 8 : screenWidth < 1200 ? 15 : 20),

                      // Language cards - slider
                      _buildWebLanguageRow(screenWidth, cardHeight),

                      // Dot indicators for web layout - reduced spacing
                      SizedBox(height: screenWidth < 1000 ? 10 : screenWidth < 1200 ? 15 : 20),
                      _buildDotIndicators(),

                      // Spacing before navigation buttons - reduced
                      SizedBox(height: screenWidth < 1000 ? 15 : screenWidth < 1200 ? 20 : 25),

                      // Navigation buttons
                      _buildNavigationButtons(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Web language row - slider showing exactly 4 cards per slide
  Widget _buildWebLanguageRow(double screenWidth, double cardHeight) {
    // Responsive spacing based on screen width
    double cardSpacing = screenWidth < 1000 ? 8 : screenWidth < 1200 ? 12 : 16;
    
    // Fixed: Always show exactly 4 cards per slide on web
    int cardsPerSlide = 4;
    
    // Calculate total number of slides needed
    int totalSlides = (languages.length / cardsPerSlide).ceil();

    return SizedBox(
      height: cardHeight,
      child: PageView.builder(
controller: _pageController,
onPageChanged: _handleSlideChange,
itemCount: totalSlides,
itemBuilder: (context, slideIndex) {
// Calculate start and end indices for this slide
int startIndex = slideIndex * cardsPerSlide;
int endIndex = (startIndex + cardsPerSlide).clamp(0, languages.length);
          
// Create a list of cards for this slide
List<Widget> slideCards = [];
for (int i = startIndex; i < endIndex; i++) {
slideCards.add(
Expanded(
child: Container(
margin: EdgeInsets.symmetric(horizontal: cardSpacing / 2),
child: _buildWebLanguageCard(languages[i], cardHeight),
),
),
);
}
          
// If we don't have enough cards to fill the slide, add empty spaces
while (slideCards.length < cardsPerSlide) {
slideCards.add(
Expanded(
child: Container(
margin: EdgeInsets.symmetric(horizontal: cardSpacing / 2),
),
),
);
}
          
return Row(
children: slideCards,
);
},
),
);
}

// Web language card - matches the image style exactly
Widget _buildWebLanguageCard(Map<String, dynamic> lang, double cardHeight) {
final isSelected = _selectedLanguage == lang['name'];

    // Responsive values based on card height
    double iconSize = cardHeight * 0.25; // 25% of card height
    double fontSize = cardHeight * 0.08; // 8% of card height
    double padding = cardHeight * 0.08; // 8% of card height
    double indicatorSize = cardHeight * 0.12; // 12% of card height

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            setState(() {
              _selectedLanguage = lang['name'];
            });
          },
          child: Container(
            height: cardHeight,
            padding: EdgeInsets.all(padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Technology icon with background circle
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: lang['color'].withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    lang['icon'],
                    color: lang['color'],
                    size: iconSize * 0.5,
                  ),
                ),

                SizedBox(height: cardHeight * 0.08),

                // Language name
                Text(
                  lang['name'],
                  style: TextStyle(
                    color: const Color(0xFF2D3748),
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: cardHeight * 0.06),

                // Selection indicator - radio button style
                Container(
                  width: indicatorSize,
                  height: indicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFF5F299E) : Colors.grey[400]!,
                      width: 2,
                    ),
                    color: Colors.white,
                  ),
                  child: isSelected
                      ? Container(
                          margin: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF5F299E),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigation buttons - shared between mobile and web
  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
            color: Colors.white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InterestBasedPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Next button
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: _selectedLanguage.isNotEmpty
                ? const LinearGradient(
                    colors: [
                      Color(0xFF5F299E),
                      Color(0xFF5F299E),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Colors.grey[300]!,
                      Colors.grey[400]!,
                    ],
                  ),
            boxShadow: _selectedLanguage.isNotEmpty
                ? [
                    BoxShadow(
                      color: const Color(0xFFF7B440).withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: _selectedLanguage.isNotEmpty
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/dashboard',
                        arguments: {
                          'role': 'Developer',
                          'language': _selectedLanguage,
                        },
                      );
                    }
                  
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedLanguage.isNotEmpty
                            ? Colors.white
                            : Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: _selectedLanguage.isNotEmpty
                          ? Colors.white
                          : Colors.grey[600],
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}