/// Main export file for stytch_dart_auth_sdk
library stytch_dart_auth_sdk;

// Main stytch B2B SDK classes
export 'src/stytch_auth.dart';

// Models
export 'src/models/user.dart';
export 'src/models/auth.dart';
export 'src/models/organization.dart';
export 'src/models/invitation.dart';
export 'src/models/error.dart';

// Client services
export 'src/client/stytch_client.dart';
export 'src/client/auth_service.dart';
export 'src/client/user_service.dart';
export 'src/client/organization_service.dart';
export 'src/client/invitation_service.dart';

// Firebase compatibility layer (for Flutter example apps)
// Note: This creates a Firebase-like interface over stytch B2B functionality

// Export specific compatibility classes needed by Flutter app
export 'src/auth/credential.dart' hide StytchAuthException;
export 'src/auth/storage.dart';
export 'src/auth/persistence.dart';
export 'src/auth/get_multi_factor.dart';
export 'src/auth/action_code.dart';
export 'src/auth/firebase_compatibility.dart' hide stytchApp, stytchAuthInstance;
