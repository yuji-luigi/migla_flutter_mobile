// create extension on BuildContext to get localized strings

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/localization/app_localizations.dart';

extension LocaleCtx on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this)!;
}
