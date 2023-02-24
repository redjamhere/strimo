import 'package:flutter/material.dart';
import 'package:joyvee/src/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/repository/map_repository.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './utils/utils.dart';
import './views/views.dart';

class JoyveeApp extends StatelessWidget {
  const JoyveeApp(
      {super.key,
      required this.authorizationRepository,
      required this.userRepository,
      required this.profileRepository,
      required this.streamRepository,
      required this.mapRepository,
      required this.streamChatRepository,
      required this.iosStreamRepository});

  final AuthorizationRepository authorizationRepository;
  final UserRepository userRepository;
  final ProfileRepository profileRepository;
  final StreamRepository streamRepository;
  final MapRepository mapRepository;
  final StreamChatRepository streamChatRepository;
  final IosStreamRepository iosStreamRepository;
  
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authorizationRepository),
          RepositoryProvider.value(value: userRepository),
          RepositoryProvider.value(value: profileRepository),
          RepositoryProvider.value(value: mapRepository),
          RepositoryProvider.value(value: streamRepository),
          RepositoryProvider.value(value: streamChatRepository),
          RepositoryProvider.value(value: iosStreamRepository)
        ],
        child: BlocProvider(
          create: (ctx) => AuthorizationBloc(
              authorizationRepository: authorizationRepository,
              userRepository: userRepository),
          child: const JoyveeAppView(),
        ));
  }
}

class JoyveeAppView extends StatefulWidget {
  const JoyveeAppView({Key? key}) : super(key: key);

  @override
  State<JoyveeAppView> createState() => _JoyveeAppViewState();
}

class _JoyveeAppViewState extends State<JoyveeAppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Joyvee App',
      darkTheme: AppThemes.darkTheme(context),
      theme: AppThemes.baseTheme(context),
      navigatorKey: _navigatorKey,
      themeMode: ThemeMode.light,
      builder: (context, child) =>
          BlocListener<AuthorizationBloc, AuthorizationState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          switch (state.status) {
            case AuthorizationStatus.authenticated:
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider(
                                create: (_) => ProfileBloc(
                                  userRepository: context.read<UserRepository>(),
                                  profileRepository: context.read<ProfileRepository>()
                                )..add(ProfileRequestedEvent()),
                              ),
                              BlocProvider(
                                lazy: false,
                                create: (_) => LivemapBloc(
                                  userRepository: RepositoryProvider.of<UserRepository>(context),
                                  mapRepository: RepositoryProvider.of<MapRepository>(context)
                                )..add(LivemapFetchMarkersRequested())),
                            ],
                            child: Wrapper(),
                          )),
                  (route) => false);
              break;
            case AuthorizationStatus.unauthenticated:
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => const WelcomeView()),
                  (route) => false);
              break;
            case AuthorizationStatus.error:
              _navigator.pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (ctx) =>
                          ErrorView(errorText: state.errorMessage!)),
                  (route) => false);
              break;
            case AuthorizationStatus.unknow:
              break;
          }
        },
        child: child,
      ),
      onGenerateRoute: (_) => MaterialPageRoute(
          builder: (ctx) => const FullScreenProgressIndicator()),
    );
  }
}
