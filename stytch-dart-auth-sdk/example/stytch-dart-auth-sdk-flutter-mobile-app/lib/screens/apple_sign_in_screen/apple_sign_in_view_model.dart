import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

class AppleSignInViewModel {
  final stytchAuth auth;

  AppleSignInViewModel({required this.auth});

  Future<UserCredential> signInWithApple(
    String idToken, {
    String? nonce,
  }) async {
    if (idToken.isEmpty) {
      throw stytchAuthException(
        code: 'invalid-id-token',
        message: 'Apple ID Token must not be empty',
      );
    }

    return await auth.signInWithApple(idToken, nonce: nonce);
  }
}
