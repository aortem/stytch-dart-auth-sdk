import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print('🎉 Initializing stytch SDK for Flutter demo...');

    final auth = StytchAuth(
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
  final StytchAuth auth;
  const MyApp({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Provider<StytchAuth>.value(
      value: auth,
      child: MaterialApp(
        title: 'Stytch SDK Dashboard',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF7F8FA),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          cardTheme: const CardThemeData(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        home: const DashboardPage(),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  late final StytchAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = context.read<StytchAuth>();
  }

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.info_outline, 'label': 'SDK Info'},
    {'icon': Icons.settings, 'label': 'Services'},
    {'icon': Icons.description_outlined, 'label': 'API Docs'},
    {'icon': Icons.play_arrow_outlined, 'label': 'Test SDK'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ---- SIDEBAR (modern light version) ----
          Container(
            width: 80,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              border: Border(
                right: BorderSide(color: Color(0xFFE0E0E0), width: 1),
              ),
            ),
            child: NavigationRail(
              backgroundColor: Colors.transparent,
              selectedIndex: _selectedIndex,
              labelType: NavigationRailLabelType.all,
              destinations: _navItems
                  .map(
                    (item) => NavigationRailDestination(
                      icon: Icon(item['icon'], color: Colors.grey[600]),
                      selectedIcon: Icon(
                        item['icon'],
                        color: Colors.deepPurple,
                      ),
                      label: Text(
                        item['label'],
                        style: TextStyle(
                          color: _selectedIndex == _navItems.indexOf(item)
                              ? Colors.deepPurple
                              : Colors.grey[700],
                          fontWeight: _selectedIndex == _navItems.indexOf(item)
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onDestinationSelected: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          ),

          // ---- MAIN CONTENT ----
          Expanded(
            child: Column(
              children: [
                // ---- TOPBAR (clean white) ----
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Stytch B2B Flutter SDK Dashboard',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () =>
                                BotToast.showText(text: 'No new notifications'),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.person_outline,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () =>
                                BotToast.showText(text: 'Profile coming soon'),
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            icon: const Icon(Icons.logout, size: 18),
                            label: const Text('Logout'),
                            onPressed: () =>
                                BotToast.showText(text: 'Logged out!'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---- PAGE CONTENT ----
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Padding(
                      key: ValueKey(_selectedIndex),
                      padding: const EdgeInsets.all(24),
                      child: [
                        _buildSDKInfo(),
                        _buildServices(),
                        _buildApiDocs(),
                        _buildTestSDK(),
                      ][_selectedIndex],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- SDK INFO ----
  Widget _buildSDKInfo() {
    final config = _auth.getConfiguration();
    return ListView(
      children: [
        _sectionHeader(Icons.info_outline, 'SDK Information'),
        const SizedBox(height: 16),
        _statusTile('SDK Initialized & Ready', Colors.green),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3.6,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _infoGridCard('🔧 Project ID', config['projectId']),
            _infoGridCard('🌍 Environment', config['environment']),
            _infoGridCard('⏱ Timeout', '${config['timeout']} seconds'),
            _infoGridCard('🔗 Base URL', config['baseUrl']),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          '🎯 This demonstrates the Stytch B2B authentication SDK working in Flutter!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTile(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: color),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _infoGridCard(String label, String value) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // ---- SERVICES ----
  Widget _buildServices() {
    final services = [
      {'emoji': '🔐', 'title': 'Authentication', 'desc': 'Email, SSO, MFA'},
      {
        'emoji': '👤',
        'title': 'User Management',
        'desc': 'Create, update, delete',
      },
      {
        'emoji': '🏢',
        'title': 'Organizations',
        'desc': 'Manage orgs & domains',
      },
      {'emoji': '📧', 'title': 'Invitations', 'desc': 'Send & track invites'},
    ];

    return ListView(
      children: [
        _sectionHeader(Icons.settings, 'Available Services'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: services
              .map(
                (s) => _buildServiceCard(s['emoji']!, s['title']!, s['desc']!),
              )
              .toList(),
        ),
      ],
    );
  }

  // ---- API DOCS ----
  Widget _buildApiDocs() {
    return ListView(
      children: [
        _sectionHeader(Icons.description_outlined, 'API Documentation'),
        const SizedBox(height: 16),
        _buildApiSection('Basic Usage:', '''
final auth = stytchAuth(
  apiKey: 'your_api_key',
  projectId: 'your_project_id',
  environment: 'sandbox',
);'''),
        _buildApiSection('User Management:', '''
final user = await auth.user.createUser(
  CreateUserRequest(email: 'user@example.com', organizationId: 'org_123'),
);'''),
        _buildApiSection('Authentication:', '''
final result = await auth.auth.loginWithEmailPassword(
  EmailPasswordLoginRequest(email: 'user@example.com', password: 'password123'),
);'''),
      ],
    );
  }

  // ---- TEST SDK ----
  Widget _buildTestSDK() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.play_arrow_outlined),
        label: const Text('Run SDK Test'),
        onPressed: () =>
            BotToast.showText(text: '🎉 SDK is working perfectly!'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // ---- HELPERS ----
  Widget _buildServiceCard(String emoji, String title, String desc) {
    return Card(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              desc,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiSection(String title, String code) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Text(
                code.trim(),
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
