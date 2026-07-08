import 'package:migla_flutter/env_switch.dart';

/// NOTE: prodHost always points to this url
// const String prodHost = 'http://10.73.28.222';
const String prodHost = 'https://migla.school';
// const String prodHost = 'http://localhost.com:3566';

// const String devHost = 'http://localhost.com:3566';

/// deployed url production
const String prodApiUrl = "$prodHost/api";

/// localhost url
const String devApiUrl = '$devHost/api';

/// returns true on build (not debug-apk) also TestFlight returns true
const bool isProduction = bool.fromEnvironment('dart.vm.product');

/// Optional build-time override injected by the Makefile / build script, e.g.
///   flutter build ... --dart-define=API_HOST=https://migla.school
/// When empty (normal `flutter run` / debug), it falls back to the
/// isProduction/useProdUrl logic below, whose production value is [prodHost].
const String apiHostOverride = String.fromEnvironment('API_HOST');
const bool hasApiHostOverride = apiHostOverride != '';

/// use this bool to switch the api url so you can forget about the isProduction bool

const String host = hasApiHostOverride
    ? apiHostOverride
    : (isProduction || useProdUrl ? prodHost : devHost);
const String apiUrl = '$host/api';
const String apiGraphqlUrl = '$apiUrl/graphql';
