// Описание всех виджетов приложения Joyvee

import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:joyvee/src/utils/utils.dart';

//widgets
import './widgets.dart';

enum Sex { male, female, other }
enum StreamType { single, group }

class AppWidgetList extends StatefulWidget {
  const AppWidgetList({Key? key}) : super(key: key);

  @override
  State<AppWidgetList> createState() => _AppWidgetListState();
}

class _AppWidgetListState extends State<AppWidgetList> {
  final TextEditingController _streamTitleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _messengerController = TextEditingController();

  final TextEditingController _streamChatController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _searchController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  XFile? image;

  bool showSuffixIcon = false;
  bool _shimmerloading = false;


  Sex _sex = Sex.male;
  StreamType _streamType = StreamType.single;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Texts', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),),
              const Divider(),
              Text('Headline large', style: Theme.of(context).textTheme.headlineLarge),
              Text('Headline medium', style: Theme.of(context).textTheme.headlineMedium),
              Text('Headline small', style: Theme.of(context).textTheme.headlineSmall),
              Text('Body large', style: Theme.of(context).textTheme.bodyLarge),
              Text('Body small', style: Theme.of(context).textTheme.bodySmall),
              Text('Title large', style: Theme.of(context).textTheme.titleLarge),
              const Divider(),
              Text('Buttons', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),),
              const Divider(),
             JoyveeElevatedButton(
                 style: Theme.of(context).elevatedButtonTheme.style!,
                 func: () => print('esss'),
                 child: const Text('Elevated button')),
              const SizedBox(height: 10),
              JoyveeElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder())
                  ),
                  func: () => print('rounded'),
                  child: const Icon(Icons.arrow_back)),
              const SizedBox(height: 10),
              JoyveeOutlinedButton(
                onTap: () => print("shesh outlined gradient"),
                gradient: JoyveeGradients.kDarkBlueGradient,
                child: SizedBox(
                  width: double.infinity,
                  child: JoyveeTexts.gradientText(
                      "Outlined gradient button",
                      gradient: JoyveeGradients.kDarkBlueGradient,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17)
                  )),
              ),
              const SizedBox(height: 10),
              JoyveeOutlinedButton(
                  func: () => print('sheshn'),
                  style: Theme.of(context).outlinedButtonTheme.style,
                  child: Text('Outlined button',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17, color: JoyveeColors.jvGreyIcon))),
              const SizedBox(height: 10),
              JoyveeTextButton(
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                      textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 12))),
                  func: () => print('text button'),
                  child: const Text("Text button")),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  JoyveeSocialButton(child: JoyveeIcons.google, onTap: () => print('google')),
                  JoyveeSocialButton(child: JoyveeIcons.facebook, onTap: () => print('facebook')),
                  JoyveeSocialButton(child: JoyveeIcons.instagram, onTap: () => print('instagram')),
                  JoyveeSocialButton(child: JoyveeIcons.apple, onTap: () => print('apple')),
                ],
              ),
              const SizedBox(height: 10),
              JoyveeAvatarPicker(
                  onTap: () async {
                      XFile? _pic = await _picker.pickImage(source: ImageSource.gallery);
                      if (_pic != null) {
                        setState(() {image = _pic;});
                      }
                  },
                  avatar: (image != null) ? FileImage(File(image!.path)) : null,
                  child: SvgPicture.asset("assets/svg/empty_avatar.svg"),
              ),
              const Divider(),
              Text('Text fields', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),),
              const Divider(),
              JoyveeDefaultTextField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                  controller: _streamTitleController,
                  hintText: "Stream title new!",
                  autofocus: true,
                  showSuffix: showSuffixIcon,
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () {
                      _streamTitleController.clear();
                      setState(() { showSuffixIcon = false; });
                    }
                  ),
                  onChanged: (String s) {
                    if (_streamTitleController.text.isNotEmpty) {
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
                  },
              ),
              const SizedBox(height: 10),
              JoyveeDefaultTextField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
                  controller: _descriptionController,
                  hintText: 'Стрим Карабшского озера и шашлыков \n\n\n\n\n#природа #шашлыки #друзья',
                  maxLines: 7,
              ),
              const SizedBox(height: 10),
              JoyveeDefaultTextField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  controller: _messengerController,
                  hintText: 'Aa',
                  borderRadius: 30,
                  showSuffix: true,
                  suffixIcon: IconButton(
                    onPressed: () => null,
                    icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.black, size: 30,),
                  ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        const SizedBox(width: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Text('525', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white)),
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: JoyveeStreamTextField(
                              hintText: 'Message...',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white),
                                onPressed: () => null,
                              ),
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
                              controller: _streamChatController),
                        ),
                        const SizedBox(width: 22),
                        JoyveeLikeButton(
                           onTap: () => print('like'),
                           icon: const Icon(Icons.favorite, color: Colors.white))
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              JoyveeAuthTextField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  hintText: 'Email',
              ),
              const SizedBox(height: 10,),
              JoyveeAuthTextField(
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17, fontWeight: FontWeight.w400),
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true
              ),
              const SizedBox(height: 10),
              JoyveeSearchTextField(
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
              const Divider(),
              Text('Radio buttons', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: JoyveeRadioButton<Sex>(
                        value: Sex.female,
                        groupValue: _sex,
                        leading: '👩 Female',
                        onChanged: (val) => setState(() => _sex = val)),
                  ),
                  Expanded(
                    child: JoyveeRadioButton<Sex>(
                        value: Sex.male,
                        groupValue: _sex,
                        leading: '🧑 Male',
                        onChanged: (val) => setState(() => _sex = val)),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: JoyveeRadioButton<StreamType>(
                        value: StreamType.single,
                        groupValue: _streamType,
                        leading: 'Single',
                        onChanged: (val) => setState(() => _streamType = val)),
                  ),
                  Expanded(
                    child: JoyveeRadioButton<StreamType>(
                        value: StreamType.group,
                        groupValue: _streamType,
                        leading: 'Group',
                        onChanged: (val) => setState(() => _streamType = val)),
                  )
                ],
              ),
              const Divider(),
              Text('Modal sheets', style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 30),),
              const Divider(),
              // JoyveeElevatedButton(
              //     func: () => showModalBottomSheet(
              //         context: context,
              //         backgroundColor: Theme.of(context).colorScheme.background,
              //         shape: const RoundedRectangleBorder(
              //           borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              //         ),
              //         isScrollControlled: true,
              //         builder: (BuildContext context) => ShimmerLoadingModalSheet(
              //             isLoading: _shimmerloading,
              //             child: StreamInfoModalSheet())),
              //     style: Theme.of(context).elevatedButtonTheme.style!,
              //     child: const Text("Stream info modal"),
              // ),
              const SizedBox(height: 10),
              JoyveeElevatedButton(
                func: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    isScrollControlled: true,
                    builder: (BuildContext context) => StreamFilterModalSheet(
                      onAccept: () => print("filter accepted"),
                      onReset: () => print("filter reset"),
                    )),
                style: Theme.of(context).elevatedButtonTheme.style!,
                child: const Text("Stream filter modal"),
              )
            ],
          ),
        ),
    );
  }
}