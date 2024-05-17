import 'core/clients/network_client.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

abstract final class RwLocator {
  /// [GetIt] instance
  static final instance = GetIt.instance;

  /// Responsible for registering the necessary dependencies
  static Future<void> locateServices(
      {required Map<String, dynamic> envParams}) async {
    instance
      // Clients
      ..registerLazySingleton<NetworkClient>(() =>
          NetworkClient(dio: instance(), baseUrl: envParams['BASE_URL'] ?? ''))
      // Client Dependencies
      ..registerFactory<Dio>(Dio.new);
  }
}
