/// Conversiones tolerantes de JSON, compartidas por los modelos de todos los
/// contextos.
///
/// Vivían como funciones privadas al principio de `client_models.dart`. Al partir
/// ese archivo por bounded context habría hecho falta una copia en cada uno.
library;

double? toDoubleOrNull(dynamic v) => v == null ? null : (v as num).toDouble();

int toIntOrZero(dynamic v) => v == null ? 0 : (v as num).toInt();

int? toIntOrNull(dynamic v) => v == null ? null : (v as num).toInt();

String toStr(dynamic v) => (v ?? '').toString();
