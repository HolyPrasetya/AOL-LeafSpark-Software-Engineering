import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/signup_page.dart';
import 'package:myapp/firebase_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  final FirebaseService _auth = FirebaseService();

  Future<void> _signIn(BuildContext context) async {
    if (_loginKey.currentState?.validate() ?? false) {
      // set the loading state to true.
      setState(() {
        _isLoading = true;
      });

      // run signin function from firebase
      // set the user provider with user data.
      try {
        final userData =
            await _auth.signIn(_emailController.text, _passController.text);
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setId(userData["id"]);
        userProvider.setUsername(userData["username"]);
        userProvider.setEmail(userData["email"]);
        userProvider.setBio(userData["bio"]);
        userProvider.setPhone(userData["phone"]);
      } catch (e) {
        // if there is an error, show the error message.
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
  // Show sign in title, and show form for user to login.
  // Show message and button sign up for user to navigate to signup page.
  // Show login button, and run _signIn function.
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 55),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to LeafSpark!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: GoogleFonts.inter().fontFamily),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Form(
                    key: _loginKey,
                    child: Column(
                      children: [
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
                          controller: _passController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black,
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white),
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
                        RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: const TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                    text: 'Sign up here',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignupPage()));
                                      })
                              ]),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // check if loading state is true, show progress indicator,
                        // else, sow login button with onTap function to run _signIn function.
                        _isLoading
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: () {
                                  _signIn(context);
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
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
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
    );
  }
}
