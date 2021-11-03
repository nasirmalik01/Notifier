// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "letUsNotify1": "Let us Notify",
  "letUsNotify2": "when to plug",
  "letUsNotify3": "In your charger!",
  "remainingBattery": "Remaining Battery:",
  "activateClutch": "Activate the 1% clutch",
  "deActivateClutch": "De-Activate the 1% clutch"
};
static const Map<String,dynamic> es = {
  "letUsNotify1": "Permítanos notificar",
  "letUsNotify2": "cuando enchufar",
  "letUsNotify3": "¡En tu cargador!",
  "remainingBattery": "Batería restante:",
  "activateClutch": "Activar el embrague del 1%",
  "deActivateClutch": "Desactive el embrague del 1%"
};
static const Map<String,dynamic> zh = {
  "letUsNotify1": "让我们通知",
  "letUsNotify2": "什么时候插",
  "letUsNotify3": "在您的充电器中！",
  "remainingBattery": "剩余电池:",
  "activateClutch": "激活 1% 离合器",
  "deActivateClutch": "停用 1% 离合器"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "es": es, "zh": zh};
}
