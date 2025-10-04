import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart'; // ✅ import DevicePreview
import 'theme.dart';
import 'screens/home_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/education_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // set to false to disable device preview
      builder: (context) => const KnowYourFlowApp(),
    ),
  );
}

class KnowYourFlowApp extends StatelessWidget {
  const KnowYourFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Know Your Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      useInheritedMediaQuery: true, // ✅ required for DevicePreview
      locale: DevicePreview.locale(context), // ✅ required for DevicePreview
      builder: DevicePreview.appBuilder, // ✅ required for DevicePreview
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TrackerScreen(),
    EducationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Tracker'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Education'),
        ],
      ),
    );
  }
}
