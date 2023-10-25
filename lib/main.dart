import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youtube_clone/cores/widgets/loader.dart';
import 'package:youtube_clone/features/auth/pages/login_page.dart';
import 'package:youtube_clone/features/feed/pages/home_page.dart';
import 'package:youtube_clone/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final goRouter = ref.watch(goRouterProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routerDelegate: goRouter.routerDelegate,
      // routeInformationParser: goRouter.routeInformationParser,
      // routeInformationProvider: goRouter.routeInformationProvider,
      home: StreamBuilder(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return const HomePage();
        },
      ),
    );
  }
}
