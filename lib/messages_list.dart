import 'dart:collection';
import 'package:joyvee/src/models/models.dart';

List<Message> _messages = [
  Message(id: 50, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 19, 6, 15), content: "Hello!"),
  Message(id: 49, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 19, 6, 14), content: "hi"),
  Message(id: 48, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 19, 6, 12), content: "That twenty-five hours seemed more like a week in her mind"),
  Message(id: 47, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 19, 6, 10), content: "The fact that she still was having trouble comprehending exactly what took place wasn't helping the matter."),
  Message(id: 46, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 19, 6), content: "yes"),
  Message(id: 45, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 6, 12), content: "no"),
  Message(id: 44, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 17, 6, 12), content: "Learn taken terms be as. "),
  Message(id: 43, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 6, 10), content: "Shewing met parties gravity husband sex pleased."),
  Message(id: 42, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 6), content: "Civility vicinity graceful is it at."),
  Message(id: 41, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 5, 40), content: "I have a reservation. My name is John Sandals."),
  Message(id: 40, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 5, 34), content: "May I see your ID, please, Mr. Sandals?"),
  Message(id: 39, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 17, 5, 32), content: "Certainly. Here it is."),
  Message(id: 38, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 17, 5, 30), content: "Thank you. Do you have a credit card, Mr. Sandals?"),
  Message(id: 37, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 17, 5), content: "Yes, I do. Do you accept American Express?"),
  Message(id: 36, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 14, 3, 23), content: "Sorry, sir, just VISA or MasterCard."),
  Message(id: 35, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 14, 3, 22), content: "Here's my VISA card."),
  Message(id: 34, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 14, 3, 20), content: "Okay. You're in room 507. It's a single queen-size bed, spacious, and nonsmoking. Is that suitable?"),
  Message(id: 33, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 14, 3, 2), content: "Yes, it sounds like everything I expected."),
  Message(id: 32, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 14, 3), content: "Here's your key, sir. If you need anything, just dial 0 on your room phone."),
  Message(id: 31, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 14, 2, 2), content: "I need a suggestion for a restaurant here in Manhattan."),
  Message(id: 30, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 14, 2, 1), content: "Certainly! How much are you planning to spend on dinner, sir?"),
  Message(id: 29, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 14, 2), content: "My date's very sophisticated, so I'm sure she would expect nothing but the best."),
  Message(id: 28, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 9, 2, 0), content: "May I suggest our own hotel restaurant? It got three stars in the latest restaurant review."),
  Message(id: 27, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 9, 0, 10), content: "No, thank you, I want to go out on the town. What other ideas do you have?"),
  Message(id: 26, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 9, 0, 6), content: "There's always Gramercy Tavern. They have live jazz. The food is delicious, but very expensive."),
  Message(id: 25, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 9, 0, 5), content: "That sounds like a good place to take a date. Can you make a reservation for me?"),
  Message(id: 24, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 9), content: "As you wish, sir. You'll have a wonderful time there."),
  Message(id: 23, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 4, 0, 30), content: "Can you tell me about a nice restaurant to go to?"),
  Message(id: 22, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 4, 0, 27), content: "Of course! How much would you like to spend on your meal?"),
  Message(id: 21, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 4, 0, 22), content: "My date is quite sophisticated. She would expect nothing less than the best."),
  Message(id: 20, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 4, 0, 21), content: "Well, how about our own hotel restaurant? It's conveniently located and has a three-star rating."),
  Message(id: 19, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 4, 0, 20), content: "That's a good idea, except I want to go out, not stay in. Something else, maybe?"),
  Message(id: 18, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 2, 5, 30, 10), content: "Well, how about Gramercy Tavern? It's a very popular tourist spot, with great food and music."),
  Message(id: 17, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 2, 5, 30), content: "That sounds good! Could you call them to see if I can get a reservation?"),
  Message(id: 16, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 2, 5, 14), content: "Of course, sir. You've made a good choice."),
  Message(id: 15, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 2, 5, 12), content: "My amenities bill says that I owe 10 for a movie, but I never ordered one."),
  Message(id: 14, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 2, 5, 10), content: "Let's see. It says that you were charged Monday at 9:00 p.m. for the movie Titanic."),
  Message(id: 13, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 2, 5), content: "That's absolutely wrong! I was out exploring the city Monday night."),
  Message(id: 12, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 2, 2, 5), content: "Okay, let me see what I can do."),
  Message(id: 11, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 2, 0, 20), content: "Thank you. I didn't think it would be this simple."),
  Message(id: 10, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 2), content: "I can take the 10 off your bill, but I need to charge you 2 for the service."),
  Message(id: 9, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 1, 14, 23, 12), content: "Are you serious? I have to pay 2 for a movie I never watched?"),
  Message(id: 8, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 1, 14, 23, 5), content: "Unfortunately, sir, it's how the computer is programmed."),
  Message(id: 7, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 1, 14, 23), content: "This is outrageous! I'm never coming back to this hotel again!"),
  Message(id: 6, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 1, 14, 20), content: "I'm sorry, sir. Perhaps you'd like to write a letter to headquarters."),
  Message(id: 5, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 1, 14, 20), content: "Is there a swimming pool in this hotel?"),
  Message(id: 4, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 1, 14, 18, 8), content: "What exactly does that mean?"),
  Message(id: 3, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 1, 14, 18, 7), content: "We don't have a full-sized swimming pool, but we do have individual swim stations."),
  Message(id: 2, chatId: 1, senderId: 96, requesterId: 98, date: DateTime(2023, 3, 1, 14, 18, 5), content: "Basically, a swim station is like a treadmill, except instead of running, you swim."),
  Message(id: 1, chatId: 1, senderId: 98, requesterId: 96, date: DateTime(2023, 3, 1, 14, 18), content: "That sounds really neat. Is there an extra charge for these swim stations?"),
];

final _kMessagesSource = Map.fromIterable(_messages,
    key: (item) => item.date.toUtc() as DateTime,
    value: (item) {
      List<Message> mss = [];
      for (Message m in _messages) {
        if (m.date.year == item.date.year && m.date.day == item.date.day && m.date.month == item.date.month) {
          mss.add(m);
        }
      }
      return mss;
    }
);

final kMessages = LinkedHashMap<DateTime, List<Message>>(
  equals: (DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }
    return a.year == b.year && a.month == b.month && a.day == b.day;
  },
  hashCode: (DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
)..addAll(_kMessagesSource);