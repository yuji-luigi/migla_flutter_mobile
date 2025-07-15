const String prodHost = 'https://migla.yuji-luigi.com';
const String devHost = 'http://localhost:3566';
// const String devHost = 'http://localhost.com:3566';

/// deployed url production
const String prodApiUrl = "$prodHost/api";

/// localhost url
const String devApiUrl = '$devHost/api';

/// returns true on build (not debug-apk) also TestFlight returns true
const bool isProduction = bool.fromEnvironment('dart.vm.product');

/// use this bool to switch the api url so you can forget about the isProduction bool
const bool useProdUrl = false;

const String host = isProduction || useProdUrl ? prodHost : devHost;
const String apiUrl = isProduction || useProdUrl ? prodApiUrl : devApiUrl;
const String apiGraphqlUrl = '$apiUrl/graphql';
