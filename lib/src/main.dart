import 'package:fluid_dialog/fluid_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'core/clients/network_client.dart';
import 'core/utils/device_info.dart';
import 'core/utils/package_info.dart';
import 'dart:developer';
import 'locator.dart';
import 'dart:async';

abstract final class Rw {
  /// [Locator] instance
  static GetIt get locator => RwLocator.instance;

  /// Init Dependency Injection
  static Future<void> init({
    required Iterable<Future> futures,
    required Iterable<void> functions,
    required Map<String, dynamic> envParams,
    required FutureOr<Widget> Function() builder,
  }) async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    await runZonedGuarded<Future<void>>(
      () async {
        WidgetsFlutterBinding.ensureInitialized();
        await Future.wait([RwLocator.locateServices(envParams: envParams)]);
        await Future.wait(futures);
        runApp(await builder());
      },
      (error, stackTrace) {
        log(error.toString(), stackTrace: stackTrace);
      },
    );
  }

  /// [NetworkClient] instance
  static NetworkClient get networkClient => locator<NetworkClient>();

  /// [PackageInfoUtils] instance
  static PackageInfoUtils get packageInfoUtils => PackageInfoUtils();

  /// [DeviceInfoUtils] instance
  static DeviceInfoUtils get deviceInfoUtils => DeviceInfoUtils();

  /// Dialog
  static FluidDialog dialog(FluidDialogPage dialogPage) {
    return FluidDialog(rootPage: dialogPage);
  }

  /// Dialog page
  static FluidDialogPage dialogPage(
      {required Widget Function(BuildContext) builder}) {
    return FluidDialogPage(builder: builder);
  }
}
