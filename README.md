# stytch-dart-auth-sdk

Repository for the `stytch_dart_auth_sdk` package and its supporting CI/pipeline tooling.

## Repository Layout

- `stytch-dart-auth-sdk/`: Dart package source, tests, changelog, and examples.
- `tools/pipelines/`: GitLab child pipeline definitions used by CI/CD.
- `.gitlab-ci.yml`: top-level pipeline orchestration.

## What This Repo Currently Provides

- A Dart SDK wrapper for Stytch B2B authentication APIs.
- Typed models and service clients for auth, users, organizations, and invitations.
- A Firebase-style compatibility layer used by the Flutter sample app.
- Unit and integration tests for core SDK and compatibility helpers.
- A Flutter example app at `stytch-dart-auth-sdk/example/stytch-dart-auth-sdk-flutter-mobile-app/`.

## Quick Start (Local Development)

```bash
cd stytch-dart-auth-sdk
dart pub get
dart analyze
dart test
```

To run the Flutter example app:

```bash
cd stytch-dart-auth-sdk/example/stytch-dart-auth-sdk-flutter-mobile-app
flutter pub get
flutter run
```

## Package Documentation

See the package README for API-level docs and usage examples:

- [stytch-dart-auth-sdk/README.md](stytch-dart-auth-sdk/README.md)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) before opening a pull request.

## License

BSD 3-Clause. See [LICENSE](LICENSE).
