import 'package:bot_toast/bot_toast.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
import 'package:flutter/material.dart';

class ApplyActionCodeScreenViewModel extends ChangeNotifier {
  bool loading = false;

  void setLoading(bool load) {
    loading = load;
    notifyListeners();
  }

  Future<void> applyActionCode(
      String actionCode, VoidCallback onSuccess) async {
    try {
      setLoading(true);

      await stytchApp.stytchAuth?.applyActionCode(actionCode);

      onSuccess();

      BotToast.showText(text: 'Success');
    } catch (e) {
      BotToast.showText(text: e.toString());
    } finally {
      setLoading(false);
    }
  }
}
