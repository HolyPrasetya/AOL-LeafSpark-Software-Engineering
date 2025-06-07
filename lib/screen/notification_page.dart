import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _allowNotification = false;
  String _selectedAlert = 'vibration';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make a header
        appBar: AppBar(
          title: Text(
            'Notifications',
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
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                    color: const Color(0xff175138),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: SwitchListTile(
                        title: Text(
                          "Allow Notification",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: GoogleFonts.inter().fontFamily),
                        ),
                        value: _allowNotification,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xff434343),
                        activeTrackColor: const Color(0xff00996B),
                        onChanged: (value) {
                          setState(() {
                            _allowNotification = value;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (_allowNotification)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      color: const Color(0xff175138),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Alerts",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            RadioListTile<String>(
                              title: Text(
                                "Allow notification and vibration",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                ),
                              ),
                              value: 'vibration',
                              groupValue: _selectedAlert,
                              activeColor: const Color(0xff00996B),
                              onChanged: (value) {
                                setState(() {
                                  _selectedAlert = value!;
                                });
                              },
                            ),
                            RadioListTile<String>(
                                title: Text(
                                  "Allow notification only",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily),
                                ),
                                value: 'notifications',
                                groupValue: _selectedAlert,
                                activeColor: const Color(0xff00996B),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedAlert = value!;
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            )));
  }
}
