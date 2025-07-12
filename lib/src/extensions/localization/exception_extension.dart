extension FormattedMessage on Exception {
  String get getMessage {
    if (toString().startsWith("Exception: ")) {
      return toString().replaceAll('Exception: ', '');
    } else {
      return toString();
    }
  }
}
