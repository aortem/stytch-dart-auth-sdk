import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  // Start local server
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 3000);
  print('✅ Server running at http://localhost:3000');

  await for (HttpRequest request in server) {
    final path = request.uri.path;

    if (path == '/') {
      await showHomePage(request);
    } else if (path == '/send-link' && request.method == 'POST') {
      await sendMagicLink(request);
    } else if (path == '/authenticate') {
      await authenticateMagicLink(request);
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('404 Not Found')
        ..close();
    }
  }
}

/// HTML form for sending magic link
Future<void> showHomePage(HttpRequest request) async {
  const html = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Stytch Magic Link Demo</title>
    <style>
      body { font-family: sans-serif; margin: 40px; text-align: center; }
      input, button { padding: 10px; font-size: 16px; margin-top: 10px; }
    </style>
  </head>
  <body>
    <h2>🔐 Send a Magic Link</h2>
    <form action="/send-link" method="POST">
      <input type="email" name="email" placeholder="Enter your email" required><br>
      <button type="submit">Send Magic Link</button>
    </form>
  </body>
  </html>
  ''';

  request.response
    ..headers.contentType = ContentType.html
    ..write(html)
    ..close();
}

/// Send a Stytch magic link
Future<void> sendMagicLink(HttpRequest request) async {
  final content = await utf8.decoder.bind(request).join();
  final data = Uri.splitQueryString(content);

  final email = data['email'];
  if (email == null || email.isEmpty) {
    request.response
      ..statusCode = 400
      ..write('Missing email address')
      ..close();
    return;
  }

  final apiUrl = 'https://test.stytch.com/v1/b2b/magic_links/email/login_or_signup';
  final projectId = 'project-test-f04515f8-2cd1-483b-97dd-bb9ac9647fb3';
  final secret = 'secret-test--I7lknZGOF0USrgD7jJv9c5p8yxhaNKLKf4=';
  final organizationId = 'organization-test-d0ef20e7-96de-4182-a300-3aab2ac7b109';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      HttpHeaders.authorizationHeader:
          'Basic ${base64Encode(utf8.encode('$projectId:$secret'))}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "email_address": email,
      "organization_id": organizationId,
      "login_redirect_url": "http://localhost:3000/authenticate",
      "signup_redirect_url": "http://localhost:3000/authenticate",
    }),
  );

  if (response.statusCode == 200) {
    print('✅ Magic link sent to $email');
    request.response
      ..headers.contentType = ContentType.html
      ..write('<p>✅ Magic link sent! Check your email: $email</p>')
      ..close();
  } else {
    print('❌ Failed to send magic link: ${response.statusCode}');
    print(response.body);
    request.response
      ..headers.contentType = ContentType.html
      ..write('<p>❌ Failed to send magic link: ${response.body}</p>')
      ..close();
  }
}

/// Authenticate when user clicks the magic link
Future<void> authenticateMagicLink(HttpRequest request) async {
  final token = request.uri.queryParameters['token'];

  if (token == null) {
    request.response
      ..statusCode = 400
      ..write('❌ Missing token in URL')
      ..close();
    return;
  }

  final authUrl = 'https://test.stytch.com/v1/b2b/magic_links/authenticate';
  final projectId = 'project-test-f04515f8-2cd1-483b-97dd-bb9ac9647fb3';
  final secret = 'secret-test--I7lknZGOF0USrgD7jJv9c5p8yxhaNKLKf4=';

  final response = await http.post(
    Uri.parse(authUrl),
    headers: {
      HttpHeaders.authorizationHeader:
          'Basic ${base64Encode(utf8.encode('$projectId:$secret'))}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'magic_links_token': token}),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);

    final memberId = jsonResponse['member_id'];
    final email = jsonResponse['member']['email_address'];
    final orgId = jsonResponse['organization_id'];

    print('✅ Authentication successful!');
    print('🏢 Org ID: $orgId');
    print('👤 Member ID: $memberId');
    print('📧 Email: $email');

    request.response
      ..headers.contentType = ContentType.html
      ..write('''
        <h3>🎉 Login successful! You can close this tab.</h3>
        <p><b>Organization ID:</b> $orgId</p>
        <p><b>Member ID:</b> $memberId</p>
        <p><b>Email:</b> $email</p>
      ''')
      ..close();
  } else {
    print('❌ Authentication failed: ${response.statusCode}');
    print(response.body);
    request.response
      ..headers.contentType = ContentType.html
      ..write('<p>❌ Authentication failed: ${response.body}</p>')
      ..close();
  }
}
