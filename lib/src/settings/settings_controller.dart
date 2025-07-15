import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/internal/storage.dart';
import 'package:migla_flutter/src/models/internal/suppported_language.dart';
import 'package:provider/provider.dart';

import 'settings_service.dart';

/// A class that many Widgets can interact with to read user settings, update
/// user settings, or listen to user settings changes.
///
/// Controllers glue Data Services to Flutter Widgets. The SettingsController
/// uses the SettingsService to store and retrieve user settings.
class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  // Make SettingsService a private variable so it is not used directly.
  final SettingsService _settingsService;
  Locale _locale = const Locale('ja');

  // Make ThemeMode a private variable so it is not updated directly without
  // also persisting the changes with the SettingsService.
  late ThemeMode _themeMode;

  // Allow Widgets to read the user's preferred ThemeMode.
  ThemeMode get themeMode => _themeMode;

  /// Load the user's settings from the SettingsService. It may load from a
  /// local database or the internet. The controller only knows it can load the
  /// settings from the service.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();
    String? localeCode = await Storage.getLocale();
    if (localeCode != null) {
      _locale = Locale(localeCode);
    }
    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  Locale get locale => _locale;

  Future<void> updateLocale(String localeCode) async {
    await Storage.setLocale(localeCode);
    _locale = Locale(localeCode);
    notifyListeners();
  }

  /// Update and persist the ThemeMode based on the user's selection.
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }
}

SettingsController $settingsController(BuildContext context,
    {bool listen = true}) {
  return Provider.of<SettingsController>(context, listen: listen);
}
