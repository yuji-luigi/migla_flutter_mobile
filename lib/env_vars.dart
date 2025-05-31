const String prodApiUrl = "https://migla.yuji-luigi.com/api";
const String devApiUrl = 'http://localhost:3000/api';

const bool isProduction = bool.fromEnvironment('dart.vm.product');

const bool useProdUrl = true;

const String apiUrl = isProduction || useProdUrl ? prodApiUrl : devApiUrl;
const String apiGraphqlUrl = '$apiUrl/graphql';
