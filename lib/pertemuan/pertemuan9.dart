import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _kTeal = Color(0xFF00796B);
const _kTealLight = Color(0xFFE0F2F1);
const _kBg = Color(0xFFF0F4F3);

class Pertemuan9Page extends StatefulWidget {
  const Pertemuan9Page({super.key});
  @override
  State<Pertemuan9Page> createState() => _Pertemuan9PageState();
}

class _Pertemuan9PageState extends State<Pertemuan9Page> {
  final _mataKuliahCtrl = TextEditingController();
  final _dosenCtrl = TextEditingController();
  final _ruanganCtrl = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  String? _selectedHari;
  final List<String> _hariList = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  final List<Map<String, dynamic>> _jadwalList = [];

  @override
  void dispose() {
    _mataKuliahCtrl.dispose();
    _dosenCtrl.dispose();
    _ruanganCtrl.dispose();
    super.dispose();
  }

  // ─── Date Picker ───
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1, 12, 31),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: _kTeal,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  // ─── Time Picker ───
  Future<void> _pickTime({required bool isStart}) async {
    final initial =
        (isStart ? _startTime : _endTime) ??
        const TimeOfDay(hour: 8, minute: 0);
    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: _kTeal,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black87,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  String _formatDate(DateTime d) => DateFormat('dd MMM yyyy').format(d);

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  // ─── Simpan Jadwal ───
  void _simpanJadwal() {
    final mk = _mataKuliahCtrl.text.trim();
    final dosen = _dosenCtrl.text.trim();
    final ruangan = _ruanganCtrl.text.trim();

    if (mk.isEmpty) return _showToast('Mata Kuliah wajib diisi!');
    if (dosen.isEmpty) return _showToast('Nama Dosen wajib diisi!');
    if (ruangan.isEmpty) return _showToast('Ruangan wajib diisi!');
    if (_selectedHari == null) return _showToast('Pilih Hari terlebih dahulu!');
    if (_selectedDate == null)
      return _showToast('Pilih Tanggal terlebih dahulu!');
    if (_startTime == null)
      return _showToast('Pilih Jam Mulai terlebih dahulu!');
    if (_endTime == null)
      return _showToast('Pilih Jam Selesai terlebih dahulu!');

    setState(() {
      _jadwalList.insert(0, {
        'mk': mk,
        'dosen': dosen,
        'ruangan': ruangan,
        'hari': _selectedHari,
        'tanggal': _selectedDate,
        'mulai': _startTime,
        'selesai': _endTime,
      });
    });

    _showToast('Jadwal berhasil ditambahkan!');
    _resetForm();
  }

  void _resetForm() {
    setState(() {
      _mataKuliahCtrl.clear();
      _dosenCtrl.clear();
      _ruanganCtrl.clear();
      _selectedHari = null;
      _selectedDate = null;
      _startTime = null;
      _endTime = null;
    });
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: _kTeal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _hapusJadwal(int index) {
    setState(() => _jadwalList.removeAt(index));
    _showToast('Jadwal dihapus!');
  }

  // ════════════════════════════════════════
  // BUILD
  // ════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      appBar: AppBar(
        backgroundColor: _kTeal,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Pertemuan 9 - Date & Time Picker',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Mata Kuliah ──
            _sectionHeader(Icons.book, 'Data Mata Kuliah'),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _mataKuliahCtrl,
              label: 'Mata Kuliah',
              icon: Icons.class_outlined,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _dosenCtrl,
              label: 'Nama Dosen',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: _ruanganCtrl,
              label: 'Ruangan',
              icon: Icons.room_outlined,
            ),
            const SizedBox(height: 20),

            // ── Hari ──
            _sectionHeader(Icons.calendar_view_week, 'Pilih Hari'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _hariList.map((h) {
                final sel = _selectedHari == h;
                return GestureDetector(
                  onTap: () => setState(() => _selectedHari = h),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: sel ? _kTeal : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: sel ? _kTeal : Colors.grey[300]!,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      h,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: sel ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── Date Picker ──
            _sectionHeader(Icons.calendar_today, 'Pilih Tanggal'),
            const SizedBox(height: 12),
            _buildPickerCard(
              icon: Icons.calendar_month,
              label: _selectedDate != null
                  ? _formatDate(_selectedDate!)
                  : 'Belum dipilih',
              hint: 'Ketuk untuk memilih tanggal',
              isSelected: _selectedDate != null,
              onTap: _pickDate,
            ),
            const SizedBox(height: 20),

            // ── Time Picker ──
            _sectionHeader(Icons.access_time, 'Pilih Waktu'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildPickerCard(
                    icon: Icons.play_arrow_rounded,
                    label: _startTime != null
                        ? _formatTime(_startTime!)
                        : '--:--',
                    hint: 'Jam Mulai',
                    isSelected: _startTime != null,
                    onTap: () => _pickTime(isStart: true),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_forward, color: _kTeal, size: 20),
                ),
                Expanded(
                  child: _buildPickerCard(
                    icon: Icons.stop_rounded,
                    label: _endTime != null ? _formatTime(_endTime!) : '--:--',
                    hint: 'Jam Selesai',
                    isSelected: _endTime != null,
                    onTap: () => _pickTime(isStart: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Buttons ──
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: _simpanJadwal,
                      icon: const Icon(Icons.add_circle_outline, size: 18),
                      label: const Text(
                        'Tambah Jadwal',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _kTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: _resetForm,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text(
                        'Reset',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _kTeal,
                        side: const BorderSide(color: _kTeal, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // ── Daftar Jadwal ──
            if (_jadwalList.isNotEmpty) ...[
              _sectionHeader(
                Icons.list_alt,
                'Daftar Jadwal (${_jadwalList.length})',
              ),
              const SizedBox(height: 12),
              ..._jadwalList.asMap().entries.map(
                (e) => _buildJadwalCard(e.key, e.value),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════
  // WIDGETS
  // ════════════════════════════════════════

  Widget _sectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _kTeal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
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
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _kTeal),
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
          borderSide: const BorderSide(color: _kTeal, width: 2),
        ),
      ),
    );
  }

  Widget _buildPickerCard({
    required IconData icon,
    required String label,
    required String hint,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _kTeal : Colors.grey[300]!,
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _kTealLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: _kTeal, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hint,
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.black87 : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildJadwalCard(int index, Map<String, dynamic> data) {
    final tanggal = data['tanggal'] as DateTime;
    final mulai = data['mulai'] as TimeOfDay;
    final selesai = data['selesai'] as TimeOfDay;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00796B), Color(0xFF009688)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.school, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['mk'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data['dosen'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _hapusJadwal(index),
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                splashRadius: 20,
              ),
            ],
          ),
          const Divider(height: 20),
          Row(
            children: [
              _infoChip(
                Icons.calendar_today,
                '${data['hari']}, ${_formatDate(tanggal)}',
              ),
              const SizedBox(width: 8),
              _infoChip(
                Icons.access_time,
                '${_formatTime(mulai)} - ${_formatTime(selesai)}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          _infoChip(Icons.room_outlined, data['ruangan']),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _kTealLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: _kTeal),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF00796B),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
