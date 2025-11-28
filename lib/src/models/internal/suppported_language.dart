class SupportedLanguage {
  final String code;
  final String name;
  final String label;
  final String iconPath;

  SupportedLanguage({
    required this.code,
    required this.name,
    required this.label,
    required this.iconPath,
  });
}

List<SupportedLanguage> supportedLanguages = [
  SupportedLanguage(
    code: 'en',
    name: 'English',
    label: 'English',
    iconPath: 'assets/images/flags/uk.svg',
  ),
  SupportedLanguage(
    code: 'it',
    name: 'Italiano',
    label: 'Italiano',
    iconPath: 'assets/images/flags/italy.svg',
  ),
  SupportedLanguage(
    code: 'ja',
    name: '日本語',
    label: '日本語',
    iconPath: 'assets/images/flags/japan.svg',
  ),
];
