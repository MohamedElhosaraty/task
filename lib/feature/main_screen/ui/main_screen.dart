import 'package:flutter/material.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/widgets/bottom_nav_bar.dart';
import '../../home/ui/page/home_view.dart';
import '../../profile/ui/page/profile_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int index = 0;

  final List<Widget> _pages = const [
    HomeView(),
    ProfileView(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _pages[index],
      bottomNavigationBar: MyBottomNavBar(
        selectedIndex: index,
        onItemTapped: (i) => setState(() => index = i),),
    );
  }
}