import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/models/profile_models/profile.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/profile_view/profile_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/cubit/cubit.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:very_good_infinite_list/very_good_infinite_list.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (prevois, current) => ModalRoute.of(context)!.isCurrent,
      listener: (context, state) {
        if (state.profileLoadingStatus.isSubmissionInProgress) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BlocProvider.value(
                      value: context.read<ProfileBloc>(),
                      child: const ProfileView(),
                    )));
        }
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(SizeConfig.blockSizeVertical! * 9),
              child: SafeArea(
                child: AppBar(
                  automaticallyImplyLeading: false,
                  flexibleSpace: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: const _SearchFieldView()),
                ),
              )),
          body: const _TabBarView()),
    );
  }
}

class _SearchFieldView extends StatelessWidget {
  const _SearchFieldView();

  @override
  Widget build(BuildContext conetxt) {
    return BlocBuilder<GlobalSearchCubit, GlobalSearchState>(
        buildWhen: (previous, current) =>
            previous.usersSearchStatus != current.usersSearchStatus,
        builder: (context, state) => JoyveeSearchTextField(
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black),
            controller: context.read<GlobalSearchCubit>().searchFieldController,
            hintText: "People, streams, places",
            showSuffix: state.showSuffix,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.black),
              onPressed: () =>
                  context.read<GlobalSearchCubit>().onSearchFieldClear(),
            ),
            prefixIcon:
                const Icon(Icons.search, color: JoyveeColors.jvGreyHintText),
            onChanged: (String s) =>
                context.read<GlobalSearchCubit>().onSearchFieldChanged()));
  }
}

class _TabBarView extends StatefulWidget {
  const _TabBarView();

  @override
  State<_TabBarView> createState() => _TabBarViewState();
}

class _TabBarViewState extends State<_TabBarView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).colorScheme.primary,
            onTap: context.read<GlobalSearchCubit>().onTabChanged,
            tabs: const [
              Tab(
                key: ValueKey("People"),
                text: "People",
              ),
              Tab(key: ValueKey("Streams"), text: "Streams"),
              Tab(
                key: ValueKey("Places"),
                text: "Places",
              )
            ]),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: const [_UserListView(), Placeholder(), Placeholder()],
        ))
      ],
    );
  }
}

class _UserListView extends StatelessWidget {
  const _UserListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalSearchCubit, GlobalSearchState>(
        buildWhen: (previous, current) =>
            previous.nextFetchStatus != current.nextFetchStatus ||
            previous.usersSearchStatus != current.usersSearchStatus,
        builder: (context, state) {
          if (state.usersSearchStatus.isSubmissionInProgress) {
            return const FullScreenProgressIndicator();
          } else if (state.users.profiles.isEmpty) {
            return Center(
              child: Icon(
                Icons.search,
                size: SizeConfig.blockSizeVertical! * 10,
                color: Colors.grey.shade300,
              ),
            );
          } else {
            return InfiniteList(
                key: PageStorageKey(state.searchCategory),
                hasReachedMax: state.users.count == state.users.profiles.length,
                itemCount: state.users.profiles.length,
                onFetchData: () =>
                    context.read<GlobalSearchCubit>().onFetchData(),
                isLoading: state.nextFetchStatus.isSubmissionInProgress,
                loadingBuilder: (context) => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                itemBuilder: (context, index) {
                  JProfile p = state.users.profiles[index];
                  return ListTile(
                    key: ValueKey(index),
                    onTap: () {
                      if (state.searchCategory == SearchCategory.user) {
                        context
                            .read<ProfileBloc>()
                            .add(const ProfileRequestedEvent(isMy: false));
                      }
                    },
                    title: Text(
                      JoyveeFunctions.ellipsisString(JoyveeFunctions.decodeUtf8(
                          '${p.firstname} ${p.lastname}')),
                    ),
                    subtitle: Text(state.users.profiles[index].username!),
                    trailing: Text(
                        'Followers: ${state.users.profiles[index].followers}'),
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('assets/jpg/appicon-bw.jpg'),
                      // foregroundImage: NetworkImage(state.users.profiles[index].avatar!),
                      foregroundImage:
                          NetworkImage('https://i.pravatar.cc/300'),
                    ),
                  );
                });
          }
        });
  }
}
