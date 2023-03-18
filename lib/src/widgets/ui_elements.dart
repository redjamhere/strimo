// Описание разных виджетов используемых в приложении
import 'dart:ui';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;

// Описание вывески я онлайн
class ImOnline extends StatelessWidget {
  const ImOnline({Key? key, required this.onClose}) : super(key: key);

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.blockSizeVertical! * 12.5,
      width: SizeConfig.screenWidth,
      decoration: const BoxDecoration(
          boxShadow: [BoxShadow(color: JoyveeColors.jvGreySecondary, spreadRadius: 0.5, blurRadius: 20)]
      ),
      child: Stack(
        children: [
          Container(
            width: SizeConfig.blockSizeHorizontal! * 100,
            height: SizeConfig.blockSizeVertical! * 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
                horizontal: JoyveePaddings.kModalBottomSheetPadding),
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText("I'm online!",
                          maxLines: 1,
                          minFontSize: 12,
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(fontSize: 14 * MediaQuery.textScaleFactorOf(context))),
                      AutoSizeText(
                          "If your online other people can request you broadcast",
                          maxLines: 2,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: MediaQuery.textScaleFactorOf(context),
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(fontSize: 14 * MediaQuery.textScaleFactorOf(context))
                      )
                      // Text("If your online other people can request you broadcast",
                      //     softWrap: true,
                      //     style: Theme.of(context).textTheme.bodySmall!
                      //         .copyWith(fontSize: 14 * MediaQuery.textScaleFactorOf(context))),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: Switch(
                      value: true,
                      onChanged: (val) => print(val)),
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: Material(
                color: JoyveeColors.jvGreyBackground.withOpacity(.7),
                borderRadius: BorderRadius.circular(360),
                child: InkWell(
                  borderRadius: BorderRadius.circular(360),
                  onTap: onClose,
                  child: Icon(Icons.close, color: Theme.of(context).colorScheme.background,),
                ),
              )),
        ],
      ),
    );
  }
}

class TopStreamCard extends StatelessWidget {
  const TopStreamCard({
    Key? key,
    required this.onTap,
    required this.stream
  });
  final GestureTapCallback onTap;
  final TopStream stream;

  List<Widget> _buildIcons(BuildContext context) {
    List<Widget> icons = [];
    if (stream.cost! > 0) {
      icons.add(Container(
        height: SizeConfig.blockSizeVertical! * 4,
        width: SizeConfig.blockSizeVertical! * 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: JoyveeColors.jvGold,
        ),
        child: Text('${stream.cost!.toInt()}\$',
          style: Theme.of(context).textTheme.titleLarge!
              .copyWith(fontSize: 8 * SizeConfig.blockSizeVertical! * 0.15, color: Colors.white),),
      ));
    } else {
      icons.add(Container(
        height: SizeConfig.blockSizeVertical! * 4,
        width: SizeConfig.blockSizeVertical! * 4,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: JoyveeColors.jvGreen,
        ),
        child: Text('Free',
          style: Theme.of(context).textTheme.titleLarge!
              .copyWith(fontSize: 8 * SizeConfig.blockSizeVertical! * 0.15, color: Colors.white),),
      ));
    }
    
    icons.add(const SizedBox(width: 8,));
    
    if (stream.isPrivate) {
      icons.add(
        Container(
          height: SizeConfig.blockSizeVertical! * 4,
          width: SizeConfig.blockSizeVertical! * 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Icon(JoyveeIcons.profile_filled, color: Colors.black, size: SizeConfig.blockSizeVertical! * 2,),
        )
      );
    } else {
      icons.add(
          Container(
            height: SizeConfig.blockSizeVertical! * 4,
            width: SizeConfig.blockSizeVertical! * 4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            child: Icon(JoyveeIcons.group_filled, color: Colors.black, size: SizeConfig.blockSizeVertical! * 2,),
          )
      );
    }

    icons.add(const SizedBox(width: 8,));

    if (stream.isLive!) {
      icons.add(
          Container(
            height: SizeConfig.blockSizeVertical! * 4,
            width: SizeConfig.blockSizeVertical! * 4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: JoyveeColors.jvRed,
            ),
            child: Icon(Icons.play_circle, color: Colors.white, size: SizeConfig.blockSizeVertical! * 3,),
          )
      );
    } else {
      icons.add(
          Container(
            height: SizeConfig.blockSizeVertical! * 4,
            width: SizeConfig.blockSizeVertical! * 4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: JoyveeColors.jvLightBlueMarker,
            ),
            child: Icon(JoyveeIcons.schedule_filled, color: Colors.white, size: SizeConfig.blockSizeVertical! * 2,),
          )
      );
    }

    return icons;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: CachedNetworkImageProvider(stream.preview!),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        )
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(stream.title!,
                  minFontSize: 12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!
                      .copyWith(color: Colors.white, fontSize: 14 * SizeConfig.blockSizeVertical! * 0.1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildIcons(context),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: SizeConfig.blockSizeVertical! * 3,
                      foregroundImage: CachedNetworkImageProvider(stream.owner!.avatar!),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${stream.owner!.firstname!} ${stream.owner!.lastname!}', style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 12.0
                          )),
                          Text("★ 4,9", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: JoyveeColors.jvGold,
                              fontSize: 12.0
                          )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopAuthorCard extends StatelessWidget {
  const TopAuthorCard({Key? key, required this.author, required this.onTap}) : super(key: key);
  final TopAuthor author;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal! * 35,
      child: Material(
        color: JoyveeColors.jvGreyBackground,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical!),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: SizeConfig.blockSizeVertical! * 12,
                  width: SizeConfig.blockSizeVertical! * 12,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.white, width: 1.5)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: CachedNetworkImage(imageUrl: author.avatar!,
                              fit: BoxFit.cover)
                      ),
                      // Container(
                      //   padding: const EdgeInsets.only(top: 20),
                      //   height: SizeConfig.blockSizeVertical! * 12,
                      //   width: SizeConfig.screenWidth,
                      //   color: ,
                      // ),
                      Container(
                          height: SizeConfig.screenHeight,
                          width: SizeConfig.screenWidth,
                          padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical! * 9),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360)
                          ),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 10, sigmaY: 10),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            ),
                          )
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.01,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Wrap(
                            children: [
                                const Icon(Icons.star,
                                    color: JoyveeColors.jvGold, size: 10),
                                Text(
                                    JoyveeFunctions.getNumber(author.rating!, precision: 1)
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w500,
                                        color: JoyveeColors.jvGold,
                                        letterSpacing: 0.09))
                              ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: AutoSizeText(
                      JoyveeFunctions.ellipsisString(JoyveeFunctions.decodeUtf8('${author.firstname!} ${author.lastname!}')),
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                Text(
                    '${JoyveeFunctions.shortenNumber(author.followers!)} followers',
                    style: TextStyle(
                        color: Colors.black.withOpacity(.54),
                        fontSize: 10,
                        letterSpacing: 0.09,
                        fontWeight: FontWeight.w500))
              ],
            ),
          )
        ),
      ),
    );
  }
}

