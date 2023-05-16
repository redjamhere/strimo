//Описание экрана с мессенджером
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/messenger_view/chats_list.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class MessengerView extends StatefulWidget {
  const MessengerView({Key? key}) : super(key: key);
  @override
  State<MessengerView> createState() => _MessengerViewState();
}

class _MessengerViewState extends State<MessengerView> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool showSuffixIcon = false;

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical! * 9),
        child: SafeArea(
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: JoyveeSearchTextField(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
                        controller: _searchController,
                        hintText: "Search",
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
                  const SizedBox(width: 10),
                  JoyveeAppbarActionButton(
                      withShadow: false,
                      icon: const Icon(Icons.create),
                      onTap: () => ''),
                  const SizedBox(width: 10),
                  JoyveeAppbarActionButton(
                      withShadow: false,
                      icon: const Icon(Icons.menu),
                      onTap: () => ''),
                ],
              ),
            ),
          )
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
                tabs: const [
                  Tab(
                    text: 'Messages',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ChatList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
