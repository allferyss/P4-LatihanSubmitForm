import 'package:flutter/material.dart';

class Pertemuan5Page extends StatefulWidget {
  const Pertemuan5Page({super.key});

  @override
  State<Pertemuan5Page> createState() => _Pertemuan5PageState();
}

class _Pertemuan5PageState extends State<Pertemuan5Page> {
  int _selectedDay = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToDay(int index) {
    // Setiap card lebar 72 + margin 10 = 82
    final offset = index * 82.0;
    _scrollController.animateTo(
      offset,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Data hari
  final List<_DayItem> _days = [
    _DayItem(name: "Senin", shortName: "Sen"),
    _DayItem(name: "Selasa", shortName: "Sel"),
    _DayItem(name: "Rabu", shortName: "Rab"),
    _DayItem(name: "Kamis", shortName: "Kam"),
    _DayItem(name: "Jumat", shortName: "Jum"),
    _DayItem(name: "Sabtu", shortName: "Sab"),
  ];

  final Map<int, List<_ScheduleItem>> _schedules = {
    0: [
      // Senin
      _ScheduleItem(
        subject: "Pengelolaan Instalasi Komputer",
        time: "16.00 - 17.40",
        icon: Icons.computer,
        color: Colors.deepPurple,
      ),
    ],
    1: [
      // Selasa
      _ScheduleItem(
        subject: "Komputer Forensik",
        time: "09.20 - 11.00",
        icon: Icons.search,
        color: Colors.red,
      ),
      _ScheduleItem(
        subject: "Rekayasa Perangkat Lunak",
        time: "11.00 - 13.50",
        icon: Icons.engineering,
        color: Colors.brown,
      ),
    ],
    2: [
      // Rabu
      _ScheduleItem(
        subject: "Media Sosial dan Periklanan",
        time: "13.50 - 15.30",
        icon: Icons.campaign,
        color: Colors.pink,
      ),
    ],
    3: [],
    4: [],
    5: [
      // Sabtu
      _ScheduleItem(
        subject: "Pemrograman Berorientasi Objek II",
        time: "07.40 - 09.20",
        icon: Icons.code,
        color: Colors.indigo,
      ),
      _ScheduleItem(
        subject: "Sistem Penunjang Keputusan",
        time: "09.20 - 11.00",
        icon: Icons.analytics,
        color: Colors.teal,
      ),
      _ScheduleItem(
        subject: "Mobile Programming",
        time: "11.00 - 13.50",
        icon: Icons.phone_android,
        color: Colors.blueAccent,
      ),
      _ScheduleItem(
        subject: "Jaringan Komputer",
        time: "13.50 - 15.30",
        icon: Icons.wifi,
        color: Colors.orange,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final todaySchedule = _schedules[_selectedDay] ?? [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Pertemuan 5"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Section Title ===
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
                  SizedBox(width: 8),
                  Text(
                    "Jadwal Mata Kuliah",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Text(
                  "Semester 4 — Informatika",
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ),

              SizedBox(height: 16),

              // === Horizontal ListView: Hari ===
              SizedBox(
                height: 80,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final day = _days[index];
                    final isSelected = _selectedDay == index;
                    final hasSchedule = (_schedules[index] ?? []).isNotEmpty;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDay = index;
                        });
                      },
                      child: Container(
                        width: 72,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blueAccent : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blueAccent
                                : Colors.grey[300]!,
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.blueAccent.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    offset: Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.shortName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: hasSchedule
                                    ? (isSelected
                                          ? Colors.white
                                          : Colors.blueAccent)
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16),

              // === Navigation hari dengan arrow ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _selectedDay > 0
                        ? () {
                            setState(() => _selectedDay--);
                            _scrollToDay(_selectedDay);
                          }
                        : null,
                    icon: Icon(Icons.arrow_back_ios_rounded, size: 20),
                    color: Colors.blueAccent,
                  ),
                  Text(
                    _days[_selectedDay].name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                  IconButton(
                    onPressed: _selectedDay < _days.length - 1
                        ? () {
                            setState(() => _selectedDay++);
                            _scrollToDay(_selectedDay);
                          }
                        : null,
                    icon: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    color: Colors.blueAccent,
                  ),
                ],
              ),

              SizedBox(height: 8),

              // === Vertical ListView: Jadwal ===
              if (todaySchedule.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.event_available,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 12),
                        Text(
                          "Tidak ada jadwal",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todaySchedule.length,
                  itemBuilder: (context, index) {
                    final item = todaySchedule[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Row(
                        children: [
                          // Accent bar kiri
                          Container(
                            width: 5,
                            height: 80,
                            decoration: BoxDecoration(
                              color: item.color,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(14),
                                bottomLeft: Radius.circular(14),
                              ),
                            ),
                          ),
                          SizedBox(width: 14),
                          // Icon
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: item.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(item.icon, color: item.color, size: 24),
                          ),
                          SizedBox(width: 14),
                          // Info
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.subject,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.grey[500],
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        item.time,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

class _DayItem {
  final String name;
  final String shortName;

  _DayItem({required this.name, required this.shortName});
}

class _ScheduleItem {
  final String subject;
  final String time;
  final IconData icon;
  final Color color;

  _ScheduleItem({
    required this.subject,
    required this.time,
    required this.icon,
    required this.color,
  });
}
