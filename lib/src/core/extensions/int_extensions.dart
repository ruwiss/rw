import 'package:flutter/widgets.dart';

extension SizedBoxes on int {
  SizedBox sbh() => SizedBox(height: toDouble());
  SizedBox sbw() => SizedBox(width: toDouble());
}
