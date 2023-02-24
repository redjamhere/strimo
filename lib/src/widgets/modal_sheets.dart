// описание всплывающих окон
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import './widgets.dart';
import '../models/models.dart';

class StreamInfoModalSheet extends StatelessWidget {

  StreamInfoModalSheet(this.stream);

  final JStream stream;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(JoyveePaddings.kModalBottomSheetPadding),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: CachedNetworkImageProvider(stream.preview!),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //cost
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: JoyveeColors.jvGold,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Text("${stream.cost}\$",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.background)),
                    ),
                    const SizedBox(width: 6),
                    // stream type
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Text("${stream.streamType}",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 8,
                              color: Colors.black)),
                    ),
                    const SizedBox(width: 6),
                    // live or schedule
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(7)
                      ),
                      child: Text("Live 👀 542",
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 8,
                              color: Theme.of(context).colorScheme.background)),
                    ),
                    const Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () => '',
                          child: Icon(Icons.menu, color: Theme.of(context).colorScheme.background,)),
                    )
                  ],
                ),
                // stream title
                const SizedBox(height: 10),
                Text(stream.title!, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 14, color: Colors.white)),
                // user info
                const SizedBox(height: 10),
                Row(
                  children: [
                    const CircleAvatar(
                      foregroundImage: CachedNetworkImageProvider("https://i.pravatar.cc/300"),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Жаклин Тернер", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontSize: 12.0
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("★ 4,9", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: JoyveeColors.jvGold,
                                  fontSize: 12.0
                              )),
                              Text("Рагели, Англия", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.background,
                                  fontSize: 12.0
                              )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 30,
          padding: EdgeInsets.only(left: JoyveePaddings.kModalBottomSheetPadding),
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: JoyveeColors.jvGreyBackground,
                    borderRadius: BorderRadius.circular(6)),
                child: Text('TAG $index', style: Theme.of(context).textTheme.bodyLarge,),
              ),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8)
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              top: JoyveePaddings.kModalBottomSheetPadding,
              left: JoyveePaddings.kModalBottomSheetPadding,
              right: JoyveePaddings.kModalBottomSheetPadding
          ),
          child: Text("DESCRIPTION", style: Theme.of(context).textTheme.headlineSmall,),
        ),
        Container(
            padding: const EdgeInsets.only(
                bottom: JoyveePaddings.kModalBottomSheetPadding,
                left: JoyveePaddings.kModalBottomSheetPadding,
                right: JoyveePaddings.kModalBottomSheetPadding
            ),
            constraints: const BoxConstraints(
              maxHeight: 150,
              minWidth: double.infinity,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loremf iosjfiodjfjdsijfiojdsiofj jfijeif fhjeiufh ef iowejf fj eiwoj fiowjifj iofj ioewj fioweiofj ewiojf eiwoj ioewj ioewjio fiowj fioj iowj iofjewio fiowj fiowej fioewj iofewj iofewj iofewjiof jewiofj iowj fioewjf iowe fjewio jfiowj  iofjewio fjewioj fiowej fioewj io ',
                    style: Theme.of(context).textTheme.bodyLarge!,)
                ],
              ),
            )
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: JoyveePaddings.kModalBottomSheetPadding + 10,
              right: JoyveePaddings.kModalBottomSheetPadding + 10,
              bottom: JoyveePaddings.kModalBottomSheetPadding
          ),
          child: JoyveeElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0))
            ),
            func: () => "",
            child: const Text("Connect"),
          ),
        ),
      ],
    );
  }
}

class StreamFilterModalSheet extends StatefulWidget {
  final Function onAccept;
  final Function onReset;

  const StreamFilterModalSheet({Key? key, required this.onAccept, required this.onReset}) : super(key: key);

  @override
  State<StreamFilterModalSheet> createState() => _StreamFilterModalSheetState();
}

class _StreamFilterModalSheetState extends State<StreamFilterModalSheet> {
  StreamMemberType _streamMemberType = StreamMemberType.single;
  final PageController controller = PageController();
  final List<JCheckBox> singleFilter = [
    JCheckBox(
        label: 'Live',
        memberType: StreamMemberType.single),
    JCheckBox(
        label: 'Scheduled',
        memberType: StreamMemberType.single),
    JCheckBox(
        label: 'Paid',
        memberType: StreamMemberType.single),
    JCheckBox(
        label: 'Free',
        memberType: StreamMemberType.single),
  ];

