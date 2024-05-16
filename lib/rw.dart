library rw;

import 'package:fluid_dialog/fluid_dialog.dart';
import 'src/core/utils/package_info.dart';
import 'src/core/utils/device_info.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'src/core/utils/icons.dart';
import 'src/locator.dart';
import 'dart:developer';
import 'dart:async';
import 'rw.dart';

// Theme
export 'src/app/theme/light_theme.dart';
export 'src/app/theme/base_theme.dart';
export 'src/app/theme/dark_theme.dart';

// Core
export 'src/core/extensions/context_extensions.dart';
export 'src/core/clients/network_client.dart';
export 'src/core/base/base_viewmodel.dart';

// Dependencies
export 'package:provider/provider.dart';
export 'package:dio/dio.dart';

abstract final class Rw {
  /// [Locator] instance
  static GetIt get locator => RwLocator.instance;

  /// Init Dependency Injection
  static Future<void> init({
    required Iterable<Future> futures,
    required FutureOr<Widget> Function() builder,
    required Map<String, dynamic> envParams,
  }) async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };
    await runZonedGuarded<Future<void>>(
      () async {
        await Future.wait(
            [RwLocator.locateServices(envParams: envParams), ...futures]);
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

  /// [FluentIcons] instance
  static FluentIcons get icons => FluentIcons();

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
