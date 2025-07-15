import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static error(String str, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      // Use print instead of debugPrint for ANSI colors to work
      log('\x1B[31m$str\x1B[0m'); // Red color
      if (stackTrace != null) {
        log('\x1B[31m$stackTrace\x1B[0m'); // Red color for stack trace too
      }
    }
  }

  static void warn(String text) {
    log('\x1B[33m$text\x1B[0m');
  }

  static void info(String text) {
    log('\x1B[32m$text\x1B[0m');
  }
}
