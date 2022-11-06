//
import 'package:flutter/material.dart';

/// Helper class for device related operations.
///
mixin IZIDevice {
  ///
  /// hides the keyboard if its already open
  ///
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static void unFocus(BuildContext context) {
    // FocusScope.of(context).requestFocus(FocusNode());
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

}
