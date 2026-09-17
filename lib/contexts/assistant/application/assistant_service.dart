import '../../../core/api_client.dart';
import '../domain/conversation.dart';
/// "Astra": la pregunta va al backend, que hace de proxy con Gemini.
/// La clave del modelo nunca viaja dentro de la app.
class AssistantService {
  static Future<String> chat(String message, List<ConversationTurn> history) async {
    final data = await ApiClient.post('/client/chat', {
      'message': message,
      'history': history.map((t) => t.toJson()).toList(),
    }) as Map<String, dynamic>;
    return (data['reply'] ?? '').toString();
  }
}
