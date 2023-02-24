//описание списков вкладок

import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';

class JoyveeMainTabBar extends StatelessWidget {
  const JoyveeMainTabBar({
    Key? key,
    required this.controller,
    required this.tabs
  });
  final TabController controller;
  final List<Tab> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      labelStyle: Theme.of(context).textTheme.headlineLarge,
      unselectedLabelColor: JoyveeColors.jvGreySecondary,
      labelColor: Colors.black,
      tabs: tabs,
    );
  }
}