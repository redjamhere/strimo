// описание экрана профиля +17867025797
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/profile_view/edit_profile_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_privacy_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:animated_loading_border/animated_loading_border.dart';

//blocs
import 'package:joyvee/src/bloc/bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.profileLoadingStatus.isSubmissionInProgress || state.profileLoadingStatus.isPure) {
          return const FullScreenProgressIndicator();
        } else if (state.profileLoadingStatus.isSubmissionSuccess) {
          return Scaffold(
            backgroundColor: JoyveeColors.jvLightGreyBackground,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 20),
              leading: const Icon(Icons.person_add_outlined),
              actions: [
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SettingsPrivacy())),
                    icon: const Icon(Icons.menu))
              ],
              title: Text(
                state.profile.username!,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 17 * MediaQuery.textScaleFactorOf(context)),
              ),
              centerTitle: true,
            ),
            body: LiquidPullToRefresh(
              onRefresh: () async {
                context.read<ProfileBloc>().add(ProfileRequestedEvent());
              },
              springAnimationDurationInMilliseconds: 500,
              showChildOpacityTransition: false,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 5,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    toolbarHeight: SizeConfig.blockSizeVertical! * 12,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedLoadingBorder(
                          trailingBorderColor: JoyveeColors.jvRed,
                          borderColor: JoyveeColors.jvRed,
                          cornerRadius: 360.0,
                          borderWidth: 3,
                          duration: const Duration(seconds: 2),
                          padding: const EdgeInsets.all(1),
                          child: JoyveeProfileAvatar(
                            isOnline: true,
                            avatar: state.profile.avatar!,
                          ),
                        ),
                        Column(
                          children: [
                            Text(state.profile.followers!.toString(),
                                style:
                                    const TextStyle(fontSize: 20, color: Colors.black)),
                            Text(
                              "Подписки",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              state.profile.subscribers!.toString(),
                              style: const TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "Подписчики",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              state.profile.rating!.toString(),
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            Text(
                              "рейтинг",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: 1,
                      (context, index) {
                        return Material(
                          elevation: 10,
                          color: Theme.of(context).colorScheme.background,
                          shadowColor: JoyveeColors.jvShadow,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          child: Container(
                              // height: SizeConfig.blockSizeVertical! * 25,
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical!,
                                  left: 20,
                                  right: 20),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16))),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: SizeConfig.screenWidth,
                                      child: Text(
                                        '${state.profile.firstname} ${state.profile.lastname}',
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                fontSize: 17 *
                                                    MediaQuery.textScaleFactorOf(
                                                        context),
                                                color: Colors.black),
                                      ),
                                    ),
                                    if (state.profile.about!.isNotEmpty) SizedBox(height: SizeConfig.blockSizeVertical!),
                                    AutoSizeText(
                                      state.profile.about!,
                                      minFontSize: 12,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(height: SizeConfig.blockSizeVertical!),
                                    if (state.profile.instagramUrl!.isNotEmpty &&
                                      state.profile.youtubeUrl!.isNotEmpty &&
                                      state.profile.tiktokUrl!.isNotEmpty)
                                      SizedBox(height: SizeConfig.blockSizeVertical!),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        if (state.profile.instagramUrl!.isNotEmpty) 
                                          InkWell(
                                            onTap: () async => await launchUrl(Uri.parse(state.profile.instagramUrl!)),
                                            child: SvgPicture.asset(
                                              "assets/svg/instagram_profile.svg",
                                              height:
                                                  SizeConfig.blockSizeVertical! * 5,
                                            ),
                                          ),
                                        if (state.profile.tiktokUrl!.isNotEmpty) InkWell(
                                          onTap: () async => await launchUrl(Uri.parse(state.profile.tiktokUrl!)),
                                          child: SvgPicture.asset(
                                              "assets/svg/tiktok_profile.svg",
                                              height:
                                                  SizeConfig.blockSizeVertical! *
                                                      5),
                                        ),
                                        if (state.profile.youtubeUrl!.isNotEmpty) InkWell(
                                          onTap: () async => await launchUrl(Uri.parse(state.profile.youtubeUrl!)),
                                          child: SvgPicture.asset(
                                              "assets/svg/youtube_profile.svg",
                                              height:
                                                  SizeConfig.blockSizeVertical! *
                                                      5),
                                        ),                                  
                                      ],
                                    ),
                                    SizedBox(height: SizeConfig.blockSizeVertical!),
                                    JoyveeOutlinedButton(
                                      func: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => BlocProvider.value(
                                            value: context.read<ProfileBloc>(),
                                            child: ProfileEditView(),
                                          )
                                        )
                                      ),
                                      style: Theme.of(context)
                                          .outlinedButtonTheme
                                          .style!
                                          .copyWith(
                                              padding: MaterialStateProperty.all<
                                                      EdgeInsetsGeometry>(
                                                  EdgeInsets.symmetric(
                                                      vertical: SizeConfig
                                                              .blockSizeVertical! *
                                                          1.5)),
                                              minimumSize:
                                                  MaterialStateProperty.all<Size>(
                                                      const Size.fromHeight(0))),
                                      child: const Text(
                                        "Редактировать",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ])),
                        );
                      },
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 4),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: 1,
                          (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 3),
                                  Text(
                                    "Последние трансляции".toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!,
                                    textScaleFactor:
                                        MediaQuery.textScaleFactorOf(context),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 3),
                                ],
                              )),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 4),
                    sliver: SliverMasonryGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: SizeConfig.blockSizeHorizontal! * 4,
                        mainAxisSpacing: SizeConfig.blockSizeHorizontal! * 4,
                        childCount: state.lastStreams.length,
                        itemBuilder: (context, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: InkWell(
                                onTap: () => print(state.lastStreams[index].filename!),
                                child: CachedNetworkImage(
                                  imageUrl: state.lastStreams[index].preview!,
                                  // imageUrl: "https://picsum.photos/200/300",
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset('assets/jpg/appicon-bw.jpg', height: 100,),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            )),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.blockSizeVertical! * 10),
                  )
                ],
              ),
            ),
          );
        } else {
          return Center(child: Text(state.errorMessage.toString()),);
        }
      },
    );
  }
}
