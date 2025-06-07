enum LinkAppearance {
  defaultAppearance,
  primary,
}

extension LinkAppearanceX on LinkAppearance {
  /// Convert enum → JSON string
  String toJson() {
    switch (this) {
      case LinkAppearance.defaultAppearance:
        return 'defaultAppearance';
      case LinkAppearance.primary:
        return 'primary';
    }
  }

  /// Convert JSON string → enum
  static String fromJson(String raw) {
    switch (raw) {
      case 'default':
        return LinkAppearance.defaultAppearance.name;
      case 'primary':
        return LinkAppearance.primary.name;
      default:
        throw ArgumentError('Unknown LinkAppearance: $raw');
    }
  }
}
