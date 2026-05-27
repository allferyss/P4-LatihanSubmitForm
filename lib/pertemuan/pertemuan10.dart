import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────
//  PERTEMUAN 10 — Halaman Tab Layout Warna
// ─────────────────────────────────────────────

class Pertemuan10Page extends StatefulWidget {
  const Pertemuan10Page({super.key});

  @override
  State<Pertemuan10Page> createState() => _Pertemuan10PageState();
}

class _Pertemuan10PageState extends State<Pertemuan10Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 10 (Tab Layout)'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.color_lens), text: 'Merah'),
            Tab(icon: Icon(Icons.color_lens), text: 'Hijau'),
            Tab(icon: Icon(Icons.color_lens), text: 'Biru'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ColorTabBody(
            colorName: 'Merah (Red)',
            baseColor: Colors.red,
            gradientColors: [
              Color(0xFFFF5252),
              Color(0xFFFF1744),
              Color(0xFFD50000),
            ],
            shades: [
              _ColorShade(
                name: 'Red 100',
                color: Color(0xFFFFEBEE),
                hex: '#FFEBEE',
              ),
              _ColorShade(
                name: 'Red 300',
                color: Color(0xFFE57373),
                hex: '#E57373',
              ),
              _ColorShade(
                name: 'Red 500',
                color: Color(0xFFF44336),
                hex: '#F44336',
              ),
              _ColorShade(
                name: 'Red 700',
                color: Color(0xFFD32F2F),
                hex: '#D32F2F',
              ),
              _ColorShade(
                name: 'Red 900',
                color: Color(0xFFB71C1C),
                hex: '#B71C1C',
              ),
            ],
          ),
          _ColorTabBody(
            colorName: 'Hijau (Green)',
            baseColor: Colors.green,
            gradientColors: [
              Color(0xFF69F0AE),
              Color(0xFF00E676),
              Color(0xFF00C853),
            ],
            shades: [
              _ColorShade(
                name: 'Green 100',
                color: Color(0xFFE8F5E9),
                hex: '#E8F5E9',
              ),
              _ColorShade(
                name: 'Green 300',
                color: Color(0xFF81C784),
                hex: '#81C784',
              ),
              _ColorShade(
                name: 'Green 500',
                color: Color(0xFF4CAF50),
                hex: '#4CAF50',
              ),
              _ColorShade(
                name: 'Green 700',
                color: Color(0xFF388E3C),
                hex: '#388E3C',
              ),
              _ColorShade(
                name: 'Green 900',
                color: Color(0xFF1B5E20),
                hex: '#1B5E20',
              ),
            ],
          ),
          _ColorTabBody(
            colorName: 'Biru (Blue)',
            baseColor: Colors.blue,
            gradientColors: [
              Color(0xFF40C4FF),
              Color(0xFF00B0FF),
              Color(0xFF2979FF),
            ],
            shades: [
              _ColorShade(
                name: 'Blue 100',
                color: Color(0xFFE3F2FD),
                hex: '#E3F2FD',
              ),
              _ColorShade(
                name: 'Blue 300',
                color: Color(0xFF64B5F6),
                hex: '#64B5F6',
              ),
              _ColorShade(
                name: 'Blue 500',
                color: Color(0xFF2196F3),
                hex: '#2196F3',
              ),
              _ColorShade(
                name: 'Blue 700',
                color: Color(0xFF1976D2),
                hex: '#1976D2',
              ),
              _ColorShade(
                name: 'Blue 900',
                color: Color(0xFF0D47A1),
                hex: '#0D47A1',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ColorShade {
  final String name;
  final Color color;
  final String hex;

  const _ColorShade({
    required this.name,
    required this.color,
    required this.hex,
  });
}

class _ColorTabBody extends StatefulWidget {
  final String colorName;
  final Color baseColor;
  final List<Color> gradientColors;
  final List<_ColorShade> shades;

  const _ColorTabBody({
    required this.colorName,
    required this.baseColor,
    required this.gradientColors,
    required this.shades,
  });

  @override
  State<_ColorTabBody> createState() => _ColorTabBodyState();
}

class _ColorTabBodyState extends State<_ColorTabBody> {
  double _brightness = 1.0;

  @override
  Widget build(BuildContext context) {
    final dynamicColor = widget.baseColor.withValues(alpha: _brightness);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Gradasi Cantik
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.baseColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -15,
                  bottom: -15,
                  child: Icon(
                    Icons.palette,
                    size: 130,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.colorName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Temukan kode HEX dan variasi warna pilihan Anda.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Daftar Gradasi Warna
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.baseColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Daftar Gradasi Warna',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.shades.length,
            itemBuilder: (context, index) {
              final shade = widget.shades[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: shade.color,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  title: Text(
                    shade.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    shade.hex,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: shade.hex));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Salin ${shade.hex} ke clipboard'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Eksplorasi Slider Opasitas
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.opacity, color: widget.baseColor, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Eksplorasi Opasitas',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Geser slider untuk melihat perubahan opasitas pada warna dasar.',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.blur_linear, color: Colors.grey, size: 20),
                    Expanded(
                      child: Slider(
                        value: _brightness,
                        min: 0.1,
                        max: 1.0,
                        activeColor: widget.baseColor,
                        onChanged: (val) {
                          setState(() {
                            _brightness = val;
                          });
                        },
                      ),
                    ),
                    const Icon(Icons.opacity, color: Colors.grey, size: 20),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 50),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: dynamicColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: dynamicColor.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Opasitas: ${(_brightness * 100).round()}%',
                      style: TextStyle(
                        color: _brightness > 0.5
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        shadows: _brightness > 0.5
                            ? const [
                                Shadow(
                                  blurRadius: 3.0,
                                  color: Colors.black38,
                                  offset: Offset(1.0, 1.0),
                                ),
                              ]
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
