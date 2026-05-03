import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kTeal = Color(0xFF00796B);
const kTealLight = Color(0xFFE0F2F1);
const kBg = Color(0xFFF0F4F3);

class Pertemuan7Page extends StatefulWidget {
  const Pertemuan7Page({super.key});
  @override
  State<Pertemuan7Page> createState() => _Pertemuan7PageState();
}

class _Pertemuan7PageState extends State<Pertemuan7Page> {
  final _namaCtrl = TextEditingController();
  final _umurCtrl = TextEditingController();

  String? _jenisKelamin;
  String? _pekerjaan;
  final List<Map<String, dynamic>> _pekerjaanList = [
    {'label': 'Admin', 'icon': Icons.headset_mic},
    {'label': 'Guru', 'icon': Icons.school},
    {'label': 'Programmer', 'icon': Icons.code},
    {'label': 'Pengusaha', 'icon': Icons.store},
    {'label': 'Desainer', 'icon': Icons.design_services},
  ];
  String? _tipePekerjaan;
  final List<Map<String, dynamic>> _tipeList = [
    {
      'label': 'Full Time',
      'desc': 'Bekerja 40 jam/minggu',
      'icon': Icons.work,
      'color': Color(0xFF00796B),
    },
    {
      'label': 'Part Time',
      'desc': 'Bekerja < 40 jam/minggu',
      'icon': Icons.schedule,
      'color': Color(0xFF0288D1),
    },
    {
      'label': 'Freelance',
      'desc': 'Pekerja lepas',
      'icon': Icons.laptop_mac,
      'color': Color(0xFF7B1FA2),
    },
    {
      'label': 'Kontrak',
      'desc': 'Perjanjian waktu tertentu',
      'icon': Icons.description,
      'color': Color(0xFFE64A19),
    },
  ];

  @override
  void dispose() {
    _namaCtrl.dispose();
    _umurCtrl.dispose();
    super.dispose();
  }

  void _simpanData() {
    final nama = _namaCtrl.text.trim();
    final umur = _umurCtrl.text.trim();

    if (nama.isEmpty) {
      _showToast('Nama Lengkap wajib diisi!');
      return;
    }
    if (umur.isEmpty) {
      _showToast('Umur wajib diisi!');
      return;
    }
    if (_jenisKelamin == null) {
      _showToast('Pilih Jenis Kelamin terlebih dahulu!');
      return;
    }
    if (_pekerjaan == null) {
      _showToast('Pilih Pekerjaan terlebih dahulu!');
      return;
    }
    if (_tipePekerjaan == null) {
      _showToast('Pilih Tipe Pekerjaan terlebih dahulu!');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _buildSuccessDialog(nama, umur),
    );
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: kTeal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _reset() {
    setState(() {
      _namaCtrl.clear();
      _umurCtrl.clear();
      _jenisKelamin = null;
      _pekerjaan = null;
      _tipePekerjaan = null;
    });
    _showToast('Data berhasil direset!');
  }

  Widget _buildSuccessDialog(String nama, String umur) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: kTeal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.check, color: Colors.white, size: 28),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Text(
                    'Pendaftaran Berhasil!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 24, color: Colors.grey[200]),
            _dialogRow(Icons.person, 'Nama Lengkap', nama),
            _dialogRow(Icons.cake, 'Umur', '$umur tahun'),
            _dialogRow(Icons.people, 'Jenis Kelamin', _jenisKelamin!),
            _dialogRow(Icons.work, 'Pekerjaan', _pekerjaan!),
            _dialogRow(Icons.badge, 'Tipe Pekerjaan', _tipePekerjaan!),

            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: kTeal,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogRow(IconData icon, String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: kTeal),
          SizedBox(width: 10),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pertemuan 7 - RadioButton',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(Icons.person, 'Data Diri'),
            SizedBox(height: 12),
            _buildTextField(
              controller: _namaCtrl,
              label: 'Nama Lengkap',
              icon: Icons.person_outline,
            ),
            SizedBox(height: 10),
            _buildTextField(
              controller: _umurCtrl,
              label: 'Umur',
              icon: Icons.cake_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 20),

            _sectionHeader(Icons.people, 'Jenis Kelamin'),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildGenderCard(
                    label: 'Laki-laki',
                    icon: Icons.male,
                    value: 'Laki-laki',
                    selectedColor: Colors.blue,
                    gradientColors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildGenderCard(
                    label: 'Perempuan',
                    icon: Icons.female,
                    value: 'Perempuan',
                    selectedColor: Colors.pink,
                    gradientColors: [Color(0xFFF48FB1), Color(0xFFC2185B)],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            _sectionHeader(Icons.work_outline, 'Pekerjaan'),
            SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _pekerjaanList.map((item) {
                final isSelected = _pekerjaan == item['label'];
                return GestureDetector(
                  onTap: () => setState(() => _pekerjaan = item['label']),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? kTeal : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? kTeal : Colors.grey[300]!,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 16,
                          color: isSelected ? Colors.white : kTeal,
                        ),
                        SizedBox(width: 6),
                        Text(
                          item['label'],
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            _sectionHeader(Icons.badge_outlined, 'Tipe Pekerjaan'),
            SizedBox(height: 12),
            Column(
              children: _tipeList.map((item) {
                final isSelected = _tipePekerjaan == item['label'];
                return GestureDetector(
                  onTap: () => setState(() => _tipePekerjaan = item['label']),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? (item['color'] as Color)
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? (item['color'] as Color)
                                  : Colors.grey[400]!,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Container(
                                    width: 11,
                                    height: 11,
                                    decoration: BoxDecoration(
                                      color: item['color'] as Color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['label'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                item['desc'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (item['color'] as Color).withValues(
                              alpha: 0.12,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _simpanData,
                      icon: Icon(Icons.save_alt, size: 18),
                      label: Text(
                        'Simpan Data',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: _reset,
                      icon: Icon(Icons.refresh, size: 18),
                      label: Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kTeal,
                        side: BorderSide(color: kTeal, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: kTeal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kTeal),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: kTeal, width: 2),
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required String label,
    required IconData icon,
    required String value,
    required Color selectedColor,
    required List<Color> gradientColors,
  }) {
    final isSelected = _jenisKelamin == value;
    return GestureDetector(
      onTap: () => setState(() => _jenisKelamin = value),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 62,
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : selectedColor,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
            SizedBox(width: 10),
            // Custom radio circle
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
