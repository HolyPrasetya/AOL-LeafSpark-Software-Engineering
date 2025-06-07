import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/firebase_service.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/layout.dart';
import 'package:myapp/screen/login_page.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _signUpKey = GlobalKey<FormState>();
  final FirebaseService _auth = FirebaseService();

  Future<void> _register(BuildContext context) async {
    if (_signUpKey.currentState?.validate() ?? false) {
      // set loading state to true
      setState(() {
        _isLoading = true;
      });

      // run signup function from firebase
      // set the user provider with user data.
      try {
        final userData = await _auth.signUp(_usernameController.text,
            _emailController.text, _passController.text, _phoneController.text);
        // ignore: use_build_context_synchronously
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setId(userData["id"]);
        userProvider.setUsername(userData["username"]);
        userProvider.setEmail(userData["email"]);
        userProvider.setPhone(userData["phone"]);
        userProvider.setBio(userData["bio"]);

        // navigate to layout page after successfully register
        Navigator.pushAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const Layout()),
            (route) => false);
      } catch (e) {
        // if there is an error, show the error message.
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        // set the loading state to false.
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Make a container with linear gradient background,
  // Show signup title, and show form for user to signup.
  // Show message and button signin for user to navigate to signin page.
  // Show signup button, and run _register function.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffAFFAC4), Color(0xff00543B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 55),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Form(
                      key: _signUpKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert your username";
                              }

                              if (value.length > 10) {
                                return "Username can not be more than 10";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please fill your email";
                              }

                              if (!value.contains("@")) {
                                return "Please insert a valid email";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _phoneController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Phone Number',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert your phone number";
                              }

                              if (value.length > 13 || value.length < 11) {
                                return "Please insert a valid phone number";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _passController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                labelText: 'Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please insert your password";
                              }

                              if (value.length < 8) {
                                return "Password must be at least 8 character";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            controller: _confirmPassController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                labelText: 'Confirm Password',
                                labelStyle:
                                    const TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please fill confirm password";
                              }

                              if (value.length < 8) {
                                return "Password must be at least 8 character";
                              }

                              if (value != _passController.text) {
                                return "Confirm password must be same with password";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Already have an account? ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text: 'Sign in here',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));
                                        })
                                ]),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // if the loading state is true, show progress indicator,
                          // else show signup button to run _register function
                          _isLoading
                              ? const CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    _register(context);
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      color: Colors.black,
                                      child: const Center(
                                        child: Text(
                                          "Sign Up",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
