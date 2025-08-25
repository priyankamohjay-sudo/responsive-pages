import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'EditProfilePage.dart';
import 'SettingsPage.dart';
import 'PrivacyPolicyPage.dart';
import 'TermsConditionsPage.dart';
import 'AboutUsPage.dart';
import 'PasswordChangePage.dart';
import '../providers/theme_provider.dart';

class ProfilePageTab extends StatefulWidget {
  final String selectedRole;
  final String selectedLanguage;

  const ProfilePageTab({
    super.key,
    required this.selectedRole,
    required this.selectedLanguage,
  });

  @override
  _ProfilePageTabState createState() => _ProfilePageTabState();
}

class _ProfilePageTabState extends State<ProfilePageTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Profile Header
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
              borderRadius: BorderRadius.circular(20),
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
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(
                        'assets/images/homescreen.png',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Color(0xFF5F299E),
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Robert Ransdell',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'robert.ransdell@email.com',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12,
                  ),
                ),
                Text(
                  '+1 (555) 123-4567',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                ),
                Text(
                  '${widget.selectedRole} • ${widget.selectedLanguage}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatColumn('12', 'Courses'),
                    _buildStatColumn('4.8', 'Rating'),
                    _buildStatColumn('156h', 'Hours'),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Color(0xFF5F299E),
              unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
              indicatorColor: Color(0xFF5F299E),
              indicatorWeight: 3,
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              tabs: [
                Tab(
                  icon: Icon(Icons.person_outline, size: 18),
                  text: 'Profile',
                ),
                Tab(
                  icon: Icon(Icons.settings_outlined, size: 18),
                  text: 'Settings',
                ),
              ],
            ),
          ),

          // Tab Content
          SizedBox(
            height: 400, // Fixed height for tab content
            child: TabBarView(
              controller: _tabController,
              children: [_buildProfileTab(), _buildSettingsTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTab() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildMenuOption(
            Icons.person_outline,
            'Edit Profile',
            'Update your personal information',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          _buildMenuOption(
            Icons.lock_outline,
            'Change Password',
            'Update your account password',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PasswordChangePage()),
              );
            },
          ),
          _buildMenuOption(
            Icons.privacy_tip_outlined,
            'Privacy Policy',
            'Read our privacy policy',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          _buildMenuOption(
            Icons.description_outlined,
            'Terms & Conditions',
            'Read our terms and conditions',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsConditionsPage()),
              );
            },
          ),
          _buildMenuOption(
            Icons.info_outline,
            'About Us',
            'Learn more about our company',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildMenuOption(
            Icons.settings_outlined,
            'App Settings',
            'Configure app preferences',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          _buildMenuOption(
            Icons.notifications_outlined,
            'Notifications',
            'Manage notification preferences',
            () {},
          ),
          _buildMenuOption(
            Icons.language_outlined,
            'Language',
            'Change app language',
            () {},
          ),
          _buildMenuOption(
            Icons.dark_mode_outlined,
            'Theme',
            'Switch between light and dark mode',
            () {
              _showThemeDialog();
            },
          ),
          _buildMenuOption(
            Icons.download_outlined,
            'Downloads',
            'Manage your downloaded courses',
            () {},
          ),
          _buildMenuOption(
            Icons.help_outline,
            'Help & Support',
            'Get help and contact support',
            () {},
          ),
          SizedBox(height: 20),
          _buildMenuOption(
            Icons.logout,
            'Logout',
            'Sign out of your account',
            () {
              _showLogoutDialog();
            },
            isLogout: true,
          ),
        ],
      ),
    );
  }

  void _showThemeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return AlertDialog(
              title: Text('Choose Theme'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Light Mode'),
                    subtitle: Text('Use light theme'),
                    leading: Icon(
                      themeProvider.themeMode == ThemeMode.light
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Color(0xFF5F299E),
                    ),
                    onTap: () {
                      themeProvider.setThemeMode(ThemeMode.light);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text('Dark Mode'),
                    subtitle: Text('Use dark theme'),
                    leading: Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Color(0xFF5F299E),
                    ),
                    onTap: () {
                      themeProvider.setThemeMode(ThemeMode.dark);
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text('System Default'),
                    subtitle: Text('Follow system theme'),
                    leading: Icon(
                      themeProvider.themeMode == ThemeMode.system
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: Color(0xFF5F299E),
                    ),
                    onTap: () {
                      themeProvider.setThemeMode(ThemeMode.system);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/loginpage',
                  (route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuOption(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red[50]
                : Color(0xFF5F299E).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.red : Color(0xFF5F299E),
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isLogout ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            fontSize: 12
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.4),
        ),
        onTap: onTap,
      ),
    );
  }
}
