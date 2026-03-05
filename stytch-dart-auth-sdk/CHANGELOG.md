## 0.0.1

### **Added**
* Added the core Stytch B2B SDK surface with a unified entrypoint in `lib/stytch_dart_auth_sdk.dart`.
* Added `StytchAuth` initialization flows (direct config, environment-variable bootstrap, and global helpers) in `lib/src/stytch_auth.dart`.
* Added a typed HTTP client and configuration layer in `lib/src/client/stytch_client.dart` with environment-aware base URLs and structured API error mapping.
* Added first-class client services for authentication, users, organizations, and invitations:
  * `lib/src/client/auth_service.dart`
  * `lib/src/client/user_service.dart`
  * `lib/src/client/organization_service.dart`
  * `lib/src/client/invitation_service.dart`
* Added typed request/response models for auth, user, organization, invitation, and error payloads under `lib/src/models/`.
* Added Firebase-compatibility support modules under `lib/src/auth/` (`firebase_compatibility.dart`, credentials, action code, persistence, multi-factor, storage, auth/id-token streams) to support Flutter-oriented integration scenarios.
* Added broader automated test coverage across auth compatibility, model serialization, and SDK entrypoints (unit and integration test updates in `test/`).
* Added expanded example app scaffolding under `example/`, including renamed Stytch-branded mobile sample app structure.

### **Changed**
* Promoted package version from `0.0.1-pre` to stable `0.0.1` in `pubspec.yaml`.
* Updated package metadata and runtime/tooling baselines:
  * Updated Dart SDK constraint to `^3.10.7`
  * Added `license: BSD-3`
  * Refreshed dependency versions for `ds_standard_features`, `build_web_compilers`, `jwt_generator`, and `ds_tools_testing`
  * Added `lints` and `flutter_lints` in dev dependencies
* Refactored sample app naming and paths from `cognito-*` to `stytch-*` conventions across example projects and CI references.
* Updated CI/CD pipeline wiring:
  * Reorganized child pipeline includes into `tools/pipelines/backend/` and `tools/pipelines/frontend/`
  * Added explicit `release` stage and improved merge-request debug output
  * Added formatting validation job (`dart format --set-exit-if-changed`)
  * Expanded branch/commit validation rules to include `docs` prefixes and semver-style release branch names
* Updated docs and repo metadata to reflect Stytch SDK structure and usage.

### **Fixed**
* Fixed SDK/package import and export path issues affecting SDK consumers and tests.
* Fixed Dart analysis/format issues across the SDK and test suites.
* Fixed sample app path references and CI analyze paths after repo/folder renaming.
* Fixed commit validation and branch naming checks in local hooks and CI setup.

## 0.0.1-pre

- Initial pre-release version of the Stytch Dart Auth SDK.
