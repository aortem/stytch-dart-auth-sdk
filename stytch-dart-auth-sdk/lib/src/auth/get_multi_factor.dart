/// Compatibility layer for Firebase Multi-Factor Authentication
library get_multi_factor;

import 'dart:async';

/// Mock MultiFactor class for Firebase compatibility
///
/// Provides multi-factor authentication support while using
/// stytch B2B SDK for the underlying authentication.
class MultiFactor {
  /// Creates a MultiFactor instance
  const MultiFactor();
}

/// Mock MultiFactorResolver class for Firebase compatibility
///
/// Resolves multi-factor authentication challenges by providing
/// the user with available factors and verification methods.
class MultiFactorResolver {
  /// The session ID for the multi-factor flow
  final String sessionId;

  /// The list of available hints
  final List<MultiFactorHint> hints;

  /// Creates a MultiFactorResolver instance
  ///
  /// [sessionId] - Session identifier
  /// [hints] - Available factor hints
  const MultiFactorResolver({required this.sessionId, required this.hints});

  /// Resolve the multi-factor challenge with the given hint
  ///
  /// [hint] - The factor hint to use
  /// [multiFactorVerifier] - The verifier for the chosen factor
  /// Returns a verification result
  Future<MultiFactorAssertion> resolveSignIn({
    required MultiFactorHint hint,
    required MultiFactorVerifier multiFactorVerifier,
  }) async {
    // Mock implementation
    return MultiFactorAssertion(sessionId: sessionId);
  }
}

/// Mock MultiFactorHint class for Firebase compatibility
///
/// Represents a hint for multi-factor authentication,
/// providing information about available factors.
class MultiFactorHint {
  /// The factor ID
  final String factorId;

  /// The enrollment ID
  final String enrollmentId;

  /// The factor type (phone, email, etc.)
  final String factorType;

  /// Creates a MultiFactorHint instance
  ///
  /// [factorId] - Factor identifier
  /// [enrollmentId] - Enrollment identifier
  /// [factorType] - The type of factor
  const MultiFactorHint({
    required this.factorId,
    required this.enrollmentId,
    required this.factorType,
  });
}

/// Mock PhoneMultiFactorGenerator class for Firebase compatibility
///
/// Provides phone-based multi-factor authentication while using
/// stytch B2B SDK for the actual authentication process.
class PhoneMultiFactorGenerator {
  /// Phone multi-factor provider identifier
  static const String phoneFactorProviderId = 'phone';

  /// Creates a PhoneMultiFactorGenerator instance
  const PhoneMultiFactorGenerator();

  /// Create a phone-based multi-factor assertion
  ///
  /// [verificationId] - The verification ID
  /// [smsCode] - The SMS verification code
  /// Returns a phone multi-factor assertion
  static PhoneMultiFactorAssertion getAssertion({
    required String verificationId,
    required String smsCode,
  }) {
    return PhoneMultiFactorAssertion(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}

/// Mock PhoneMultiFactorAssertion class for Firebase compatibility
///
/// Represents a phone-based multi-factor assertion for verification
/// of the second factor in authentication.
class PhoneMultiFactorAssertion {
  /// The verification ID
  final String verificationId;

  /// The SMS verification code
  final String smsCode;

  /// Creates a PhoneMultiFactorAssertion instance
  ///
  /// [verificationId] - Verification identifier
  /// [smsCode] - SMS code
  const PhoneMultiFactorAssertion({
    required this.verificationId,
    required this.smsCode,
  });
}

/// Mock TotpMultiFactorGenerator class for Firebase compatibility
///
/// Provides TOTP (Time-based One-Time Password) multi-factor authentication
/// while using stytch B2B SDK for the authentication flow.
class TotpMultiFactorGenerator {
  /// TOTP multi-factor provider identifier
  static const String totpFactorProviderId = 'totp';

  /// Creates a TotpMultiFactorGenerator instance
  const TotpMultiFactorGenerator();

  /// Create a TOTP-based multi-factor assertion
  ///
  /// [oneTimePassword] - The TOTP code
  /// Returns a TOTP multi-factor assertion
  static TotpMultiFactorAssertion getAssertion({
    required String oneTimePassword,
  }) {
    return TotpMultiFactorAssertion(oneTimePassword: oneTimePassword);
  }
}

/// Mock TotpMultiFactorAssertion class for Firebase compatibility
///
/// Represents a TOTP-based multi-factor assertion for verification
/// of the second factor in authentication.
class TotpMultiFactorAssertion {
  /// The one-time password (TOTP)
  final String oneTimePassword;

  /// Creates a TotpMultiFactorAssertion instance
  ///
  /// [oneTimePassword] - TOTP code
  const TotpMultiFactorAssertion({required this.oneTimePassword});
}

/// Mock MultiFactorAssertion class for Firebase compatibility
///
/// Base class for multi-factor assertions that can be used
/// to complete multi-factor authentication challenges.
class MultiFactorAssertion {
  /// The session ID associated with this assertion
  final String sessionId;

  /// Creates a MultiFactorAssertion instance
  ///
  /// [sessionId] - Session identifier
  const MultiFactorAssertion({required this.sessionId});
}

/// Mock MultiFactorVerifier class for Firebase compatibility
///
/// Interface for verifiers that can complete multi-factor authentication
/// challenges for specific factor types.
abstract class MultiFactorVerifier {
  /// The factor ID this verifier handles
  final String factorId;

  /// Creates a MultiFactorVerifier instance
  ///
  /// [factorId] - Factor identifier
  const MultiFactorVerifier({required this.factorId});
}

/// Mock EmailMultiFactorGenerator class for Firebase compatibility
///
/// Provides email-based multi-factor authentication while using
/// stytch B2B SDK for the authentication flow.
class EmailMultiFactorGenerator {
  /// Email multi-factor provider identifier
  static const String emailFactorProviderId = 'email';

  /// Creates an EmailMultiFactorGenerator instance
  const EmailMultiFactorGenerator();

  /// Create an email-based multi-factor assertion
  ///
  /// [confirmationCode] - The email confirmation code
  /// Returns an email multi-factor assertion
  static EmailMultiFactorAssertion getAssertion({
    required String confirmationCode,
  }) {
    return EmailMultiFactorAssertion(confirmationCode: confirmationCode);
  }
}

/// Mock EmailMultiFactorAssertion class for Firebase compatibility
///
/// Represents an email-based multi-factor assertion for verification
/// of the second factor in authentication.
class EmailMultiFactorAssertion {
  /// The email confirmation code
  final String confirmationCode;

  /// Creates an EmailMultiFactorAssertion instance
  ///
  /// [confirmationCode] - Email confirmation code
  const EmailMultiFactorAssertion({required this.confirmationCode});
}
