import 'package:flutter/material.dart';
import 'GroupChatPage.dart';
import '../services/favorites_service.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GroupPageTab extends StatefulWidget {
  final String selectedLanguage;

  const GroupPageTab({super.key, required this.selectedLanguage});

  @override
  State<GroupPageTab> createState() => _GroupPageTabState();
}

class _GroupPageTabState extends State<GroupPageTab> {
  final FavoritesService _favoritesService = FavoritesService();
  late List<Map<String, dynamic>> _groups;

  @override
  void initState() {
    super.initState();
    _favoritesService.addListener(_onFavoritesChanged);
    _initializeGroups();
  }

  @override
  void dispose() {
    _favoritesService.removeListener(_onFavoritesChanged);
    super.dispose();
  }

  void _initializeGroups() {
    _groups = [
      {
        'id': '1',
        'name': 'Flutter Enthusiasts',
        // 'members': 256,
        // 'memberCount': 256,
        'image': 'assets/images/developer.png',
        'color': '#5F299E',
        'description': 'A group for Flutter developers to share knowledge and projects',
        'lastMessage': 'Perfect! Will check it 🔥',
        'lastMessageTime': '09:34 PM',
        'unreadCount': 0,
        'isMember': true,
      },
      {
        'id': '2',
        'name': 'UI/UX Designers',
        // 'members': 189,
        // 'memberCount': 189,
        'image': 'assets/images/tester.jpg',
        'color': '#8B5CF6',
        'description': 'Discussing the latest design trends and best practices',
        'lastMessage': 'Thanks, Jimmy! Talk later',
        'lastMessageTime': '08:12 PM',
        'unreadCount': 2,
        'isMember': false,
      },
      {
        'id': '3',
        'name': 'DevOps Community',
        // 'members': 312,
        // 'memberCount': 312,
        'image': 'assets/images/devop.jpg',
        'color': '#10B981',
        'description': 'CI/CD, Docker, Kubernetes and more',
        'lastMessage': 'Sound good for me too!',
        'lastMessageTime': '02:29 PM',
        'unreadCount': 3,
        'isMember': true,
      },
      {
        'id': '4',
        'name': 'Mobile App Developers',
        // 'members': 421,
        // 'memberCount': 421,
        'image': 'assets/images/developer.png',
        'color': '#F59E0B',
        'description': 'For mobile developers across all platforms',
        'lastMessage': '✓ No rush, mate! Just let ...',
        'lastMessageTime': '01:08 PM',
        'unreadCount': 0,
        'isMember': false,
      },
      {
        'id': '5',
        'name': 'Web Development',
        // 'members': 523,
        // 'memberCount': 523,
        'image': 'assets/images/tester.jpg',
        'color': '#EF4444',
        'description': 'Frontend, Backend, Full-stack development',
        'lastMessage': 'Hey everyone! New project update',
        'lastMessageTime': '11:19 AM',
        'unreadCount': 1,
        'isMember': true,
      },
    ];
  }

  void _onFavoritesChanged() {
    if (mounted) {
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section - Separate from content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 30,
                left: 24,
                right: 24,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode
                    ? [
                        const Color.fromARGB(255, 98, 72, 139), // Dark red
                        const Color.fromARGB(109, 185, 127, 240), // Red
                      ]
                    : [
                        const Color.fromARGB(255, 82, 41, 116), // Red
                        const Color.fromARGB(255, 41, 7, 61), // Light red
                      ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                      ? Colors.black.withValues(alpha: 0.4)
                      : const Color(0xFFDC2626).withValues(alpha: 0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Groups',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(14),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withValues(alpha: 0.15),
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(
                      //       color: Colors.white.withValues(alpha: 0.25),
                      //       width: 1.5,
                      //     ),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.black.withValues(alpha: 0.1),
                      //         blurRadius: 8,
                      //         offset: const Offset(0, 4),
                      //       ),
                      //     ],
                      //   ),
                      //   // child: const Icon(
                      //   //   Icons.group_add_rounded,
                      //   //   color: Colors.white,
                      //   //   size: 26,
                      //   // ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Connect with fellow students and collaborate',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white.withValues(alpha: 0.95),
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Groups List - Simple list without Expanded
            const SizedBox(height: 24),
            ...(_groups.map((group) => Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: _buildGroupListItem(context, group),
            )).toList()),
            const SizedBox(height: 100), // Bottom padding for navigation
          ],
        ),
      ),
    );
  }

  Widget _buildGroupListItem(BuildContext context, Map<String, dynamic> group) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDarkMode
            ? const Color(0xFF2D2D2D)
            : const Color(0xFFE5E7EB),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
              ? Colors.black.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: isDarkMode
              ? Colors.black.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GroupChatPage(group: group),
              ),
            );
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                // Group Avatar
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(int.parse((group['color'] ?? '#5F299E').substring(1), radix: 16) + 0xFF000000),
                        Color(int.parse((group['color'] ?? '#5F299E').substring(1), radix: 16) + 0xFF000000).withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(int.parse((group['color'] ?? '#5F299E').substring(1), radix: 16) + 0xFF000000).withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      group['name'][0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Group Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              group['name'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: isDarkMode ? Colors.white : const Color(0xFF111827),
                                letterSpacing: -0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            group['lastMessageTime'],
                            style: TextStyle(
                              fontSize: 13,
                              color: isDarkMode
                                ? Colors.white.withValues(alpha: 0.6)
                                : const Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              group['lastMessage'],
                              style: TextStyle(
                                fontSize: 15,
                                color: isDarkMode
                                  ? Colors.white.withValues(alpha: 0.75)
                                  : const Color(0xFF6B7280),
                                height: 1.4,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          if (group['unreadCount'] > 0) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF8B5CF6), Color(0xFF5F299E)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Text(
                                group['unreadCount'].toString(),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
