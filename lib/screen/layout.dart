import 'package:flutter/material.dart';
import 'package:myapp/screen/camera_page.dart';
import 'package:myapp/screen/home_page.dart';
import 'package:myapp/screen/profile_page.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _currentIndex = 0;

  // Get of all page in the array
  final List<Widget> _pages = [
    MyHomePage(title: 'HomePage'),
    const CameraPage(),
    ProfilePage(),
  ];

  // Make a bottom navigation bar.
  // If it is clicked, it will return the index of the item.
  // When click, access the pages array with the index it's returned.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            iconSize: 32,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                  activeIcon: Icon(
                    Icons.home,
                    color: Colors.purple,
                  )),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: Colors.white,
                    ),
                  ),
                  label: ''),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: '')
            ]));
  }
}
