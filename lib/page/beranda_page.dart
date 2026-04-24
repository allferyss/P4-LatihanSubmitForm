import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';

class BerandaPage extends StatefulWidget {
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
  State<BerandaPage> createState() => _BerandaPage();
}

class _BerandaPage extends State<BerandaPage> {
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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2),
          ),
          prefixIcon: Icon(icon),
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
            borderRadius: 0,
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
            borderRadius: 0,
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
      buttonsColor: Colors.green,
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
          borderRadius: 0,
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
        title: Text("Pertemuan 4 dan Pertemuan 5"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),

            // Section Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Form Nama
            _buildTextField(
              controller: _nameController,
              label: "Nama",
              hint: "Masukkan nama anda...",
              icon: Icons.person,
            ),

            // Form Pekerjaan
            _buildTextField(
              controller: _jobTitleController,
              label: "Pekerjaan",
              hint: "Masukkan data pekerjaan anda...",
              icon: Icons.work,
            ),

            // Form Perusahaan
            _buildTextField(
              controller: _companyController,
              label: "Perusahaan",
              hint: "Masukkan nama perusahaan anda...",
              icon: Icons.business,
            ),

            // Form Lokasi
            _buildTextField(
              controller: _locationController,
              label: "Lokasi Perusahaan",
              hint: "Masukkan lokasi perusahaan anda bekerja...",
              icon: Icons.location_on,
            ),

            // Form Deskripsi
            _buildTextField(
              controller: _descriptionController,
              label: "Deskripsi",
              hint: "Tentang diri anda...",
              icon: Icons.description,
              maxLines: 3,
            ),

            SizedBox(height: 10),

            // Buttons Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // Submit
                  Expanded(
                    child: InkWell(
                      onTap: _submitForm,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  // Delete
                  Expanded(
                    child: InkWell(
                      onTap: _deleteForm,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Show Dialog
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
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
                      content: Text("Ini AlertDialog"),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Show Dialog",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
