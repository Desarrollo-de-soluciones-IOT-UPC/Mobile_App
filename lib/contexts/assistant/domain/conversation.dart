/// Un turno de la conversación con Astra, tal como lo espera el backend.
///
/// El agregado `Conversation` vive en el servidor (es quien recorta el historial a
/// los últimos 10 turnos y valida el tamaño del mensaje); aquí sólo se modela el
/// turno para no armar mapas sueltos por las pantallas.
library;

enum Speaker {
  user('user'),
  model('model');

  const Speaker(this.apiValue);

  final String apiValue;
}

class ConversationTurn {
  const ConversationTurn(this.speaker, this.text);

  const ConversationTurn.fromUser(this.text) : speaker = Speaker.user;

  const ConversationTurn.fromModel(this.text) : speaker = Speaker.model;

  final Speaker speaker;
  final String text;

  bool get isUser => speaker == Speaker.user;

  Map<String, String> toJson() => {'role': speaker.apiValue, 'text': text};
}
