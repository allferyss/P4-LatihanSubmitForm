import 'package:flutter/material.dart';
import 'package:hasnan_latihan2pertemuan4/page/beranda_page.dart';
import 'package:hasnan_latihan2pertemuan4/page/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  String _profileName = "Hasnan Fathir Al Ghiffary";
  String _profileJobTitle = "Flutter Software Engineer";
  String _profileCompany = "Universitas Pamulang";
  String _profileLocation = "Tangerang Selatan, Indonesia";
  String _profileDescription =
      "Hai, saya Hasnan Fathir Al Ghiffary. Saya adalah mahasiswa semester 4 jurusan Informatika di Universitas Pamulang. Saya adalah seorang junior mobile developer yang sedang belajar membangun aplikasi mobile.";

  void _updateProfile({
    required String name,
    required String jobTitle,
    required String company,
    required String location,
    required String description,
  }) {
    setState(() {
      _profileName = name;
      _profileJobTitle = jobTitle;
      _profileCompany = company;
      _profileLocation = location;
      _profileDescription = description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: [
          BerandaPage(onProfileSubmit: _updateProfile),
          ProfilePage(
            name: _profileName,
            jobTitle: _profileJobTitle,
            company: _profileCompany,
            location: _profileLocation,
            description: _profileDescription,
          ),
        ][currentPage],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentPage,
          onTap: (i) => setState(() => currentPage = i),
          items: [
            // Beranda
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Beranda"),
              selectedColor: Colors.blue,
            ),

            // Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
