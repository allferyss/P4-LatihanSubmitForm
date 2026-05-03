import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';

class Pertemuan4Page extends StatefulWidget {
  final Function({
    required String name,
    required String jobTitle,
    required String company,
    required String location,
    required String description,
  })
  onProfileSubmit;

  final bool isFromProfile;

  const Pertemuan4Page({
    super.key,
    required this.onProfileSubmit,
    this.isFromProfile = false,
  });

  @override
  State<Pertemuan4Page> createState() => _Pertemuan4PageState();
}

class _Pertemuan4PageState extends State<Pertemuan4Page> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[50],
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
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }

  void _submitForm() {
    SimpleAlertDialog.show(
      context,
      assetImagepath: AnimatedImage.confirm,
      buttonsColor: Colors.green,
      title: AlertTitleText("Konfirmasi submit?"),
      content: AlertContentText("Yakin ingin menambahkan data?"),
      onConfirmButtonPressed: (ctx) {
        final name = _nameController.text.trim();
        final jobTitle = _jobTitleController.text.trim();
        final company = _companyController.text.trim();
        final location = _locationController.text.trim();
        final desc = _descriptionController.text.trim();

        if (name.isNotEmpty && jobTitle.isNotEmpty) {
          widget.onProfileSubmit(
            name: name,
            jobTitle: jobTitle,
            company: company.isNotEmpty ? company : "Google",
            location: location.isNotEmpty ? location : "Jakarta, Indonesia",
            description: desc.isNotEmpty ? desc : "No description provided.",
          );
          CherryToast.success(
            inheritThemeColors: true,
            title: Text("Berhasil menambahkan data!"),
            borderRadius: 16,
          ).show(context);
          _nameController.clear();
          _jobTitleController.clear();
          _companyController.clear();
          _locationController.clear();
          _descriptionController.clear();
        } else {
          CherryToast.error(
            inheritThemeColors: true,
            title: Text("Nama dan pekerjaan harus diisi!"),
            borderRadius: 16,
          ).show(context);
        }
        Navigator.pop(context);
      },
    );
  }

  void _deleteForm() {
    SimpleAlertDialog.show(
      context,
      assetImagepath: AnimatedImage.warning,
      buttonsColor: const Color.fromARGB(255, 175, 76, 76),
      title: AlertTitleText("Konfirmasi Hapus Data"),
      content: AlertContentText("Yakin ingin menghapus data?"),
      onConfirmButtonPressed: (ctx) {
        _nameController.clear();
        _jobTitleController.clear();
        _companyController.clear();
        _locationController.clear();
        _descriptionController.clear();
        CherryToast.success(
          inheritThemeColors: true,
          title: Text("Berhasil menghapus data!"),
          borderRadius: 16,
        ).show(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text(
          widget.isFromProfile
              ? "Menu Profile"
              : "Pertemuan 4 - Toast & Popup Alert Dialog",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // === Card Form ===
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
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
                  // Section Title
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
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Lengkapi data profil anda di bawah ini",
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Form Fields
                  _buildTextField(
                    controller: _nameController,
                    label: "Nama",
                    hint: "Masukkan nama anda...",
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    controller: _jobTitleController,
                    label: "Pekerjaan",
                    hint: "Masukkan data pekerjaan anda...",
                    icon: Icons.work,
                  ),
                  _buildTextField(
                    controller: _companyController,
                    label: "Perusahaan",
                    hint: "Masukkan nama perusahaan anda...",
                    icon: Icons.business,
                  ),
                  _buildTextField(
                    controller: _locationController,
                    label: "Lokasi Perusahaan",
                    hint: "Masukkan lokasi perusahaan anda bekerja...",
                    icon: Icons.location_on,
                  ),
                  _buildTextField(
                    controller: _descriptionController,
                    label: "Deskripsi",
                    hint: "Tentang diri anda...",
                    icon: Icons.description,
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // === Buttons Row ===
            Row(
              children: [
                // Submit
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _submitForm,
                      label: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Delete
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _deleteForm,
                      label: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            if (!widget.isFromProfile) ...[
              SizedBox(height: 12),

              // Show Dialog
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Tutup"),
                          ),
                        ],
                        title: Text("AlertDialog"),
                        contentPadding: EdgeInsets.all(20),
                        content: Text("Ini adalah AlertDialog"),
                      ),
                    );
                  },
                  icon: Icon(Icons.info_outline, size: 20),
                  label: Text(
                    "Show Dialog",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Test Buttons Row
              Row(
                children: [
                  // Test Toast
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          CherryToast.info(
                            inheritThemeColors: true,
                            title: Text(
                              "Ini adalah Toast Message!",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            borderRadius: 16,
                            toastDuration: Duration(seconds: 3),
                          ).show(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "Test Toast",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  // Test Popup
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          SimpleAlertDialog.show(
                            context,
                            assetImagepath: AnimatedImage.info,
                            buttonsColor: Colors.blueAccent,
                            title: AlertTitleText("Test Popup"),
                            content: AlertContentText(
                              "Ini adalah popup dengan animasi.",
                            ),
                            onConfirmButtonPressed: (ctx) {
                              Navigator.pop(context);
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          "Test Popup",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
