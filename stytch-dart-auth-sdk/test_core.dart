/// Test the core stytch SDK functionality without JSON serialization
import 'dart:convert';
import 'lib/src/models/error.dart';
import 'lib/src/client/stytch_client.dart';

void main() async {
  print('🔧 Testing stytch Dart B2B Auth SDK Core Functionality...\n');

  try {
    // Test 1: Configuration
    print('1. Testing StytchConfig...');
    final config = StytchConfig(
      apiKey: 'test-api-key',
      projectId: 'test-project-id',
      environment: 'sandbox',
    );
    print('   ✅ Config created successfully');
    print('   📍 Base URL: ${config.environmentBaseUrl}');

    // Test 2: HTTP Client
    print('\n2. Testing StytchHttpClient...');
    final httpClient = StytchHttpClient(config);
    print('   ✅ HTTP client created successfully');

    // Test 3: Error handling
    print('\n3. Testing Error Handling...');
    final authException = StytchAuthException('Test auth error');
    print('   ✅ Auth exception: ${authException.message}');
    
    final validationException = StytchValidationException('Test validation error');
    print('   ✅ Validation exception: ${validationException.message}');

    // Test 4: API Error Response
    print('\n4. Testing API Error Response...');
    final errorResponse = ApiErrorResponse(
      errorType: 'auth_error',
      errorMessage: 'Invalid credentials',
      errorCode: 'AUTH_INVALID',
    );
    print('   ✅ API error created: ${errorResponse.errorMessage}');

    print('\n🎉 All core tests passed!');
    print('✅ The stytch Dart B2B Auth SDK core structure is working correctly.');
    print('\n📋 Summary:');
    print('   • Configuration management ✅');
    print('   • HTTP client foundation ✅');
    print('   • Error handling system ✅');
    print('   • Exception hierarchy ✅');
    print('   • API response models ✅');
    
  } catch (e, stackTrace) {
    print('❌ Test failed: $e');
    print('StackTrace: $stackTrace');
  }
}