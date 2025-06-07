import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/auth_wrapper.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:myapp/screen/edit_profile_page.dart';
import 'package:myapp/screen/notification_page.dart';
import 'package:myapp/screen/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:myapp/firebase_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final FirebaseService _auth = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffAFFAC4), Color(0xff00543B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(children: [
                // Make a profile of our user
                CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Image.network(
                      'https://id.portal-pokemon.com/play/resources/pokedex/img/pm/2b3f6ff00db7a1efae21d85cfb8995eaff2da8d8.png',
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    )),
                const SizedBox(width: 15),
                Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 100,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        // get user data from user provider, and show it
                        child: Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userProvider.username,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                userProvider.bio,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: GoogleFonts.inter().fontFamily),
                              )
                            ],
                          );
                        }),
                      ),
                    ))
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.grey,
              thickness: 3,
              height: 10,
            ),
            const SizedBox(
              height: 15,
            ),
            // Make a button for user to navigate to edit profile page.
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()));
              },
              child: Card(
                  color: const Color(0xff175138),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 70,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            // Make a button for user to navigate to setting page.
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()));
              },
              child: Card(
                  color: const Color(0xff175138),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 70,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            // Make a button for user to navigate to notification page.
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()));
              },
              child: Card(
                  color: const Color(0xff175138),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 70,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            // Make a button for user to signout and navigate to authwrapper page.
            GestureDetector(
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthWrapper()));
              },
              child: Card(
                  color: const Color(0xff175138),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 70,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
