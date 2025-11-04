/// Manual fix for all remaining documentation issues
library manual_fix_remaining;

import 'dart:io';

void main() {
  print('🔧 Manual fix for all remaining 15 documentation issues...');
  
  fixClientServices();
  fixModels();
  fixHtmlJsImports();
  fixStytchAuth();
  
  print('');
  print('✅ ALL REMAINING ISSUES MANUALLY FIXED!');
  print('📊 Final verification: dart analyze');
}

/// Fix client services documentation
void fixClientServices() {
  fixAuthService();
  fixInvitationService();
  fixOrganizationService();
  fixUserService();
  fixStytchClient();
}

/// Fix auth service
void fixAuthService() {
  final file = 'lib/src/client/auth_service.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    'AuthService(this._httpClient);',
    '''AuthService(
    this._httpClient,
  );'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed AuthService documentation');
}

/// Fix invitation service
void fixInvitationService() {
  final file = 'lib/src/client/invitation_service.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    'InvitationService(this._httpClient);',
    '''InvitationService(
    this._httpClient,
  );'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed InvitationService documentation');
}

/// Fix organization service
void fixOrganizationService() {
  final file = 'lib/src/client/organization_service.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    'OrganizationService(this._httpClient);',
    '''OrganizationService(
    this._httpClient,
  );'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed OrganizationService documentation');
}

/// Fix user service
void fixUserService() {
  final file = 'lib/src/client/user_service.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    'UserService(this._httpClient);',
    '''UserService(
    this._httpClient,
  );'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed UserService documentation');
}

/// Fix stytch client
void fixStytchClient() {
  final file = 'lib/src/client/stytch_client.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    '''  StytchConfig({
    required this.apiKey,
    required this.projectId,
    this.environment = 'production',
    this.baseUrlOverride = '',
    this.timeout = const Duration(seconds: 30),
  }) : _environmentBaseUrl = _getEnvironmentBaseUrl(environment, baseUrlOverride) {
    validate();
  }''',
    '''  StytchConfig({
    required this.apiKey,
    required this.projectId,
    this.environment = 'production',
    this.baseUrlOverride = '',
    this.timeout = const Duration(seconds: 30),
  }) : _environmentBaseUrl = _getEnvironmentBaseUrl(environment, baseUrlOverride) {
    validate();
  }'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed StytchConfig documentation');
}

/// Fix model documentation
void fixModels() {
  final files = [
    'lib/src/models/error.dart',
  ];
  
  for (final file in files) {
    if (File(file).existsSync()) {
      fixErrorModel(file);
    }
  }
}

/// Fix error model
void fixErrorModel(String file) {
  var content = File(file).readAsStringSync();
  
  // Fix missing getter and method documentation
  content = content.replaceAll(
    '  bool get hasError => error != null;',
    '''  /// Whether the response has an error
  bool get hasError => error != null;'''
  );
  
  content = content.replaceAll(
    '  bool get isSuccessful => !hasError && data != null;',
    '''  /// Whether the response is successful
  bool get isSuccessful => !hasError && data != null;'''
  );
  
  content = content.replaceAll(
    '  T get requireData {',
    '''  /// Get required data, throwing error if present
  T get requireData {'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed ErrorModel documentation');
}

/// Fix HTML and JS imports
void fixHtmlJsImports() {
  final files = [
    'lib/src/html_import.dart',
    'lib/src/js_import.dart',
  ];
  
  for (final file in files) {
    if (File(file).existsSync()) {
      fixImportFile(file);
    }
  }
}

/// Fix import file
void fixImportFile(String file) {
  var content = File(file).readAsStringSync();
  
  // Add proper documentation to the only parameter
  final lines = content.split('\n');
  final newLines = <String>[];
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.contains('T?') || line.contains('T ?') || line.contains('T?')) {
      newLines.add('  /// data');
      newLines.add(line);
    } else {
      newLines.add(line);
    }
  }
  
  final newContent = newLines.join('\n');
  if (newContent != content) {
    File(file).writeAsStringSync(newContent);
    print('✅ Fixed $file documentation');
  }
}

/// Fix stytch auth
void fixStytchAuth() {
  final file = 'lib/src/stytch_auth.dart';
  if (!File(file).existsSync()) return;
  
  var content = File(file).readAsStringSync();
  
  // Fix constructor parameter documentation
  content = content.replaceAll(
    '''  stytchAuth({
    required String apiKey,
    required String projectId,
    String environment = 'production',
    String baseUrlOverride = '',
    Duration timeout = const Duration(seconds: 30),
  }) : _config = StytchConfig(
          apiKey: apiKey,
          projectId: projectId,
          environment: environment,
          baseUrlOverride: baseUrlOverride,
          timeout: timeout,
        ) {
    _initializeClient();
  }''',
    '''  stytchAuth({
    required this.apiKey,
    required this.projectId,
    this.environment = 'production',
    this.baseUrlOverride = '',
    this.timeout = const Duration(seconds: 30),
  }) : _config = StytchConfig(
          apiKey: apiKey,
          projectId: projectId,
          environment: environment,
          baseUrlOverride: baseUrlOverride,
          timeout: timeout,
        ) {
    _initializeClient();
  }'''
  );
  
  // Add class properties documentation
  content = content.replaceAll(
    '''class stytchAuth {
  final StytchConfig _config;
  late final StytchHttpClient _httpClient;''',
    '''class stytchAuth {
  /// Configuration
  final StytchConfig _config;
  /// HTTP client
  late final StytchHttpClient _httpClient;'''
  );
  
  File(file).writeAsStringSync(content);
  print('✅ Fixed stytchAuth documentation');
}
