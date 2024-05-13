import 'package:flutter/widgets.dart';
import 'dart:developer';
import 'dart:async';

import 'locator.dart';

/// Init function
Future<void> bootstrap({
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
          [Locator.locateServices(envParams: envParams), ...futures]);
      runApp(await builder());
    },
    (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}
