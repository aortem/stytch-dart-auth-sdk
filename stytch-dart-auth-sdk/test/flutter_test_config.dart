library flutter_test_config;

import 'dart:async';

/// Test configuration function
FutureOr<void> testExecutable(FutureOr<void> Function() main) {
  // Configure test execution here if needed
  return main();
}
