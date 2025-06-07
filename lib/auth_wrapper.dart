import 'package:flutter/material.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/layout.dart';
import 'package:myapp/screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/firebase_service.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});

  final FirebaseService _auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    // AuthWrapper is to check if user is already login or not.
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if the connection is still waiting, show the loading indicator.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // if there is an error, show the message
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('Something went wrong!')),
            );
          }
          // if user is already login, get the user data
          if (snapshot.hasData) {
            final uid = snapshot.data?.uid;
            return FutureBuilder<Map<String, dynamic>?>(
              future: _auth.getUserData(uid),
              builder: (context, userSnapshot) {
                // while getting the data, show loading indicator
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                }
                // if the data is error or null, show the error message
                if (userSnapshot.hasError || userSnapshot.data == null) {
                  return const Scaffold(
                    body: Center(child: Text('Failed to load user data!')),
                  );
                }

                // set the user provider with user data, 
                // so later it can be accessed from other class
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);

                  userProvider.setEmail(userSnapshot.data!["email"] ?? "");
                  userProvider
                      .setUsername(userSnapshot.data!["username"] ?? "");
                  userProvider.setBio(userSnapshot.data!["bio"] ?? "");
                  userProvider.setPhone(userSnapshot.data!["phone"] ?? "");
                });

                // show layout page
                return const Layout();
              },
            );
          } else {
            // if user is not login, show login page
            return const LoginPage();
          }
        });
  }
}
