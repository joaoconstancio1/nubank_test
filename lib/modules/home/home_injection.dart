import 'package:get_it/get_it.dart';
import 'package:nubank_test/modules/home/data/repositories/alias_repository_impl.dart';
import 'package:nubank_test/modules/home/data/services/alias_service.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';

Future<void> initHomeModule() async {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<AliasService>(() => AliasServiceImpl());

  getIt.registerLazySingleton<AliasRepository>(
    () => AliasRepositoryImpl(getIt<AliasService>()),
  );

  getIt.registerFactory(() => AliasCubit(getIt<AliasRepository>()));
}
