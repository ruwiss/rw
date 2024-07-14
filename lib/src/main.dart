import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'core/clients/network_client.dart';
import 'core/utils/package_info.dart';
import 'core/utils/device_info.dart';
import 'dart:developer';
import 'locator.dart';
import 'dart:async';

GetIt get locator => RwLocator.instance;

abstract final class Rw {
  /// Init Dependency Injection
  static Future<void> init({
    required Map<String, dynamic> envParams,
    required Iterable<FutureOr<void>> functions,
    required List<SingleChildWidget> providers,
    required FutureOr<Widget> Function() builder,
  }) async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await RwLocator.locateServices(envParams: envParams);
        functions.map((func) async => await func());
        runApp(
          MultiProvider(
            providers: providers,
            child: await builder(),
          ),
        );
      },
      (error, stackTrace) {
        ("(error)", error: error, stackTrace: stackTrace);
      },
    );
  }

  /// [NetworkClient] instance
  static NetworkClient get networkClient => locator<NetworkClient>();

  /// [PackageInfoUtils] instance
  static PackageInfoUtils get packageInfoUtils => PackageInfoUtils();

  /// [DeviceInfoUtils] instance
  static DeviceInfoUtils get deviceInfoUtils => DeviceInfoUtils();
}
