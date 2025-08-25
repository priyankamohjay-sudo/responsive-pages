import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedButton; // No button selected initially

  void _onButtonPressed(String buttonType) {
    setState(() {
      _selectedButton = buttonType;
    });

    // Delay navigation slightly to show the color change
    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return; // Check if widget is still mounted
      if (buttonType == 'login') {
        Navigator.pushNamed(context, '/loginpage');
      } else if (buttonType == 'register') {
        Navigator.pushNamed(context, '/signuppage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // clean background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top Image
              Image.asset('assets/images/homescreen.png', height: 200),

              SizedBox(height: 40),

              // Login Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onButtonPressed('login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedButton == 'login'
                        ? Color(0xFF5F299E)
                        : Colors.white,
                    side: BorderSide(color: Color(0xFF5F299E)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedButton == 'login'
                          ? Colors.white
                          : Color(0xFF5F299E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _onButtonPressed('register'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedButton == 'register'
                        ? Color(0xFF5F299E)
                        : Colors.white,
                    side: BorderSide(color: Color(0xFF5F299E)),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      color: _selectedButton == 'register'
                          ? Colors.white
                          : Color(0xFF5F299E),
                      fontWeight: FontWeight.w600,
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
}
