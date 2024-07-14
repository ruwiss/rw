import 'package:rw/src/core/clients/network_client.dart';
import 'package:flutter/material.dart';
import 'package:rw/src/main.dart';

import 'vmodel_state_helper.dart';

/// Contains ViewModel functionality for busy and error state management
class BaseViewModel extends ChangeNotifier with BusyAndErrorStateHelper {
  final NetworkClient networkClient = Rw.networkClient;
  void rebuildUi() => notifyListeners();
}
