// описание  экрана рекомендаций
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/feed_view/recommendation_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class FeedView extends StatefulWidget {
  const FeedView({Key? key}) : super(key: key);

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  bool showSuffixIcon = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical! * 9),
        child: SafeArea(
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: JoyveeSearchTextField(
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                  controller: _searchController,
                  hintText: "Enter address",
                  showSuffix: showSuffixIcon,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => showSuffixIcon = false);
                    },
                  ),
                  prefixIcon: const Icon(Icons.search, color: JoyveeColors.jvGreyHintText),
                  onChanged: (String s) {
                    if (_searchController.text.isNotEmpty) {
                      if (!showSuffixIcon) {
                        setState(() {
                          showSuffixIcon = true;
                        });
                      }
                    } else {
                      setState(() {
                        showSuffixIcon = false;
                      });
                    }
                  }
              ),
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical! * 9,
              child: JoyveeMainTabBar(
                controller: _tabController,
                tabs: const[
                  Tab(
                    text: "Recommendation",
                  ),
                  Tab(
                    text: "Follows",
                  )
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  RecommendationView(),
                  Center()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
