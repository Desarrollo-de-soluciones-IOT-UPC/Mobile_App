/// Estado del relé de un sensor, espejo del VO `PlugState` del backend.
///
/// Se distingue el estado REPORTADO por el equipo (llega en cada lectura) del
/// DESEADO por el usuario (la orden que sale de esta app y recoge el edge).
library;

enum PlugState {
  on('ON'),
  off('OFF');

  const PlugState(this.apiValue);

  final String apiValue;

  bool get isOn => this == PlugState.on;

  /// `null` si no hay orden todavía o el valor no es reconocible.
  static PlugState? fromApi(String? value) {
    final normalized = value?.trim().toUpperCase();
    for (final state in PlugState.values) {
      if (state.apiValue == normalized) return state;
    }
    return null;
  }
}
