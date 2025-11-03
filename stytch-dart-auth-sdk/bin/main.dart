import 'dart:convert';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() async {
  try {
    // Initialize stytch with your credentials
    final auth = stytchAuth(
      apiKey: 'YOUR_API_KEY', // Replace with your actual API key
      projectId: 'YOUR_PROJECT_ID', // Replace with your actual project ID
      environment: 'sandbox', // Use 'sandbox' for testing, 'production' for live
    );

    print('Stytch initialized: ${auth.isConfigured()}');
    print('Configuration: ${auth.getConfiguration()}');

    // Example 1: Create a new user
    print('\n=== Creating User ===');
    final createUserRequest = CreateUserRequest(
      email: 'user@example.com',
      name: 'John Doe',
      organizationId: 'YOUR_ORG_ID', // Replace with your organization ID
    );

    // Note: This would make an actual API call - commented out for demo
    // final newUser = await auth.user.createUser(createUserRequest);
    print('User creation request prepared: ${createUserRequest.email}');

    // Example 2: Login with email and password
    print('\n=== Authentication Example ===');
    final loginRequest = EmailPasswordLoginRequest(
      email: 'user@example.com',
      password: 'password123',
      organizationId: 'YOUR_ORG_ID',
    );

    // Note: This would make an actual API call - commented out for demo
    // final authResponse = await auth.auth.loginWithEmailPassword(loginRequest);
    print('Login request prepared for: ${loginRequest.email}');

    // Example 3: Session validation
    print('\n=== Session Management Example ===');
    final sessionRequest = ValidateSessionRequest(
      sessionToken: 'YOUR_SESSION_TOKEN', // Replace with actual session token
    );

    // Note: This would make an actual API call - commented out for demo
    // final sessionResponse = await auth.auth.validateSession(sessionRequest);
    print('Session validation request prepared');

    // Example 4: Organization management
    print('\n=== Organization Example ===');
    final createOrgRequest = CreateOrganizationRequest(
      name: 'Test Organization',
      slug: 'test-org',
      allowedDomains: ['example.com'],
    );

    // Note: This would make an actual API call - commented out for demo
    // final org = await auth.organization.createOrganization(createOrgRequest);
    print('Organization creation request prepared: ${createOrgRequest.name}');

    // Example 5: Send invitation
    print('\n=== Invitation Example ===');
    final invitationRequest = SendInvitationRequest(
      email: 'newuser@example.com',
      organizationId: 'YOUR_ORG_ID',
      attributes: {'role': 'member'},
    );

    // Note: This would make an actual API call - commented out for demo
    // final invitation = await auth.invitation.sendInvitation(invitationRequest);
    print('Invitation request prepared for: ${invitationRequest.email}');

    print('\n=== Demo Complete ===');
    print('To use this SDK:');
    print('1. Replace YOUR_API_KEY with your actual stytch API key');
    print('2. Replace YOUR_PROJECT_ID with your actual project ID');
    print('3. Uncomment the API calls to test with real requests');
    print('4. Handle exceptions with proper try-catch blocks');

  } catch (e) {
    print('Error: $e');
    if (e is StytchException) {
      print('Exception type: ${e.runtimeType}');
      print('Exception message: ${e.message}');
    }
  }
}
