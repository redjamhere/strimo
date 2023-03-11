// описание экрана настроек
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:joyvee/src/bloc/authorization_bloc/authorization_bloc.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingsPrivacy extends StatelessWidget {
  const SettingsPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black,
            size: 20
        ),
        centerTitle: true,
        title: Text('Settings and privacy',
          style: Theme.of(context).textTheme.headlineLarge!
              .copyWith(fontSize: 17 * MediaQuery.textScaleFactorOf(context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text("ACCOUNT", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: JoyveeColors.jvGreySecondary,
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
            ),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Privacy',
                leading: Icon(JoyveeIcons.profile_outlined, color: Theme.of(context).colorScheme.onSecondary,)),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Manage account',
                leading: Icon(JoyveeIcons.lock_open, color: Theme.of(context).colorScheme.onSecondary,)),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Vision map',
                leading: Icon(JoyveeIcons.vision_map, color: Theme.of(context).colorScheme.onSecondary,)),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text("GENERAL SETTINGS", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: JoyveeColors.jvGreySecondary,
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
            ),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Push notification',
                leading: Icon(JoyveeIcons.bell, color: Theme.of(context).colorScheme.onSecondary,)),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Dark mode',
                leading: Icon(JoyveeIcons.moon, color: Theme.of(context).colorScheme.onSecondary,)),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text("SUPPORT", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: JoyveeColors.jvGreySecondary,
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
            ),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Report a problem',
                leading: Icon(JoyveeIcons.pen, color: Theme.of(context).colorScheme.onSecondary,)),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text("ABOUT", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: JoyveeColors.jvGreySecondary,
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor)),
            ),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Terms of Service',
                leading: Icon(JoyveeIcons.grid, color: Theme.of(context).colorScheme.onSecondary,)),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Community Guidelines',
                leading: Icon(JoyveeIcons.pretzel, color: Theme.of(context).colorScheme.onSecondary,)),
            SettingsPrivacyTile(
                onTap: () => print('shesh'),
                title: 'Privacy policy',
                leading: Icon(JoyveeIcons.file, color: Theme.of(context).colorScheme.onSecondary,)),
            const ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Divider(thickness: 1,),
            ),
            ListTile(
              onTap: () => print("clear cache"),
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text('Clear cache',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge
              ),
              horizontalTitleGap: -SizeConfig.blockSizeHorizontal!,
              leading: Icon(JoyveeIcons.bin, color: Theme.of(context).colorScheme.onSecondary,),
              trailing: Text('150 Мб',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 14 * MediaQuery.textScaleFactorOf(context)
                ),
              ),
            ),
            // const Spacer(),
            ListTile(
              onTap: () => context.read<AuthorizationBloc>().add(AuthorizationLogoutRequested()),
              visualDensity: VisualDensity.compact,
              dense: true,
              horizontalTitleGap: -SizeConfig.blockSizeHorizontal!,
              title: Text("Log out",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: JoyveeColors.jvRed
                ),
              ),
              leading: const Icon(JoyveeIcons.exit, color: JoyveeColors.jvRed,),
            ),
            const ListTile(dense: true, visualDensity: VisualDensity.compact,)
          ],
        ),
      ),
    );
  }
}
