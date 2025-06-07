import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  String _type = 'Bug';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffAFFAC4),
          elevation: 0,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffAFFAC4), Color(0xff00543B)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Have a problem or suggestion? Please write it down here",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // Make dropdown button to filter type of feedback
                    DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: "Problem Type",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        items: ['Bug', 'Suggestion', 'Feedback']
                            .map((type) => DropdownMenuItem<String>(
                                value: type, child: Text(type)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _type = value!;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    // Make a form to submit feedback
                    TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                          hintText: 'Write a suggestion or problem here',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Make a button to submit feedback
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Submit Report",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                ),
              ),
            )));
  }
}
