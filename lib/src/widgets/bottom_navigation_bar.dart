// описание навигационной панели
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../utils/utils.dart';

class JoyveeNavigationBar extends StatelessWidget {
  final void Function(int) onTap;
  final int index;
  const JoyveeNavigationBar({
    Key? key,
    required this.index,
    required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int i, bool isActive) {
          IconData icon;
          switch(i) {
            case 0:
              icon = (isActive) ? JoyveeIcons.home_filled : JoyveeIcons.home_outlined;
              break;
            case 1:
              icon = (isActive) ? JoyveeIcons.feed_filled : JoyveeIcons.feed_outlined;
              break;
            case 2:
              icon = (isActive) ? JoyveeIcons.messenger_filled : JoyveeIcons.messenger_outlined;
              break;
            case 3:
              icon = (isActive) ? JoyveeIcons.profile_filled : JoyveeIcons.profile_outlined;
              break;
            default:
              icon = Icons.home;
              break;
          }
          return Icon(icon, color: JoyveeColors.darkPurple,);
        },
        notchMargin: 5,
        splashRadius: 0,
        blurEffect: true,
        // elevation: 0.0,
        backgroundColor: Colors.white.withOpacity(.6),
        activeIndex: index,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: onTap);
  }
}
