import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String jobTitle;
  final String company;
  final String location;
  final String description;

  const ProfilePage({
    super.key,
    required this.name,
    required this.jobTitle,
    required this.company,
    required this.location,
    required this.description,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _portfolioScrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final show = _scrollController.offset > 300;
      if (show != _showScrollToTop) {
        setState(() {
          _showScrollToTop = show;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _portfolioScrollController.dispose();
    super.dispose();
  }

  void _scrollPortfolio(double offset) {
    final double target = _portfolioScrollController.offset + offset;
    _portfolioScrollController.animateTo(
      target.clamp(
        _portfolioScrollController.position.minScrollExtent,
        _portfolioScrollController.position.maxScrollExtent,
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildExperienceCard({
    required IconData icon,
    required String position,
    required String company,
    required String period,
    required String desc,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blueAccent, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  position,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 2),
                Text(
                  company,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Text(
                  period,
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
                SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label, Color color) {
    return Chip(
      label: Text(label, style: TextStyle(color: Colors.white, fontSize: 13)),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(horizontal: 6),
    );
  }

  Widget _buildEducationCard({
    required IconData icon,
    required String institution,
    required String degree,
    required String period,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withAlpha(25),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blueAccent, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  institution,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                Text(
                  degree,
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Text(
                  period,
                  style: TextStyle(fontSize: 12, color: Colors.black38),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioCard({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
    required List<String> tags,
  }) {
    return GestureDetector(
      onTap: () => _showPortfolioDetail(
        icon: icon,
        title: title,
        desc: desc,
        color: color,
        tags: tags,
      ),
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header gradient with icon
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withAlpha(180), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(child: Icon(icon, size: 28, color: Colors.white)),
            ),
            // Info
            Padding(
              padding: EdgeInsets.fromLTRB(8, 6, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: tags.map((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: color.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 8,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Button Lihat Projek (di dalam card, bawah info)
            Padding(
              padding: EdgeInsets.fromLTRB(8, 20, 8, 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _showPortfolioDetail(
                    icon: icon,
                    title: title,
                    desc: desc,
                    color: color,
                    tags: tags,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Lihat Projek",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  void _showPortfolioDetail({
    required IconData icon,
    required String title,
    required String desc,
    required Color color,
    required List<String> tags,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withAlpha(25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color, size: 30),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Wrap(
                spacing: 8,
                children: tags.map((tag) {
                  return Chip(
                    label: Text(
                      tag,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: color,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                  );
                }).toList(),
              ),
              SizedBox(height: 10),
              Text(
                'Deskripsi Project',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.6,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToTop ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        child: _showScrollToTop
            ? FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.arrow_upward, color: Colors.white),
              )
            : SizedBox.shrink(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // Cover Photo + Avatar
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/think-positive-tumblr-banner-design-template-f84659542f8130fa09b67d8b3c8dfb39_screen.jpg?ts=1566598244',
                    ),
                    scale: 1.0,
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://tr.rbxcdn.com/180DAY-d4a6d1564bf7c0e65447501bdb3cc584/420/420/FaceAccessory/Webp/noFilter',
                      ),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),

              // Name
              SizedBox(height: 60),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400,
                ),
              ),

              // Job Title at Company
              SizedBox(height: 5),
              Text(
                "${widget.jobTitle} di ${widget.company}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),

              // Location
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.black45),
                  SizedBox(width: 4),
                  Text(
                    widget.location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),

              // Stats Card
              SizedBox(height: 15),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Project",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "16",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Followers",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 7),
                            Text(
                              "2308",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // About Section
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About Me",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Portfolio Section (Horizontal Scroll)
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Portofolio",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                height: 190,
                child: Row(
                  children: [
                    // Left arrow button
                    GestureDetector(
                      onTap: () => _scrollPortfolio(-150),
                      child: Container(
                        width: 28,
                        height: 50,
                        margin: EdgeInsets.only(left: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.blueAccent,
                          size: 22,
                        ),
                      ),
                    ),
                    // Portfolio cards
                    Expanded(
                      child: ListView(
                        controller: _portfolioScrollController,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        children: [
                          _buildPortfolioCard(
                            icon: Icons.cloud,
                            title: "Weather App",
                            desc:
                                "Cuaca real-time dengan animasi dan prakiraan 7 hari.",
                            color: Color(0xFF00BCD4),
                            tags: ["Flutter", "API"],
                          ),
                          _buildPortfolioCard(
                            icon: Icons.people,
                            title: "Social Media",
                            desc: "Platform sosial dengan feed dan messaging.",
                            color: Color(0xFFE91E63),
                            tags: ["Flutter", "Node.js"],
                          ),
                          _buildPortfolioCard(
                            icon: Icons.web,
                            title: "Portfolio Web",
                            desc:
                                "Website portofolio responsif dengan dark mode.",
                            color: Color(0xFFFF9800),
                            tags: ["HTML", "CSS", "JS"],
                          ),
                          _buildPortfolioCard(
                            icon: Icons.chat_bubble,
                            title: "Chat App",
                            desc: "Chat real-time dengan group chat dan media.",
                            color: Color(0xFF4CAF50),
                            tags: ["Flutter", "Socket.io"],
                          ),
                          _buildPortfolioCard(
                            icon: Icons.task_alt,
                            title: "Task Manager",
                            desc:
                                "Manajemen tugas dengan reminder dan statistik.",
                            color: Color(0xFF9C27B0),
                            tags: ["Flutter", "SQLite"],
                          ),
                        ],
                      ),
                    ),
                    // Right arrow button
                    GestureDetector(
                      onTap: () => _scrollPortfolio(150),
                      child: Container(
                        width: 28,
                        height: 50,
                        margin: EdgeInsets.only(right: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withAlpha(20),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.blueAccent,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Experience Section
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Experience",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildExperienceCard(
                      icon: Icons.phone_android,
                      position: "Junior Mobile Developer",
                      company: "Universitas Pamulang",
                      period: "Jan 2026 - Sekarang",
                      desc:
                          "Mengembangkan aplikasi mobile menggunakan Flutter dan Dart.",
                    ),
                    _buildExperienceCard(
                      icon: Icons.code,
                      position: "Freelance Web Developer",
                      company: "Self-Employed",
                      period: "Mei 2024 - Sekarang",
                      desc: "Membuat website company profile untuk UMKM lokal.",
                    ),
                  ],
                ),
              ),

              // Skills Section
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Skills",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildSkillChip("Flutter", Colors.blue),
                        _buildSkillChip("Dart", Colors.teal),
                        _buildSkillChip("JavaScript", Colors.amber[800]!),
                        _buildSkillChip("HTML & CSS", Colors.orange),
                        _buildSkillChip("C++", Colors.cyan),
                        _buildSkillChip("Git", Colors.red),
                        _buildSkillChip("Python", Colors.indigo),
                        _buildSkillChip("MySQL", Colors.blueGrey),
                        _buildSkillChip("Figma", Colors.purple),
                      ],
                    ),
                  ],
                ),
              ),

              // Education Section
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Education",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildEducationCard(
                      icon: Icons.school,
                      institution: "Universitas Pamulang",
                      degree: "S1 Ilmu Komputer",
                      period: "2024 - Sekarang",
                    ),
                    _buildEducationCard(
                      icon: Icons.account_balance,
                      institution: "SMK Media Informatika Jakarta Selatan",
                      degree: "Rekayasa Perangkat Lunak",
                      period: "2021 - 2024",
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
