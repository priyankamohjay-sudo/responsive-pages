import 'package:flutter/material.dart';
import '../widgets/app_layout.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: 'Special Offers',
      currentIndex: 0,
      showBackButton: true,
      showBottomNavigation: false,
      showHeaderActions: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          // Define responsive breakpoints
          bool isMobile = screenWidth <= 800;
          bool isTablet = screenWidth > 800 && screenWidth <= 1200;
          bool isDesktop = screenWidth > 1200;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.shade50,
                  Colors.white,
                  Colors.blue.shade50,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // 🔹 Decorative background shapes
                Positioned(
                  top: -80,
                  right: -80,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -100,
                  left: -60,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(125),
                    ),
                  ),
                ),

                // 🔹 Main Content
                SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      if (isDesktop || isTablet) ...[
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            'Special Offers & Promotions',
                            style: TextStyle(
                              fontSize: isDesktop ? 32 : 28,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2D3748),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: Text(
                            'Discover amazing discounts on our premium courses',
                            style: TextStyle(
                              fontSize: isDesktop ? 18 : 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],

                      // Cards Grid
                      if (isMobile) ...[
                        // Mobile: Single column layout
                        _buildMobileLayout(context),
                      ] else ...[
                        // Web/Desktop/Tablet: 2x2 grid layout
                        _buildWebLayout(context, screenWidth, isDesktop),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 🔹 Mobile Layout - Single Column
  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildOfferCard(
          context,
          percentage: '35%',
          title: 'Today\'s Special!',
          subtitle: 'Get discount for every course, only valid for today',
          additionalInfo: 'Limited time • All courses included',
          backgroundColor: const Color(0xFF8B5CF6),
          imageAsset: 'assets/images/developer.png',
        ),
        const SizedBox(height: 16),
        _buildOfferCard(
          context,
          percentage: '25%',
          title: 'Friday Special!',
          subtitle: 'Limited time offer for coding courses',
          additionalInfo: 'Web & Mobile Development • Save big',
          backgroundColor: const Color(0xFFEC4899),
          imageAsset: 'assets/images/tester.jpg',
        ),
        const SizedBox(height: 16),
        _buildOfferCard(
          context,
          percentage: '30%',
          title: 'New Promo!',
          subtitle: 'Get discount for every design course bundle',
          additionalInfo: 'UI/UX Design • Graphic Design • More',
          backgroundColor: const Color(0xFF06B6D4),
          imageAsset: 'assets/images/devop.jpg',
        ),
        const SizedBox(height: 16),
        _buildOfferCard(
          context,
          percentage: '45%',
          title: 'Weekend Special!',
          subtitle: 'Biggest discount for all programming courses',
          additionalInfo: 'Python • JavaScript • Java • C++ & More',
          backgroundColor: const Color(0xFFF59E0B),
          imageAsset: 'assets/images/splash1.png',
        ),
        const SizedBox(height: 16),
        _buildOfferCard(
          context,
          percentage: '40%',
          title: 'New Promo!',
          subtitle: 'Special offer for all development courses',
          additionalInfo: 'Full Stack • Backend • Frontend • DevOps',
          backgroundColor: const Color(0xFF3B82F6),
          imageAsset: 'assets/images/homescreen.png',
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  /// 🔹 Web/Desktop Layout - 2x2 Grid
  Widget _buildWebLayout(BuildContext context, double screenWidth, bool isDesktop) {
    final cardSpacing = isDesktop ? 24.0 : 20.0;
    final cardHeight = isDesktop ? 280.0 : 260.0;

    return Center(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: isDesktop ? 1400 : 1200,
        ),
        child: Column(
          children: [
            // First Row - 2 cards
            Row(
              children: [
                Expanded(
                  child: _buildWebOfferCard(
                    context,
                    percentage: '35%',
                    title: 'Today\'s Special!',
                    subtitle: 'Get discount for every course, only valid for today',
                    additionalInfo: 'Limited time • All courses included',
                    backgroundColor: const Color(0xFF8B5CF6),
                    imageAsset: 'assets/images/developer.png',
                    height: cardHeight,
                  ),
                ),
                SizedBox(width: cardSpacing),
                Expanded(
                  child: _buildWebOfferCard(
                    context,
                    percentage: '25%',
                    title: 'Friday Special!',
                    subtitle: 'Limited time offer for coding courses',
                    additionalInfo: 'Web & Mobile Development • Save big',
                    backgroundColor: const Color(0xFFEC4899),
                    imageAsset: 'assets/images/tester.jpg',
                    height: cardHeight,
                  ),
                ),
              ],
            ),
            SizedBox(height: cardSpacing),
            // Second Row - 2 cards
            Row(
              children: [
                Expanded(
                  child: _buildWebOfferCard(
                    context,
                    percentage: '30%',
                    title: 'New Promo!',
                    subtitle: 'Get discount for every design course bundle',
                    additionalInfo: 'UI/UX Design • Graphic Design • More',
                    backgroundColor: const Color(0xFF06B6D4),
                    imageAsset: 'assets/images/devop.jpg',
                    height: cardHeight,
                  ),
                ),
                SizedBox(width: cardSpacing),
                Expanded(
                  child: _buildWebOfferCard(
                    context,
                    percentage: '45%',
                    title: 'Weekend Special!',
                    subtitle: 'Biggest discount for all programming courses',
                    additionalInfo: 'Python • JavaScript • Java • C++ & More',
                    backgroundColor: const Color(0xFFF59E0B),
                    imageAsset: 'assets/images/splash1.png',
                    height: cardHeight,
                  ),
                ),
              ],
            ),
            SizedBox(height: cardSpacing),
            // Third Row - 1 card (left side for future expansion)
            Row(
              children: [
                Expanded(
                  child: _buildWebOfferCard(
                    context,
                    percentage: '40%',
                    title: 'New Promo!',
                    subtitle: 'Special offer for all development courses',
                    additionalInfo: 'Full Stack • Backend • Frontend • DevOps',
                    backgroundColor: const Color(0xFF3B82F6),
                    imageAsset: 'assets/images/homescreen.png',
                    height: cardHeight,
                  ),
                ),
                SizedBox(width: cardSpacing),
                // Empty space for future card
                Expanded(
                  child: Container(
                    height: cardHeight,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// 🔹 Mobile Offer Card
  Widget _buildOfferCard(
    BuildContext context, {
    required String percentage,
    required String title,
    required String subtitle,
    required String additionalInfo,
    required Color backgroundColor,
    required String imageAsset,
  }) {
    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background decorative circle
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: [
                  // Left side - Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          percentage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          additionalInfo,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // Coupon button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Use Coupon: SAVE20",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Right side - Image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 50,
                            ),
                          );
                        },
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

  /// 🔹 Web/Desktop Offer Card
  Widget _buildWebOfferCard(
    BuildContext context, {
    required String percentage,
    required String title,
    required String subtitle,
    required String additionalInfo,
    required Color backgroundColor,
    required String imageAsset,
    required double height,
  }) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.3),
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              right: -40,
              top: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  // Left side - Text content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          percentage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          additionalInfo,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        // Coupon button
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: backgroundColor,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                          ),
                          child: const Text(
                            "Use Coupon: SAVE20",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Right side - Image
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.school,
                              color: Colors.white,
                              size: 60,
                            ),
                          );
                        },
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
}