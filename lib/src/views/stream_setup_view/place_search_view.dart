import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/repository/map_repository.dart';
import 'package:joyvee/src/repository/respository.dart';

//cubits
import '../../cubit/cubit.dart';

//widgets
import '../../widgets/widgets.dart';

//utils
import '../../utils/utils.dart';

class PlaceSearchView extends StatefulWidget {
  const PlaceSearchView({Key? key}) : super(key: key);

  @override
  State<PlaceSearchView> createState() => _PlaceSearchViewState();
}

class _PlaceSearchViewState extends State<PlaceSearchView> {
  late bool showSuffixIcon;

  final TextEditingController _searchController = TextEditingController();
  late String sysLang;

  @override
  void initState() {
    showSuffixIcon = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPlaceCubit(
        userRepository: context.read<UserRepository>(),
        mapRepository: context.read<MapRepository>()
      ),
      child: BlocBuilder<SearchPlaceCubit, SearchPlaceState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Material(
                  child: JoyveeSearchTextField(
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: Colors.black),
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
                      prefixIcon: const Icon(Icons.search,
                          color: JoyveeColors.jvGreyHintText),
                      onChanged: (String s) {
                        if (_searchController.text.isNotEmpty) {
                          context.read<SearchPlaceCubit>().onSearchChanged(s);
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
                      }),
                ),
              ),
              body: (state.searchResults.length == 0) 
              ? Center(child: Image.network("https://i.pinimg.com/originals/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.png"),)
              : ListView.builder(
                itemCount: state.searchResults.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(state.searchResults[index].name!),
                  onTap: () => Navigator.pop(
                      context,
                      LatLng(
                        state.searchResults[index].geometry!.location!.lat!,
                        state.searchResults[index].geometry!.location!.lng!,
                      )),
                ),
              ));
        },
      ),
    );
  }
}