class JoyveeProfileAvatar extends StatelessWidget {
  const JoyveeProfileAvatar({Key? key, 
  required this.avatar, 
  this.isOnline = false,
  this.isStreaming = false}) : super(key: key);
  final String avatar;
  final bool isOnline;
  final bool isStreaming;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: [
        CircleAvatar(
          radius: SizeConfig.blockSizeHorizontal! * 9,
          foregroundImage: CachedNetworkImageProvider(avatar),
          backgroundColor: Colors.transparent,
          backgroundImage: const AssetImage("assets/jpg/appicon-bw.jpg"),
          // child: Image.asset("assets/jpg/appicon-bw.jpg"),
        ),
        Visibility(
          visible: isOnline,
          child: Positioned(
            right: 3,
            bottom: 3,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  color: (isStreaming) ? JoyveeColors.jvRed : JoyveeColors.jvGreen,
                  border: Border.all(
                      width: 2,
                      color: Colors.white
                  ),
                  borderRadius: BorderRadius.circular(360)
              )),
          ),
        )
      ],
    );
  }
}

class SettingsPrivacyTile extends StatelessWidget {
  const SettingsPrivacyTile({
    Key? key,
    required this.onTap,
    required this.title,
    required this.leading
  }) : super(key: key);

  final GestureTapCallback onTap;
  final Icon leading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      dense: true,
      onTap: onTap,
      visualDensity: VisualDensity.compact ,
      leading: leading,
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: Theme.of(context).colorScheme.onSecondary,),
      horizontalTitleGap:-SizeConfig.blockSizeHorizontal!,
      title: Text(title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

class ProfileEditRow extends StatelessWidget {
  const ProfileEditRow({
    Key? key,
    required this.title,
    required this.onTap,
    required this.currentData,
  }) : super(key: key);
  final GestureTapCallback onTap;
  final String title;
  final Widget currentData;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 5,
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 16)),
              const Spacer(),
              currentData,
              SizedBox(width: SizeConfig.blockSizeHorizontal! * 3,),
              const Icon(Icons.arrow_forward_ios_rounded, color: JoyveeColors.jvGreyBorder,)
            ],
          ),
        ),
      ),
    );
  }
}

class JoyveeEmojiPicker extends StatelessWidget {
  const JoyveeEmojiPicker({
    Key? key,
    required this.controller
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return EmojiPicker(
      onEmojiSelected: (Category? category, Emoji emoji) {
       print(emoji);
      },
      onBackspacePressed: () {
          // Do something when the user taps the backspace button (optional)
      },
      textEditingController: controller, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
      config: Config(
          columns: 7,
          emojiSizeMax: 32 * (foundation.defaultTargetPlatform == TargetPlatform.iOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
          verticalSpacing: 0,
          horizontalSpacing: 0,
          gridPadding: EdgeInsets.zero,
          initCategory: Category.RECENT,
          bgColor: Color(0xFFF2F2F2),
          indicatorColor: Colors.blue,
          iconColor: Colors.grey,
          iconColorSelected: Colors.blue,
          backspaceColor: Colors.blue,
          skinToneDialogBgColor: Colors.white,
          skinToneIndicatorColor: Colors.grey,
          enableSkinTones: true,
          showRecentsTab: true,
          recentsLimit: 28,
          noRecents: const Text(
            'No Recents',
            style: TextStyle(fontSize: 20, color: Colors.black26),
            textAlign: TextAlign.center,
          ), // Needs to be const Widget
          loadingIndicator: const SizedBox.shrink(), // Needs to be const Widget
          tabIndicatorAnimDuration: kTabScrollDuration,    
          categoryIcons: const CategoryIcons(),
          buttonMode: ButtonMode.MATERIAL,
      ),
    );
  }
}