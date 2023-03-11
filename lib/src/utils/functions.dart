// Описание вспомогательных функций

import 'dart:convert';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:crypto/crypto.dart';

import 'utils.dart';

class JoyveeFunctions {

  static StreamMemberType streamMemberTypeFromInt(int m) {
    switch (m) {
      case 1:
        return StreamMemberType.single;
      case 3:
        return StreamMemberType.group;
      default:
        return StreamMemberType.group;
    }
  }

  static int streamMemberTypeToInt(StreamMemberType m) {
    switch (m) {
      case StreamMemberType.single:
        return 1;
      case StreamMemberType.group:
        return 2;
    }
  }

  static StreamType streamTypeFromInt(int t) {
    switch (t) {
      case 1:
        return StreamType.standard;
      case 2:
        return StreamType.requested;
      case 3:
        return StreamType.planning;
      default:
        return StreamType.standard;
    }
  }

  static String streamTypeToInt(StreamType t) {
    switch (t) {
      case StreamType.standard:
        return "STANDARD";
      case StreamType.requested:
        return "REQUESTED";
      case StreamType.planning:
        return "PLANNING";
    }
  }

  static double getNumber(double input, {int precision = 1}) =>
      double.parse('$input'.substring(0, '$input'.indexOf('.') + precision + 1));

  static String ellipsisString(String stringToEllipsis) {
    return stringToEllipsis.replaceAll("", "\u{200B}");
  }

  static String decodeUtf8(String value) {
    List<int> bytes = value.toString().codeUnits;
    return utf8.decode(bytes);
  }

  // соскращает большие число (3 000 000 -> 3M)
  static String shortenNumber(int number) {
    return NumberFormat.compact().format(number);
  }

  static MessageType intToMessageType(int t) {
    switch (t) {
      case 1:
        return MessageType.message;
      case 2:
        return MessageType.image;
      case 3:
        return MessageType.voice;
      case 4:
        return MessageType.requestMessage;
      case 5:
        return MessageType.location;
      case 6:
        return MessageType.video;
      default:
        return MessageType.none;
    }
  }

  static String messageTypeToString(MessageType m) {
    switch (m) {
      case MessageType.message:
        return 'MESSAGE';
      case MessageType.image:
        return 'IMAGE';
      case MessageType.voice:
        return 'VOICE';
      case MessageType.requestMessage:
        return 'REQUEST_MESSAGE';
      case MessageType.location:
        return 'LOCATION';
      case MessageType.video:
        return 'VIDEO';
      case MessageType.none:
        return 'NONE';
    }
  }

  static ChatType chatTypeFromString(String c) {
    switch (c) {
      case "SINGLE":
        return ChatType.single;
      case "GROUP":
        return ChatType.group;
      case "STREAM":
        return ChatType.stream;
      default:
        return ChatType.single;
    }
  }

  static String parseDateTimeToString(DateTime d) {
    return '${d.day}.${d.month}.${d.year}';
  }

  static bool validateEmail(String e) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(e);
  }

  static HttpError generateExceptionByHttpCode(int statusCode) {
    switch (statusCode) {
      case 401:
        return const HttpError(false,
            error: 'unauthorized 🙁');
      case 500:
        return const HttpError(false,
          error: 'server error 🙁'
        );
      case 404:
        return const HttpError(false,
            error: 'not found 🤔');
      case 409:
        return const HttpError(false,
            error: 'Already exist! Please try another');
      case 403:
        return const HttpError(false,
            error: 'Permission denied');
      case 502:
        return const HttpError(false,
            error: 'Server not responding...');
      case 415:
        return const HttpError(false,
            error: 'Unsupported media');
      case 400:
        return const HttpError(false,
          error: 'Bad request');
      default:
        return const HttpError(true);
    }
  }

  static HttpError generateHttpException(Map<String, dynamic> result) {
    bool isError = result.containsKey("error");
    return isError ? HttpError(false, error: result['error']) : const HttpError(true);
  }


  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  static String generateNonce([int length = 32]) {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static int decimalCountDigits(double val) {
    return val.toString().contains('.') ? val.toString().split('.').removeLast().length : 0;
  }

  static Future<CameraController> getCameraController(
      ResolutionPreset resolutionPreset,
      CameraLensDirection cameraLensDirection) async {
    final cameras = await availableCameras();
    final camera = cameras
        .firstWhere((camera) => camera.lensDirection == cameraLensDirection);

    return CameraController(camera, resolutionPreset, enableAudio: false);
  }

  static String formatDateToMessengerSeparator(DateTime date) {
    final month = DateFormat.yMMM().format(date).split(" ")[0];
    final day = date.day;
    final year = date.year;
    final hour = date.hour < 10 ? '0${date.hour}' : date.hour;
    final minute = date.minute < 10 ? '0${date.minute}' : date.minute;
    return '$day $month., $year, $hour:$minute';
  }
}