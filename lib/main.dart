import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  // wait for firebase to initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // run our app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // this is provider for user.
      // so user information can be accessed from other classess.
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Leafsparks',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // run the splash screen first
        home: const SplashScreen(),
      ),
    );
  }
}
