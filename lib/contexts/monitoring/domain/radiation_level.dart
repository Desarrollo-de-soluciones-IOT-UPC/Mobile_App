/// Nivel de exposición electromagnética — la MISMA regla que el backend
/// (`RadiationLevel.java`), el edge (`value_objects.py`) y la web
/// (`radiation-level.ts`).
///
/// Este archivo es el cuarto espejo: con él, los umbrales viven en un solo sitio
/// conceptual y los cuatro stacks hablan de lo mismo. Antes el móvil tenía la
/// constante suelta (`etapa3SafetyThreshold = 200`) dentro de un archivo de widgets.
///
/// **El edge es la autoridad**: `levelOf` respeta el nivel que llegue del backend y
/// sólo clasifica por valor cuando la lectura viene sin él.
library;

/// Unidad en la que EMSafe mide el campo magnético.
const String radiationUnit = 'µT';

/// Umbrales en µT. Referencia ICNIRP 50 Hz, público general.
const double cautionUT = 100;
const double dangerUT = 200;

enum RadiationLevel {
  safe('safe'),
  caution('caution'),
  danger('danger');

  const RadiationLevel(this.apiValue);

  /// Literal que viaja por la API ("safe" | "caution" | "danger").
  final String apiValue;

  bool get isDangerous => this == RadiationLevel.danger;
}

/// Clasifica por valor. Respaldo: normalmente el nivel lo decide el edge.
RadiationLevel levelForValue(double? value) {
  if (value == null || value < cautionUT) return RadiationLevel.safe;
  if (value < dangerUT) return RadiationLevel.caution;
  return RadiationLevel.danger;
}

/// Nivel efectivo: respeta el del edge y sólo clasifica si no viene.
RadiationLevel levelOf(String? reported, double? value) {
  final normalized = reported?.trim().toLowerCase();
  for (final level in RadiationLevel.values) {
    if (level.apiValue == normalized) return level;
  }
  return levelForValue(value);
}

/// El peor de dos niveles — para resumir varios sensores en un solo indicador.
RadiationLevel worseOf(RadiationLevel a, RadiationLevel b) =>
    a.index >= b.index ? a : b;
