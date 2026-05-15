import 'package:flutter/material.dart';

class AutocompletePage extends StatefulWidget {
  const AutocompletePage({super.key});

  @override
  State<AutocompletePage> createState() => _AutocompletePageState();
}

class _AutocompletePageState extends State<AutocompletePage> {
  final _formKey = GlobalKey<FormState>();

  // ── Controllers ──
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHpController = TextEditingController();
  final _alamatController = TextEditingController();

  // ── Autocomplete values ──
  String _selectedUniversitas = '';
  String _selectedProdi = '';
  String _selectedKota = '';

  // ── Spinner / Dropdown values ──
  String? _selectedJenjang;
  String? _selectedSemester;
  String? _selectedTahunAngkatan;
  String? _selectedJenisKelamin;
  String? _selectedAgama;
  String? _selectedJalurMasuk;

  // ══════════════════════════════════════════════
  //  DATA LISTS
  // ══════════════════════════════════════════════

  // Autocomplete: Universitas
  static const List<String> _universitasList = [
    'Universitas Pamulang',
    'Universitas Indonesia',
    'Universitas Gadjah Mada',
    'Universitas Brawijaya',
    'Universitas Diponegoro',
    'Universitas Airlangga',
    'Universitas Padjadjaran',
    'Universitas Hasanuddin',
    'Universitas Sebelas Maret',
    'Universitas Sumatera Utara',
    'Institut Teknologi Bandung',
    'Institut Teknologi Sepuluh Nopember',
    'Universitas Negeri Jakarta',
    'Universitas Pendidikan Indonesia',
    'Universitas Muhammadiyah Jakarta',
    'Universitas Muhammadiyah Yogyakarta',
    'Universitas Bina Nusantara',
    'Universitas Telkom',
    'Universitas Mercu Buana',
    'Universitas Trisakti',
  ];

  // Autocomplete: Program Studi
  static const List<String> _prodiList = [
    'Informatika',
    'Sistem Informasi',
    'Teknik Komputer',
    'Teknik Elektro',
    'Teknik Mesin',
    'Teknik Sipil',
    'Teknik Industri',
    'Teknik Kimia',
    'Manajemen',
    'Akuntansi',
    'Ilmu Komunikasi',
    'Ilmu Hukum',
    'Psikologi',
    'Kedokteran',
    'Farmasi',
    'Arsitektur',
    'Desain Komunikasi Visual',
    'Sastra Inggris',
    'Pendidikan Guru Sekolah Dasar',
    'Matematika',
  ];

  // Autocomplete: Kota
  static const List<String> _kotaList = [
    'Tangerang Selatan',
    'Tangerang',
    'Jakarta Selatan',
    'Jakarta Pusat',
    'Jakarta Barat',
    'Jakarta Timur',
    'Jakarta Utara',
    'Depok',
    'Bogor',
    'Bekasi',
    'Bandung',
    'Semarang',
    'Yogyakarta',
    'Surabaya',
    'Malang',
    'Medan',
    'Makassar',
    'Palembang',
    'Denpasar',
    'Balikpapan',
  ];

  // Spinner: Jenjang
  static const List<String> _jenjangList = [
    'D3 (Diploma)',
    'S1 (Sarjana)',
    'S2 (Magister)',
    'S3 (Doktor)',
  ];

  // Spinner: Semester
  static const List<String> _semesterList = [
    'Semester 1',
    'Semester 2',
    'Semester 3',
    'Semester 4',
    'Semester 5',
    'Semester 6',
    'Semester 7',
    'Semester 8',
  ];

