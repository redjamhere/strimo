import '../services/services.dart';
import '../models/models.dart';
class StreamRepository {
  final StreamService _api = StreamService();

  Future<JStream> createBroadcast(JStream stream, String token) async {
    return await _api.createBroadcast(stream, token);
  }
}