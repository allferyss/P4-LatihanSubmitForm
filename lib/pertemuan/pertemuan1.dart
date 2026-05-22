import 'package:flutter/material.dart';

class Pertemuan1Page extends StatelessWidget {
  const Pertemuan1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 1 - Pengenalan Flutter'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Apa itu Flutter?",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Flutter adalah framework UI open-source buatan Google untuk membangun aplikasi multi-platform "
                    "(mobile, web, desktop) dari satu basis kode yang sama (single codebase). Flutter menggunakan "
                    "bahasa pemrograman Dart dan memiliki keunggulan pada performa serta kemudahan membuat UI "
                    "yang cantik dan responsif.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Instalasi Flutter",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildInstallStep(
                    "1. Unduh SDK Flutter",
                    "Unduh file .zip Flutter SDK dari situs resmi flutter.dev sesuai dengan sistem operasi yang digunakan.",
                  ),
                  _buildInstallStep(
                    "2. Ekstrak dan Atur Path",
                    "Ekstrak file yang sudah diunduh ke folder yang diinginkan (misal: C:\\src\\flutter) lalu tambahkan path folder 'bin' ke Environment Variables.",
                  ),
                  _buildInstallStep(
                    "3. Jalankan Flutter Doctor",
                    "Buka terminal/CMD, jalankan perintah 'flutter doctor' untuk memeriksa dependency yang kurang.",
                  ),
                  _buildInstallStep(
                    "4. Instal Android Studio / VS Code",
                    "Gunakan IDE seperti Android Studio atau VS Code, lalu install plugin/extension Flutter dan Dart.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstallStep(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
