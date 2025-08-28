import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  static error(String str, {StackTrace? stackTrace}) {
    if (true) {
      // Use print instead of debugPrint for ANSI colors to work
      log('\x1B[31m$str\x1B[0m'); // Red color
      // get the #0 line of the stack trace
      log('\x1B[31m${StackTrace.current.toString()}\x1B[0m');
      if (stackTrace != null) {
        log('\x1B[31m$stackTrace\x1B[0m'); // Red color for stack trace too
      }
    }
  }

  static void warn(String text) {
    // show call stack show #1 only
    log('\x1B[33m$text\x1B[0m ${StackTrace.current.toString().split('\n')[1]}');
  }

  static void info(String text) {
    log('\x1B[32m$text\x1B[0m ${StackTrace.current.toString().split('\n')[1]}');
  }
}
