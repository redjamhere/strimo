// описание моделей фильтрации

import 'package:joyvee/src/utils/utils.dart';

class FilterModel {
  final SingleStreamModel? s;
  final GroupStreamModel? g;

  const FilterModel({
    this.s = const SingleStreamModel(isFree: true, isOnline: true, isPaid: false, isPlanned: true), 
    this.g = const GroupStreamModel(isFree: true, isOnline: true, isPaid: false, isPlanned: false)});

  factory FilterModel.fromJson(Map<String, dynamic> data) => FilterModel(
      s: SingleStreamModel.fromJson(data['data']['Single']),
      g: GroupStreamModel.fromJson(data['data']['Group']));

  factory FilterModel.defaultFilter() => const FilterModel(
      s: SingleStreamModel(isOnline: null, isFree: null),
      g: GroupStreamModel(isOnline: null, isFree: null));

  Map<String, dynamic> toJson() => {
    "Single": {
      "is_online":
      (s!.isOnline! && s!.isPlanned! || !s!.isOnline! && !s!.isPlanned!)
          ? null
          : s!.isOnline,
      "is_free": (s!.isFree! && s!.isPaid! || !s!.isFree! && !s!.isPaid!)
          ? null
          : s!.isFree,
    },
    "Group": {
      "is_online":
      (g!.isOnline! && g!.isPlanned! || !g!.isOnline! && !g!.isPlanned!)
          ? null
          : g!.isOnline,
      "is_free": (g!.isFree! && g!.isPaid! || !g!.isFree! && !g!.isPaid!)
          ? null
          : g!.isFree,
    }
  };

  @override
  String toString() => 'Single: [isPlanned: ${s!.isPlanned}, isFree: ${s!.isFree}, isOnline: ${s!.isOnline}, isPaid: ${s!.isPaid}]\nGroup: [isPlanned: ${g!.isPlanned}, isFree: ${g!.isFree}, isOnline: ${g!.isOnline}, isPaid: ${g!.isPaid}]';
}

class SingleStreamModel {
  final bool? isOnline;
  final bool? isPlanned;
  final bool? isPaid;
  final bool? isFree;

  const SingleStreamModel(
      {this.isOnline, this.isFree, this.isPaid, this.isPlanned});

  factory SingleStreamModel.fromJson(Map<String, dynamic> data) =>
      SingleStreamModel(
          isOnline: data["is_online"], isFree: data["is_free"]);

  Map<String, dynamic> toJson() =>
      {"is_online": isOnline, "is_free": isFree};

  bool hasTrueParam() =>
      (isOnline! || isPlanned! || isPaid! || isFree!)
          ? true
          : false;
}

class GroupStreamModel extends SingleStreamModel{
  const GroupStreamModel({isOnline, isFree, isPaid, isPlanned})
      : super(
      isOnline: isOnline,
      isFree: isFree,
      isPaid: isPaid,
      isPlanned: isPlanned);

  factory GroupStreamModel.fromJson(Map<String, dynamic> data) =>
      GroupStreamModel(isOnline: data["is_online"], isFree: data["is_free"]);

  @override
  Map<String, dynamic> toJson() =>
      {"is_online": isOnline, "is_free": isFree};

  @override
  bool hasTrueParam() =>
      (isOnline! || isPlanned! || isPaid! || isFree!)
          ? true
          : false;
}

class JCheckBox {
  final String label;
  final StreamMemberType memberType;
  bool isChecked;
  bool enabled;

  JCheckBox({required this.label, required this.memberType, this.isChecked = false, this.enabled = true});
}