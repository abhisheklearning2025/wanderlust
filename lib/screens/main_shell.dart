import 'package:flutter/material.dart';
import 'dashboard/dashboard_screen.dart';
import 'explore/explore_screen.dart';
import 'plan/plan_screen.dart';
import 'social/social_screen.dart';
import 'profile/profile_screen.dart';

/// Main shell that manages bottom nav tab switching.
/// Each screen that uses BottomNavBar navigates here via pushReplacement.
class MainShell extends StatefulWidget {
  final int initialIndex;

  const MainShell({super.key, this.initialIndex = 0});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;

  static const _screens = [
    DashboardScreen(),
    ExploreScreen(),
    PlanScreen(),
    SocialScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return _screens[_currentIndex];
  }
}
