import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stytch_dart_auth_sdk/stytch_dart_auth_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    debugPrint('Initializing stytch SDK...');

    // Initialize stytch with mock credentials for demo
    final auth = stytchAuth(
      apiKey: 'demo_api_key',
      projectId: 'demo_project_id',
      environment: 'sandbox',
    );

    debugPrint('Stytch initialized: ${auth.isConfigured()}');
    debugPrint('Auth instance: $auth');

    // Wrap the app with Provider
    runApp(
      Provider<stytchAuth>.value(
        value: auth,
        child: const MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error initializing stytch: $e');
    debugPrint('StackTrace: $stackTrace');
    
    // Run app with error state
    runApp(const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Failed to initialize stytch SDK'),
        ),
      ),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'stytch SDK Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<stytchAuth>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('stytch SDK Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'stytch SDK is working!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text('Configured: ${auth.isConfigured()}'),
            Text('Environment: ${auth.getConfiguration()['environment']}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('stytch SDK is ready!')),
                );
              },
              child: const Text('Test SDK'),
            ),
          ],
        ),
      ),
    );
  }
}
