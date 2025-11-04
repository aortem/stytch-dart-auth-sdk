/// Fix the syntax errors caused by duplicate field declarations
library fix_syntax_errors;

import 'dart:io';

void main() {
  print('🔧 Fixing syntax errors from duplicate field declarations...');
  
  fixAllServiceFiles();
  
  print('');
  print('✅ All syntax errors fixed!');
}

/// Fix all service files by removing duplicate field declarations
void fixAllServiceFiles() {
  final services = [
    'lib/src/client/auth_service.dart',
    'lib/src/client/invitation_service.dart',
    'lib/src/client/organization_service.dart',
    'lib/src/client/user_service.dart',
  ];
  
  for (final file in services) {
    if (File(file).existsSync()) {
      fixServiceFile(file);
    }
  }
}

/// Fix individual service file
void fixServiceFile(String file) {
  var content = File(file).readAsStringSync();
  final lines = content.split('\n');
  
  // Find and remove duplicate field declarations
  final newLines = <String>[];
  bool foundField = false;
  bool foundConstructor = false;
  
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    
    // Keep the original field declaration
    if (line.contains('final StytchHttpClient _httpClient;') && !foundField) {
      newLines.add(line);
      foundField = true;
      continue;
    }
    
    // Skip duplicate field declarations
    if (line.contains('final StytchHttpClient _httpClient;') && foundField) {
      continue; // Skip this duplicate
    }
    
    // Keep constructor lines
    if (line.contains('AuthService(') || line.contains('InvitationService(') || 
        line.contains('OrganizationService(') || line.contains('UserService(')) {
      newLines.add(line);
      foundConstructor = true;
      continue;
    }
    
    // Keep constructor parameters and closing
    if (foundConstructor && (line.contains('this._httpClient') || 
        line.contains(');') || line.trim().startsWith('///'))) {
      newLines.add(line);
      continue;
    }
    
    // Stop adding constructor content after closing
    if (foundConstructor && line.trim() == ');') {
      foundConstructor = false;
    }
    
    // Add everything else
    newLines.add(line);
  }
  
  File(file).writeAsStringSync(newLines.join('\n'));
  print('✅ Fixed syntax errors: $file');
}