// Описание экрана с картами и трансляциями
import 'package:flutter/material.dart';
import 'package:joyvee/src/cubit/global_search_cubit/global_search_cubit.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/home_view/live_map.dart';
import 'package:joyvee/src/views/home_view/scheduled_list.dart';
import 'package:joyvee/src/views/home_view/search_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//blocs
import 'package:joyvee/src/bloc/bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showSuffixIcon = false;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
                child: Row(
                  children: [
                    Expanded(
                      child: JoyveeSearchTextField(
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black),
                        hintText: "People, streams, places",
                        showSuffix: showSuffixIcon,
                        readOnly: true,
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) =>
                                              GlobalSearchCubit(
                                                  userRepository: context
                                                      .read<UserRepository>(),
                                                  searchRepository:
                                                      context.read<
                                                          SearchRepository>()),
                                        ),
                                        BlocProvider(
                                          create: (context) => ProfileBloc(
                                            userRepository: context.read<UserRepository>(), 
                                            profileRepository: context.read<ProfileRepository>())),
                                      ],
                                      child: const SearchView(),
                                    ))),
                        prefixIcon: const Icon(Icons.search,
                            color: JoyveeColors.jvGreyHintText),
                      ),
                    ),
                    const SizedBox(width: 10),
                    JoyveeAppbarActionButton(
                        icon: const Icon(Icons.filter_vintage_rounded),
                        onTap: () => showModalBottomSheet(
                            context: context,
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            isScrollControlled: true,
                            builder: (BuildContext context) =>
                                StreamFilterModalSheet(
                                  onAccept: () => print("filter accepted"),
                                  onReset: () => print("filter reset"),
                                ))
                          ..whenComplete(() =>
                              FocusManager.instance.primaryFocus?.unfocus()))
                  ],
                ),
              ),
            ),
          )),
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
                    text: 'Broadcasts',
                  ),
                  Tab(
                    text: 'Requests',
                  ),
                  Tab(text: 'My planned broadcast')
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                          color: JoyveeColors.jvGreySecondary,
                          spreadRadius: 1,
                          blurRadius: 20)
                    ]),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    const LiveMap(),
                    const LiveMap(),
                    UserScheduledBroadcastList()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
