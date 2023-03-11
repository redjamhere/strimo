// описание экарана рекмоендаций и топов
import 'package:flutter/material.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecommendationView extends StatelessWidget {
  RecommendationView({Key? key}) : super(key: key);

  final List<TopStream> _topStreams = [
    TopStream(
        id: 1,
        cost: 200,
        title: "Shesh stream",
        preview: "https://i.ytimg.com/vi/dWnhkEFRzFQ/maxresdefault.jpg",
        isLive: true,
        key: "qwewqewqe2131e",
        owner: const StreamOwner(userId: 1, rating: 0.5, avatar: "https://www.kino-teatr.ru/art/6323/92894.jpg", firstname: "Aleikum", lastname: "Assalam"),
        isPrivate: true),
    TopStream(
        id: 2,
        cost: 0,
        title: "Coming soon",
        preview: "https://i.ytimg.com/vi/dWnhkEFRzFQ/maxresdefault.jpg",
        isLive: false,
        planningDate: DateTime.now(),
        key: "qwewqewqe2131e",
        owner: const StreamOwner(userId: 1, rating: 0.5, avatar: "https://www.kino-teatr.ru/art/6323/92894.jpg", firstname: "Aleikum", lastname: "Assalam"),
        isPrivate: false)
  ];

  final List<TopAuthor> _topAuthors = [
    const TopAuthor(
        userId: 1,
        rating: 2.4,
        avatar: "https://www.kino-teatr.ru/art/6323/92894.jpg",
        firstname: "Tomas",
        lastname: "Mos",
        followers: 258325),
    const TopAuthor(
        userId: 2,
        rating: 4.0,
        avatar: "https://www.kino-teatr.ru/art/6323/92894.jpg",
        firstname: "Ainur",
        lastname: "Mosaika",
        followers: 25832323),
    const TopAuthor(
        userId: 3,
        rating: 4.0,
        avatar: "https://www.kino-teatr.ru/art/6323/92894.jpg",
        firstname: "Sanechek",
        lastname: "Burdov",
        followers: 3000000),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("TOP STREAMS", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: JoyveeColors.jvGreySecondary,
                    fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
               JoyveeTextButton(
                 func: () => null,
                 style: Theme.of(context).textButtonTheme.style!.copyWith(
                   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                   minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0))
                 ),
                 child: const Text('MORE',
                     style: TextStyle(
                         color: JoyveeColors.jvLightBlueLink,
                         fontSize: 12)))
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical!),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical! * 20,
              child: ListView.separated(
                itemCount: _topStreams.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => TopStreamCard(
                    stream: _topStreams[index],
                    onTap: () => '') ,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("AUTHORS", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: JoyveeColors.jvGreySecondary,
                    fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
                JoyveeTextButton(
                    func: () => null,
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0))
                    ),
                    child: const Text('MORE',
                        style: TextStyle(
                            color: JoyveeColors.jvLightBlueLink,
                            fontSize: 12)))
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical!),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical! * 20,
              child: ListView.separated(
                itemCount: _topAuthors.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => TopAuthorCard(
                    author: _topAuthors[index],
                    onTap: () => print('sheddddsh')) ,
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical! * 2),
          const Center(
              child: RVideoPlayer()
          ),
        ],
      ),
    );
  }
}

class RVideoPlayer extends StatefulWidget {
  const RVideoPlayer({Key? key}) : super(key: key);

  @override
  State<RVideoPlayer> createState() => _RVideoPlayerState();
}

class _RVideoPlayerState extends State<RVideoPlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: 'M5MDMLFEkNo',
        flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: false,
      ),
    );
  }
}

