import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';

class Pertemuan6Page extends StatefulWidget {
  const Pertemuan6Page({super.key});

  @override
  State<Pertemuan6Page> createState() => _Pertemuan6PageState();
}

class _Pertemuan6PageState extends State<Pertemuan6Page> {
  final Map<String, bool?> _hobi = {
    'Membaca': false,
    'Olahraga': false,
    'Musik': false,
    'Game': false,
    'Traveling': false,
  };

  // Checkbox syarat & ketentuan (hanya false/true)
  bool _setujuSyarat = false;

  // Keterangan warna checkbox
  Color _statusColor(bool? value) {
    if (value == null) return Colors.orange;
    return value ? Colors.green : Colors.red;
  }

  void _submitForm() {
    final selectedHobi = _hobi.entries
        .where((e) => e.value == true)
        .map((e) => e.key)
        .toList();

    if (selectedHobi.isEmpty) {
      CherryToast.warning(
        inheritThemeColors: true,
        title: Text("Pilih minimal 1 hobi!"),
        borderRadius: 16,
      ).show(context);
      return;
    }

    if (_setujuSyarat != true) {
      CherryToast.warning(
        inheritThemeColors: true,
        title: Text("Anda harus menyetujui syarat & ketentuan!"),
        borderRadius: 16,
      ).show(context);
      return;
    }

    SimpleAlertDialog.show(
      context,
      assetImagepath: AnimatedImage.confirm,
      buttonsColor: Colors.green,
      title: AlertTitleText("Konfirmasi Submit?"),
      content: AlertContentText("Yakin ingin mensubmit data hobi?"),
      onConfirmButtonPressed: (ctx) {
        CherryToast.success(
          inheritThemeColors: true,
          title: Text("Berhasil mendaftar!"),
          description: Text("Hobi: ${selectedHobi.join(', ')}"),
          borderRadius: 16,
        ).show(context);
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
      content: AlertContentText("Yakin ingin menghapus semua pilihan?"),
      onConfirmButtonPressed: (ctx) {
        setState(() {
          _hobi.updateAll((key, value) => false);
          _setujuSyarat = false;
        });
        CherryToast.success(
          inheritThemeColors: true,
          title: Text("Berhasil menghapus semua pilihan!"),
          borderRadius: 16,
        ).show(context);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hobiKeys = _hobi.keys.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text("Pertemuan 6 - CheckboxButton"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: Offset(0, 4),
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
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Hobi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "(Pilih minimal 1)",
                        style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),

                  // Keterangan warna checkbox
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        _buildLegendDot(Colors.red, "False"),
                        SizedBox(width: 12),
                        _buildLegendDot(Colors.orange, "Null/Netral"),
                        SizedBox(width: 12),
                        _buildLegendDot(Colors.green, "True"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: hobiKeys.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3.5,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0,
                    ),
                    itemBuilder: (context, index) {
                      final key = hobiKeys[index];
                      final value = _hobi[key];
                      return _buildTristateCheckbox(
                        label: key,
                        value: value,
                        onChanged: (newVal) {
                          setState(() {
                            _hobi[key] = newVal;
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _setujuSyarat,
                    onChanged: (val) {
                      setState(() {
                        _setujuSyarat = val ?? false;
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    side: BorderSide(
                      color: _setujuSyarat ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Saya menyetujui syarat dan ketentuan yang berlaku",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // === Tombol Submit & Delete ===
            Row(
              children: [
                // Submit
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Delete
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _deleteForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget checkbox tristate
  Widget _buildTristateCheckbox({
    required String label,
    required bool? value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          tristate: true,
          value: value,
          onChanged: onChanged,
          activeColor: _statusColor(value),
          checkColor: Colors.white,
          side: BorderSide(color: _statusColor(value), width: 2),
        ),
        Flexible(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  // Widget legend dot
  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
