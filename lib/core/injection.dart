import 'package:get_it/get_it.dart';
import 'package:nubank_test/core/network/custom_http_client.dart';
import 'package:nubank_test/core/network/dio_http_client.dart';
import 'package:nubank_test/modules/home/home_injection.dart';

Future<void> initializeDependencies() async {
  GetIt.I.registerLazySingleton<CustomHttpClient>(() => DioHttpClient());

  await initHomeModule();
}
