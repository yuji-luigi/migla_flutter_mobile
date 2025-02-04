// create extension on BuildContext to get localized strings

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocaleCtx on BuildContext {
  AppLocalizations get t => AppLocalizations.of(this)!;
}
