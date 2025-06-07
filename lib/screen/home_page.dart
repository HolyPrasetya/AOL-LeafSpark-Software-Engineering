import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/providers/user_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  // get article database
  final CollectionReference _productReference =
      FirebaseFirestore.instance.collection('article');

  // Make a home screen
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffAFFAC4), Color(0xff00543B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // Make a header
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                child: Card(
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: const Color(0xffA1E897),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.white,
                            child: Image.network(
                              'https://id.portal-pokemon.com/play/resources/pokedex/img/pm/2b3f6ff00db7a1efae21d85cfb8995eaff2da8d8.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome,',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                userProvider.username,
                                style: TextStyle(
                                  color: const Color(0xff3C7321),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Make a `Daily Article` title
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Daily Article !',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: GoogleFonts.inter().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // get data from database,
              // show it using card with grid layout
              StreamBuilder<QuerySnapshot>(
                stream: _productReference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    );
                  }

                  final docs = snapshot.data?.docs;
                  if (docs == null || docs.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Data Available',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    );
                  }

                  List<Map<String, dynamic>> listData = docs.map((doc) {
                    return doc.data() as Map<String, dynamic>;
                  }).toList();

                  return Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: Image.asset(
                                    listData[index]['image'],
                                    fit: BoxFit.cover,
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      listData[index]['title'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                  ),
                                  Text(
                                    'read more...',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
