import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fav_coffee/features/coffee/data/data.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  _registerDependencies();

  runApp(await builder());
}

void _registerDependencies() => GetIt.instance
  ..registerSingleton<Dio>(Dio())
  ..registerSingleton<CoffeeRemoteDataSource>(
    CoffeeRemoteDataSource(
      dio: GetIt.instance<Dio>(),
    ),
  )
  ..registerSingleton<Future<io.Directory> Function()>(
    getApplicationCacheDirectory,
  )
  ..registerSingleton<FileSystem>(const LocalFileSystem())
  ..registerSingleton<CoffeeLocalDataSource>(
    CoffeeLocalDataSource(
      getDirectory: GetIt.instance<Future<io.Directory> Function()>(),
      fileSystem: GetIt.instance<FileSystem>(),
    ),
  )
  ..registerSingleton<CoffeeRepository>(
    CoffeeRepository(
      remoteDataSource: GetIt.instance<CoffeeRemoteDataSource>(),
      localDataSource: GetIt.instance<CoffeeLocalDataSource>(),
    ),
  );
