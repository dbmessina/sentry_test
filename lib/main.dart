import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]);

  await SentryFlutter.init(
    (options) {
      options.dsn = 'DSN goes here';
      options.debug = true;
    },
    appRunner: () async {
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text(
                "This will get transmitted to Sentry - not async and exception not caught",
              ),
              onPressed: () {
                throw const TlsException("test 10");
              },
            ),
            ElevatedButton(
              child: const Text(
                "This will get transmitted to Sentry - async and exception caught",
              ),
              onPressed: () async {
                try {
                  throw const SignalException("test 20");
                } catch (exception, stackTrace) {
                  await Sentry.captureException(
                    exception,
                    stackTrace: stackTrace,
                  );
                }
              },
            ),
            ElevatedButton(
              child: const Text(
                "This will not get transmitted to Sentry - async and exception not caught",
              ),
              onPressed: () async {
                throw const HttpException("test 30");
              },
            ),
          ],
        ),
      ),
    );
  }
}
