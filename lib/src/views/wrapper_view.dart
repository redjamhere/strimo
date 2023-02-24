import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/views.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import 'package:joyvee/src/bloc/bloc.dart';

//repositories
import 'package:joyvee/src/repository/respository.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  var _bottomNavIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(360))
        ),
        child: const Icon(JoyveeIcons.videocamera_filled),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => const NewStreamView())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: JoyveeNavigationBar(
        index: _bottomNavIndex,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          // _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.ease);
          setState(() => _bottomNavIndex = index);
        },
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeView(),
          FeedView(),
          MessengerView(),
          ProfileView()
          // AppWidgetList()
        ],
      ),
    );
  }
}
