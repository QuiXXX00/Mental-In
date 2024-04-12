import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:smart/feature/Calendar/ui/Calendar_main.dart';
import 'package:smart/feature/Recimendation/ui/Recimendation_main.dart';
import 'package:smart/feature/Test/ui/Tests_main.dart';
import 'package:smart/feature/Theory/ui/Theory_main.dart';
import 'package:smart/feature/auth/ui/welcome_screen.dart';
import 'package:smart/feature/home/ui/home_screen.dart';

import '../../Test/ui/Testiki.dart';

class BottonBar extends StatelessWidget {
  BottonBar({super.key});

  PersistentTabController _controller = PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      Rec(),
      Test(),
      HomeScreen(),
      Calendar(),// Assuming Rec is the recommendation screen
      Theory(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('Assets/icons/meditation.svg'),
        activeColorPrimary: Color(0xFF8E97FD),
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('Assets/icons/Group 30.svg'),
        activeColorPrimary: Color(0xFF8E97FD),
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('Assets/icons/Group 29.svg',color: Color(0xFFA0A3B1),),
        activeColorPrimary: Color(0xFF8E97FD),
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('Assets/icons/Group 28.svg'),
        activeColorPrimary: Color(0xFF8E97FD),
        inactiveColorPrimary: CupertinoColors.white,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset('Assets/icons/Group 27.svg'),
        activeColorPrimary: Color(0xFF8E97FD),
        inactiveColorPrimary: CupertinoColors.white,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        colorBehindNavBar: Colors.black,
        boxShadow: [BoxShadow(
          color: Color(0x1954575C),
          blurRadius: 17,
          offset: Offset(2, -5),
          spreadRadius: 0,
        )]
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
