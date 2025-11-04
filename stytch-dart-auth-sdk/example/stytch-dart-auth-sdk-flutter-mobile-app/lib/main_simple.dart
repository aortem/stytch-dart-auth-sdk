// Minimal working Flutter app using stytch SDK
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print('🎉 Initializing stytch SDK for Flutter demo...');

    // Create stytch auth instance
    final auth = stytchAuth(
      apiKey: 'demo_api_key',
      projectId: 'demo_project_id',
      environment: 'sandbox',
    );

    print('✅ stytch initialized: ${auth.isConfigured()}');
    print('📋 Configuration: ${auth.getConfiguration()}');

    runApp(MyApp(auth: auth));
  } catch (e, stackTrace) {
    print('❌ Error initializing stytch: $e');
    print('Stack trace: $stackTrace');

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                const Text(
                  'Failed to initialize stytch SDK',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('$e'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  final stytchAuth auth;

  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Provider<stytchAuth>.value(
      value: auth,
      child: MaterialApp(
        title: 'stytch SDK Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final stytchAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = context.read<stytchAuth>();
  }

  void _showSDKInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('stytch SDK Info'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('✅ SDK Status: Initialized'),
            Text('🔧 Project ID: ${_auth.getConfiguration()['projectId']}'),
            Text('🌍 Environment: ${_auth.getConfiguration()['environment']}'),
            Text('⏱️ Timeout: ${_auth.getConfiguration()['timeout']} seconds'),
            const SizedBox(height: 16),
            const Text(
              '🎯 This demonstrates the stytch B2B authentication SDK working in Flutter!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showServices() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Available Services'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🔐 Authentication Service'),
            Text('👤 User Management Service'),
            Text('🏢 Organization Service'),
            Text('📧 Invitation Service'),
            SizedBox(height: 16),
            Text(
              'Ready to use stytch B2B authentication features!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('stytch SDK Flutter Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.security, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            Text(
              'stytch B2B Authentication SDK',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter Integration Demo',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'SDK Status: Ready',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Configuration: ${_auth.getConfiguration()['environment']} environment',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Column(
                children: [
                  _buildDemoButton(
                    icon: Icons.info,
                    label: 'SDK Information',
                    color: Colors.blue,
                    onPressed: _showSDKInfo,
                  ),
                  const SizedBox(height: 16),
                  _buildDemoButton(
                    icon: Icons.build,
                    label: 'Available Services',
                    color: Colors.green,
                    onPressed: _showServices,
                  ),
                  const SizedBox(height: 16),
                  _buildDemoButton(
                    icon: Icons.code,
                    label: 'View API Examples',
                    color: Colors.orange,
                    onPressed: () {
                      _showAPIDocumentation();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showAPIDocumentation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('stytch SDK API Usage'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Basic Usage:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock('''
final auth = stytchAuth(
  apiKey: 'your_api_key',
  projectId: 'your_project_id',
  environment: 'sandbox',
);
              '''),
              const SizedBox(height: 16),
              const Text(
                'User Management:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock('''
final user = await auth.user.createUser(
  CreateUserRequest(
    email: 'user@example.com',
    organizationId: 'org_123',
  ),
);
              '''),
              const SizedBox(height: 16),
              const Text(
                'Authentication:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock('''
final result = await auth.auth.loginWithEmailPassword(
  EmailPasswordLoginRequest(
    email: 'user@example.com',
    password: 'password123',
  ),
);
              '''),
              const SizedBox(height: 16),
              const Text(
                'Organizations:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _buildCodeBlock('''
final org = await auth.organization.createOrganization(
  CreateOrganizationRequest(
    name: 'My Company',
    allowedDomains: ['company.com'],
  ),
);
              '''),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeBlock(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        code.trim(),
        style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
      ),
    );
  }
}
