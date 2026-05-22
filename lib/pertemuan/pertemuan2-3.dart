import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  PERTEMUAN 2 & 3 — Halaman Gabungan (Tab)
// ─────────────────────────────────────────────

class Pertemuan23Page extends StatefulWidget {
  const Pertemuan23Page({super.key});

  @override
  State<Pertemuan23Page> createState() => _Pertemuan23PageState();
}

class _Pertemuan23PageState extends State<Pertemuan23Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Pertemuan 2 & 3'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.view_column), text: 'Column & Row'),
            Tab(icon: Icon(Icons.edit_note), text: 'Activity & Button'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_Pertemuan2Body(), _Pertemuan3Body()],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PERTEMUAN 2 — Widget Column & Row
// ─────────────────────────────────────────────

class _Pertemuan2Body extends StatelessWidget {
  const _Pertemuan2Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Contoh Column ──
          _SectionCard(
            title: 'Contoh Column Widget',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBox('Item 1', Colors.redAccent),
                  const SizedBox(height: 12),
                  _buildBox('Item 2', Colors.greenAccent),
                  const SizedBox(height: 12),
                  _buildBox('Item 3', Colors.orangeAccent),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Contoh Row ──
          _SectionCard(
            title: 'Contoh Row Widget',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildBox('A', Colors.purpleAccent, width: 60, height: 60),
                  _buildBox('B', Colors.tealAccent, width: 60, height: 60),
                  _buildBox('C', Colors.cyanAccent, width: 60, height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBox(
    String text,
    Color color, {
    double width = 100,
    double height = 50,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PERTEMUAN 3 — Activity & Button (Form)
// ─────────────────────────────────────────────

class _Pertemuan3Body extends StatefulWidget {
  const _Pertemuan3Body();

  @override
  State<_Pertemuan3Body> createState() => _Pertemuan3BodyState();
}

class _Pertemuan3BodyState extends State<_Pertemuan3Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Data Tersimpan'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama  : ${_namaController.text}'),
                Text('NIM   : ${_nimController.text}'),
                Text('Kelas : ${_kelasController.text}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Tutup'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: _SectionCard(
          title: 'Form Data Mahasiswa',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildField(
                controller: _namaController,
                label: 'Nama',
                hint: 'Masukkan nama anda',
                icon: Icons.person,
                errorMsg: 'Nama tidak boleh kosong',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _nimController,
                label: 'NIM',
                hint: 'Masukkan NIM anda',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                errorMsg: 'NIM tidak boleh kosong',
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _kelasController,
                label: 'Kelas',
                hint: 'Masukkan kelas anda',
                icon: Icons.class_,
                errorMsg: 'Kelas tidak boleh kosong',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Input Data',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required String errorMsg,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return errorMsg;
        return null;
      },
    );
  }
}

// ─────────────────────────────────────────────
//  Shared Widget — Kartu section dengan judul
// ─────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Judul dengan aksen garis biru
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
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
