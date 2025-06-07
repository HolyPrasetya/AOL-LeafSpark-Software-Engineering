import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/feedback_page.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xffAFFAC4),
          elevation: 0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffAFFAC4), Color(0xff00543B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child:
                // get data from user provider and set it to email and phone
                Consumer<UserProvider>(builder: (context, userProvider, child) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      color: Colors.grey,
                      thickness: 5,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      userProvider.email,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Phonenumber",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      userProvider.phone,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Check History",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Clear History",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FeedbackPage()));
                    },
                    child: ListTile(
                      title: Text(
                        "Support & Feedback",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 3,
                      color: Colors.black,
                    ),
                  ),
                ],
              );
            })));
  }
}
