enum LinkType {
  reference,
  custom,
}

extension LinkTypeX on LinkType {
  /// Convert enum → JSON string
  String toJson() {
    switch (this) {
      case LinkType.reference:
        return 'reference';
      case LinkType.custom:
        return 'custom';
      default:
        return 'reference';
    }
  }

  /// Convert JSON string → enum
  static String fromJson(String raw) {
    switch (raw) {
      case 'reference':
        return LinkType.reference.name;
      case 'custom':
        return LinkType.custom.name;
      default:
        return LinkType.reference.name;
    }
  }
}
