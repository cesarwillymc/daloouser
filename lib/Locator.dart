
import 'package:daloouser/data/network/DialogService.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:get_it/get_it.dart';

import 'data/network/MainRepository.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => MainRepository());
}