  // Spinner: Tahun Angkatan
  static const List<String> _tahunAngkatanList = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
  ];

  // Spinner: Jenis Kelamin
  static const List<String> _jenisKelaminList = ['Laki-laki', 'Perempuan'];

  // Spinner: Agama
  static const List<String> _agamaList = [
    'Islam',
    'Kristen Protestan',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
  ];

  // Spinner: Jalur Masuk
  static const List<String> _jalurMasukList = [
    'SNBP (Seleksi Nasional Berdasarkan Prestasi)',
    'SNBT (Seleksi Nasional Berdasarkan Tes)',
    'Mandiri',
    'Jalur Prestasi',
    'Jalur Beasiswa',
    'Pindahan',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _emailController.dispose();
    _noHpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  // ══════════════════════════════════════════════
  //  SUBMIT
  // ══════════════════════════════════════════════
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    // Validasi autocomplete manual
    if (_selectedUniversitas.isEmpty) {
      _showSnackBar('Silakan pilih Universitas');
      return;
    }
    if (_selectedProdi.isEmpty) {
      _showSnackBar('Silakan pilih Program Studi');
      return;
    }
    if (_selectedKota.isEmpty) {
      _showSnackBar('Silakan pilih Kota Asal');
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text(
              'Pendaftaran Berhasil',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _dialogRow('Nama', _namaController.text),
              _dialogRow('NIM', _nimController.text),
              _dialogRow('Email', _emailController.text),
              _dialogRow('No. HP', _noHpController.text),
              _dialogRow('Jenis Kelamin', _selectedJenisKelamin ?? '-'),
              _dialogRow('Agama', _selectedAgama ?? '-'),
              Divider(),
              _dialogRow('Universitas', _selectedUniversitas),
              _dialogRow('Program Studi', _selectedProdi),
              _dialogRow('Jenjang', _selectedJenjang ?? '-'),
              _dialogRow('Semester', _selectedSemester ?? '-'),
              _dialogRow('Tahun Angkatan', _selectedTahunAngkatan ?? '-'),
              _dialogRow('Jalur Masuk', _selectedJalurMasuk ?? '-'),
              Divider(),
              _dialogRow('Kota Asal', _selectedKota),
              _dialogRow('Alamat', _alamatController.text),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Tutup')),
        ],
      ),
    );
  }

  Widget _dialogRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 13, color: Colors.black87),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ══════════════════════════════════════════════
  //  BUILD
  // ══════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Form Pendaftaran Mahasiswa',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Header ───
              _buildSectionHeader(
                icon: Icons.person_outline,
                title: 'Data Pribadi',
                color: Colors.blue,
              ),
              SizedBox(height: 12),

              // Nama Lengkap
              _buildTextField(
                controller: _namaController,
                label: 'Nama Lengkap',
                icon: Icons.badge_outlined,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Nama wajib diisi' : null,
              ),
              SizedBox(height: 12),

              // NIM
              _buildTextField(
                controller: _nimController,
                label: 'NIM (Nomor Induk Mahasiswa)',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    v == null || v.isEmpty ? 'NIM wajib diisi' : null,
              ),
              SizedBox(height: 12),

              // Email
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email wajib diisi';
                  if (!v.contains('@')) return 'Format email tidak valid';
                  return null;
                },
              ),
              SizedBox(height: 12),

              // No. HP
              _buildTextField(
                controller: _noHpController,
                label: 'No. HP',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) =>
                    v == null || v.isEmpty ? 'No. HP wajib diisi' : null,
              ),
              SizedBox(height: 12),

              // Spinner: Jenis Kelamin
              _buildDropdown(
                label: 'Jenis Kelamin',
                icon: Icons.wc_outlined,
                value: _selectedJenisKelamin,
                items: _jenisKelaminList,
                onChanged: (v) => setState(() => _selectedJenisKelamin = v),
                validator: (v) => v == null ? 'Pilih jenis kelamin' : null,
              ),
              SizedBox(height: 12),

              // Spinner: Agama
              _buildDropdown(
                label: 'Agama',
                icon: Icons.auto_stories_outlined,
                value: _selectedAgama,
                items: _agamaList,
                onChanged: (v) => setState(() => _selectedAgama = v),
                validator: (v) => v == null ? 'Pilih agama' : null,
              ),
              SizedBox(height: 24),

              // ─── Akademik ───
              _buildSectionHeader(
                icon: Icons.school_outlined,
                title: 'Data Akademik',
                color: Colors.green,
              ),
              SizedBox(height: 12),

              // Autocomplete: Universitas
              _buildAutocomplete(
                label: 'Universitas',
                icon: Icons.account_balance_outlined,
                options: _universitasList,
                onSelected: (v) => setState(() => _selectedUniversitas = v),
              ),
              SizedBox(height: 12),

              // Autocomplete: Program Studi
              _buildAutocomplete(
                label: 'Program Studi',
                icon: Icons.menu_book_outlined,
                options: _prodiList,
                onSelected: (v) => setState(() => _selectedProdi = v),
              ),
              SizedBox(height: 12),

              // Spinner: Jenjang
              _buildDropdown(
                label: 'Jenjang Pendidikan',
                icon: Icons.stairs_outlined,
                value: _selectedJenjang,
                items: _jenjangList,
                onChanged: (v) => setState(() => _selectedJenjang = v),
                validator: (v) => v == null ? 'Pilih jenjang' : null,
              ),
              SizedBox(height: 12),

              // Spinner: Semester
              _buildDropdown(
                label: 'Semester Saat Ini',
                icon: Icons.calendar_month_outlined,
                value: _selectedSemester,
                items: _semesterList,
                onChanged: (v) => setState(() => _selectedSemester = v),
                validator: (v) => v == null ? 'Pilih semester' : null,
              ),
              SizedBox(height: 12),

              // Spinner: Tahun Angkatan
              _buildDropdown(
                label: 'Tahun Angkatan',
                icon: Icons.date_range_outlined,
                value: _selectedTahunAngkatan,
                items: _tahunAngkatanList,
                onChanged: (v) => setState(() => _selectedTahunAngkatan = v),
                validator: (v) => v == null ? 'Pilih tahun angkatan' : null,
              ),
              SizedBox(height: 12),

              // Spinner: Jalur Masuk
              _buildDropdown(
                label: 'Jalur Masuk',
                icon: Icons.route_outlined,
                value: _selectedJalurMasuk,
                items: _jalurMasukList,
                onChanged: (v) => setState(() => _selectedJalurMasuk = v),
                validator: (v) => v == null ? 'Pilih jalur masuk' : null,
              ),
              SizedBox(height: 24),

              // ─── Alamat ───
              _buildSectionHeader(
                icon: Icons.location_on_outlined,
                title: 'Data Alamat',
                color: Colors.orange,
              ),
              SizedBox(height: 12),

              // Autocomplete: Kota Asal
              _buildAutocomplete(
                label: 'Kota Asal',
                icon: Icons.location_city_outlined,
                options: _kotaList,
                onSelected: (v) => setState(() => _selectedKota = v),
              ),
              SizedBox(height: 12),

              // Alamat Lengkap
              _buildTextField(
                controller: _alamatController,
                label: 'Alamat Lengkap',
                icon: Icons.home_outlined,
                maxLines: 3,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Alamat wajib diisi' : null,
              ),
              SizedBox(height: 28),

              // ─── Tombol Submit ───
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: Icon(Icons.send_rounded),
                  label: Text(
                    'Daftar Sekarang',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // ─── Tombol Reset ───
              SizedBox(
                width: double.infinity,
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: _resetForm,
                  icon: Icon(Icons.refresh_rounded),
                  label: Text(
                    'Reset Form',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: BorderSide(color: Colors.redAccent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════
  //  RESET
  // ══════════════════════════════════════════════
  void _resetForm() {
    _formKey.currentState?.reset();
    _namaController.clear();
    _nimController.clear();
    _emailController.clear();
    _noHpController.clear();
    _alamatController.clear();
    setState(() {
      _selectedUniversitas = '';
      _selectedProdi = '';
      _selectedKota = '';
      _selectedJenjang = null;
      _selectedSemester = null;
      _selectedTahunAngkatan = null;
      _selectedJenisKelamin = null;
      _selectedAgama = null;
      _selectedJalurMasuk = null;
    });
    _showSnackBarSuccess('Form berhasil direset');
  }

  void _showSnackBarSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ══════════════════════════════════════════════
  //  REUSABLE WIDGETS
  // ══════════════════════════════════════════════

  /// Section Header
  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Text Field
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  /// Dropdown / Spinner
  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      icon: Icon(
        Icons.arrow_drop_down_circle_outlined,
        color: Colors.blueAccent,
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Autocomplete Field
  Widget _buildAutocomplete({
    required String label,
    required IconData icon,
    required List<String> options,
    required ValueChanged<String> onSelected,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return options.where(
          (option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      onSelected: onSelected,
      fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textController,
          focusNode: focusNode,
          onFieldSubmitted: (_) => onFieldSubmitted(),
          onChanged: (value) {
            // Juga simpan value saat user mengetik manual
            onSelected(value);
          },
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blueAccent),
            suffixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
            hintText: 'Ketik untuk mencari $label...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        );
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: BoxConstraints(maxHeight: 220),
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blueAccent.withValues(alpha: 0.3),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 6),
                shrinkWrap: true,
                itemCount: options.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey.shade200),
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    dense: true,
                    leading: Icon(
                      Icons.arrow_right,
                      color: Colors.blueAccent,
                      size: 20,
                    ),
                    title: Text(option, style: TextStyle(fontSize: 14)),
                    onTap: () => onSelected(option),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
