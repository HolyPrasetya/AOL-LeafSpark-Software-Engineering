import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/user_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;

  late TextEditingController _bioController;

  late TextEditingController _phoneController;

  final FirebaseService _auth = FirebaseService();

  @override
  void initState() {
    super.initState();
    // set the controller of user provider data,
    // so later the form is already filled with user data.
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _usernameController = TextEditingController(text: userProvider.username);
    _bioController = TextEditingController(
      text: userProvider.bio,
    );
    _phoneController = TextEditingController(
      text: userProvider.phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make a header with title and back button.
      appBar: AppBar(
        title: Text(
          'Edit Profile',
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
          child: SingleChildScrollView(
            child: Column(
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
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3)),
                  child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Image.network(
                        'https://id.portal-pokemon.com/play/resources/pokedex/img/pm/2b3f6ff00db7a1efae21d85cfb8995eaff2da8d8.png',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Make a form for user to update his data
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Nickname',
                              labelStyle: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                              prefixIcon: const Icon(Icons.person_outlined),
                              suffixIcon: const Icon(Icons.edit)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a value";
                            }

                            if (value.length > 10) {
                              return "Maximum character is 10";
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _bioController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Bio',
                              labelStyle: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                              prefixIcon: const Icon(Icons.info_outline),
                              suffixIcon: const Icon(Icons.edit)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a bio";
                            }

                            if (value.length > 20) {
                              return "Bio cannot be more than 20 character";
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Phonenumber',
                            labelStyle: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                            prefixIcon: const Icon(Icons.call),
                          ),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Make a button to submit the form data,
                      // and run the editMyProfile function.
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              editMyProfile();
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Submit"))
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void editMyProfile() async {
    // update the user provider first
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUsername(_usernameController.text);
    userProvider.setBio(_bioController.text);
    // update in the database
    try {
      await _auth.updateUserData(
          _usernameController.text, _bioController.text, userProvider.id);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
