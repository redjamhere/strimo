import 'package:joyvee/src/models/models.dart';

mixin MessagesMixin {
  static Map<DateTime, List<Message>> messagesToMap(List<Message> messages) {
    return Map.fromIterable((messages),
      key: (item) => (item as Message).date!.toUtc(),
      value:  (item) {
        List<Message> mss = [];
        for (Message m in messages) {
          if (m.date!.year == item.date.year && m.date!.day == item.date.day && m.date!.month == item.date.month) {
            mss.add(m);
          }
        }
        return mss;
      }
    );
  }
}