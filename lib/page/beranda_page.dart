import 'package:flutter/material.dart';
import 'package:hasnan_latihan2pertemuan4/page/pertemuan/pertemuan4_page.dart';
import 'package:hasnan_latihan2pertemuan4/page/pertemuan/pertemuan5_page.dart';
import 'package:hasnan_latihan2pertemuan4/page/pertemuan/pertemuan6_page.dart';

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
    // Data untuk setiap card di dashboard
    final List<_DashboardItem> items = [
      _DashboardItem(
        title: "Pertemuan 4",
        subtitle: "Form Edit Profile, Toast dan Popup",
        icon: Icons.menu_book,
        iconColor: Colors.blue,
        bgColor: Color(0xFFDCE8F8),
      ),
      _DashboardItem(
        title: "Pertemuan 5",
        subtitle: "List View",
        icon: Icons.menu_book,
        iconColor: Colors.green,
        bgColor: Color(0xFFD6F0D6),
      ),
      _DashboardItem(
        title: "Pertemuan 6",
        subtitle: "Checkbox False, Null dan True",
        icon: Icons.menu_book,
        iconColor: Colors.orange,
        bgColor: Color(0xFFFFF3D6),
      ),
      _DashboardItem(
        title: "Pertemuan 7",
        subtitle: "Radio Button",
        icon: Icons.menu_book,
        iconColor: Colors.purple,
        bgColor: Color(0xFFECD8F8),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Dashboard",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Di layar lebar (desktop fullscreen), naikkan aspect ratio agar card lebih ramping
          // Di layar kecil (mobile), tetap pakai ratio normal
          final double ratio = constraints.maxWidth > 600 ? 1.6 : 0.95;

          return Padding(
            padding: EdgeInsets.all(16),
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
                  onTap: () {
                    if (index == 0) {
                      // Pertemuan 4 → buka form submit
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Pertemuan4Page(onProfileSubmit: onProfileSubmit),
                        ),
                      );
                    } else if (index == 1) {
                      // Pertemuan 5 → buka jadwal kuliah
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pertemuan5Page(),
                        ),
                      );
                    } else if (index == 2) {
                      // Pertemuan 6 → buka form checkbox
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pertemuan6Page(),
                        ),
                      );
                    } else {
                      // Pertemuan lain → placeholder (belum ada isinya)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${item.title} belum tersedia"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
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
                        SizedBox(height: 14),
                        // Title
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (item.subtitle != null) ...[
                          SizedBox(height: 4),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              item.subtitle!,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ],
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
}

class _DashboardItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  _DashboardItem({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });
}
