import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'when2yapp_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseAnalytics>.value(value: analytics),
      ],
      child: const When2YappApp(),
    ),
  );
}