  final List<JCheckBox> groupFilter = [
    JCheckBox(
        label: 'Live',
        memberType: StreamMemberType.group),
    JCheckBox(
        label: 'Scheduled',
        memberType: StreamMemberType.group),
    JCheckBox(
        label: 'Paid',
        memberType: StreamMemberType.group),
    JCheckBox(
        label: 'Free',
        memberType: StreamMemberType.group),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(JoyveePaddings.kModalBottomSheetPadding),
      child: Wrap(
        children: [
          //title
          Padding(
            padding: const EdgeInsets.only(bottom: JoyveePaddings.kModalBottomSheetPadding),
            child: Text('Filter', style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 22),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: JoyveePaddings.kModalBottomSheetPadding),
            child: Row(
              children: [
                Expanded(
                  child: JoyveeRadioButton<StreamMemberType>(
                    value: StreamMemberType.single,
                    groupValue: _streamMemberType,
                    leading: 'Single',
                    onChanged: (val) {
                      setState(() => _streamMemberType = val);
                      controller.jumpToPage(0);
                    },
                  )
                ),
                const SizedBox(width: 11),
                Expanded(
                    child: JoyveeRadioButton<StreamMemberType>(
                      value: StreamMemberType.group,
                      groupValue: _streamMemberType,
                      leading: 'Group',
                      onChanged: (val) {
                        setState(() => _streamMemberType = val);
                        controller.jumpToPage(1);
                      },
                    )
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: JoyveePaddings.kModalBottomSheetPadding),
            height: 200,
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (JCheckBox c in singleFilter)
                      GradientCheckBox(
                        onChanged: (val) { if (c.enabled) { setState(() => c.isChecked = val!); }},
                        value: c.isChecked,
                        label: c.label,
                      )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (JCheckBox c in groupFilter)
                      GradientCheckBox(
                        onChanged: (val) { if (c.enabled) { setState(() => c.isChecked = val!); }},
                        value: c.isChecked,
                        label: c.label,
                      )
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: JoyveeOutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0))
                  ),
                  func: () => print('Reset filter'),
                  child: Text("Reset",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17)),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: JoyveeElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0))
                  ),
                  func: () => print('filter accepted'),
                  child: const Text("Accept"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerLoadingModalSheet extends StatefulWidget {
  final bool isLoading;
  final Widget child;

  const ShimmerLoadingModalSheet({Key? key, required this.isLoading, required this.child}) : super(key: key);

  @override
  State<ShimmerLoadingModalSheet> createState() => _ShimmerLoadingModalSheetState();
}

class _ShimmerLoadingModalSheetState extends State<ShimmerLoadingModalSheet> with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<Color?> animationOne;
  late Animation<Color?> animationTwo;

  void animationListener() async {
    try {
      if (_animationController.status == AnimationStatus.completed) {
        await _animationController.reverse().orCancel;
      } else if (_animationController.status == AnimationStatus.dismissed) {
        await _animationController.forward().orCancel;
      }
      if (mounted) {
        setState(() {});
      }
    } on TickerCanceled {
      //
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this);
    animationOne = ColorTween(begin: JoyveeColors.jvGreyBackground, end: Colors.white).animate(_animationController);
    animationTwo = ColorTween(begin: Colors.white, end: JoyveeColors.jvGreyBackground).animate(_animationController);
    _animationController.forward();
    _animationController.addListener(animationListener);
  }

  @override
  void dispose() async {
    _animationController.removeListener(animationListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(colors: [animationOne.value!, animationTwo.value!]).createShader(bounds);
      },
      child: Wrap(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(JoyveePaddings.kModalBottomSheetPadding),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black
              ),
            ),
          ),
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: JoyveePaddings.kModalBottomSheetPadding,
                right: JoyveePaddings.kModalBottomSheetPadding,
                bottom: JoyveePaddings.kModalBottomSheetPadding
            ),
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) => Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvGreyBackground,
                      borderRadius: BorderRadius.circular(6)),
                  child: const SizedBox(width: 20,),
                ),
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 8)
            ),
          ),
          Container(
            height: 30,
            padding: const EdgeInsets.only(
                left: JoyveePaddings.kModalBottomSheetPadding,
                right: JoyveePaddings.kModalBottomSheetPadding,
                bottom: JoyveePaddings.kModalBottomSheetPadding
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          Container(
            height: 30,
            width: double.infinity,
            padding: const EdgeInsets.only(
                left: JoyveePaddings.kModalBottomSheetPadding,
                right: JoyveePaddings.kModalBottomSheetPadding,
                bottom: JoyveePaddings.kModalBottomSheetPadding
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: JoyveePaddings.kModalBottomSheetPadding + 10,
                right: JoyveePaddings.kModalBottomSheetPadding + 10,
                bottom: JoyveePaddings.kModalBottomSheetPadding
            ),
            child: JoyveeElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0))
              ),
              func: null,
              child: const Text("Connect"),
            ),
          ),
        ],
      ),
    );
  }
}
