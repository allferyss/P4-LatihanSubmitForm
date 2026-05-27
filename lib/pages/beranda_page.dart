import 'package:flutter/material.dart';
import 'package:hasnan_latihan2pertemuan4/pages/autocomplete.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan1.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan2-3.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan4.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan5.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan6.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan7.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan9.dart';
import 'package:hasnan_latihan2pertemuan4/pertemuan/pertemuan10.dart';

class BerandaPage extends StatelessWidget {
  final Function({
    required String name,
    required String jobTitle,
    required String company,
    required String location,
    required String description,
  })
  onProfileSubmit;

  const BerandaPage({super.key, required this.onProfileSubmit});

  @override
  Widget build(BuildContext context) {
    // Card Pertemuan
    final List<_DashboardItem> items = [
      _DashboardItem(
        title: "Pertemuan 1",
        subtitle: "Pengenalan Flutter & Widget Dasar",
        icon: Icons.menu_book,
        iconColor: Colors.indigo,
        bgColor: const Color(0xFFDDE0F8),
      ),
      _DashboardItem(
        title: "Pertemuan 2 & 3",
        subtitle: "Widget Column, Row & Form Activity",
        icon: Icons.menu_book,
        iconColor: Colors.lightBlue,
        bgColor: const Color(0xFFD4EEF9),
      ),
      _DashboardItem(
        title: "Pertemuan 4",
        subtitle: "Form Edit Profile, Toast dan Popup",
        icon: Icons.menu_book,
        iconColor: Colors.blue,
        bgColor: const Color(0xFFDCE8F8),
      ),
      _DashboardItem(
        title: "Pertemuan 5",
        subtitle: "List View",
        icon: Icons.menu_book,
        iconColor: Colors.green,
        bgColor: const Color(0xFFD6F0D6),
      ),
      _DashboardItem(
        title: "Pertemuan 6",
        subtitle: "Checkbox False, Null dan True",
        icon: Icons.menu_book,
        iconColor: Colors.orange,
        bgColor: const Color(0xFFFFF3D6),
      ),
      _DashboardItem(
        title: "Pertemuan 7",
        subtitle: "Radio Button",
        icon: Icons.menu_book,
        iconColor: Colors.purple,
        bgColor: const Color(0xFFECD8F8),
      ),
      _DashboardItem(
        title: "Pertemuan 8",
        subtitle: "Autocomplete & Spinner",
        icon: Icons.menu_book,
        iconColor: Colors.red,
        bgColor: const Color(0xFFF8D8D8),
      ),
      _DashboardItem(
        title: "Pertemuan 9",
        subtitle: "Date & Time Picker",
        icon: Icons.menu_book,
        iconColor: Colors.cyan,
        bgColor: const Color(0xFFD4F3F8),
      ),
      _DashboardItem(
        title: "Pertemuan 10",
        subtitle: "Tab Layout Laman",
        icon: Icons.tab,
        iconColor: Colors.teal,
        bgColor: const Color(0xFFE0F2F1),
      ),
      _DashboardItem(
        title: "Pertemuan 11",
        subtitle: "Belum Tersedia",
        icon: Icons.lock_outline,
        iconColor: Colors.grey,
        bgColor: const Color(0xFFEEEEEE),
        isComingSoon: true,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double ratio = constraints.maxWidth > 600 ? 1.6 : 0.95;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: ratio,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: item.isComingSoon
                      ? () => _showComingSoonSnackbar(context, item.title)
                      : () => _navigateTo(context, index),
                  child: Opacity(
                    opacity: item.isComingSoon ? 0.6 : 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Konten utama
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon circle
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: item.bgColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    item.icon,
                                    color: item.iconColor,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                // Title
                                Text(
                                  item.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: item.isComingSoon
                                        ? Colors.black38
                                        : Colors.black87,
                                  ),
                                ),
                                if (item.subtitle != null) ...[
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      item.subtitle!,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: item.isComingSoon
                                            ? Colors.black26
                                            : Colors.black54,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          // Badge "Segera Hadir" untuk yang belum tersedia
                          if (item.isComingSoon)
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Segera',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _showComingSoonSnackbar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title belum tersedia'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey[700],
      ),
    );
  }

  void _navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Pertemuan 1
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Pertemuan1Page()),
        );
        break;
      case 1:
        // Pertemuan 2 & 3 (gabungan)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Pertemuan23Page()),
        );
        break;
      case 2:
        // Pertemuan 4
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Pertemuan4Page(onProfileSubmit: onProfileSubmit),
          ),
        );
        break;
      case 3:
        // Pertemuan 5
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Pertemuan5Page()),
        );
        break;
      case 4:
        // Pertemuan 6
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Pertemuan6Page()),
        );
        break;
      case 5:
        // Pertemuan 7
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Pertemuan7Page()),
        );
        break;
      case 6:
        // Pertemuan 8
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AutocompletePage()),
        );
        break;
      case 7:
        // Pertemuan 9
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Pertemuan9Page()),
        );
        break;
      case 8:
        // Pertemuan 10
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const Pertemuan10Page()),
        );
        break;
    }
  }
}

class _DashboardItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final bool isComingSoon;

  _DashboardItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    this.isComingSoon = false,
  });
}
