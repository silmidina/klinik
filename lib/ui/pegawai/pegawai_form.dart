import 'package:klinikkk/service/pegawai_service.dart';
import '/model/pegawai.dart';
import 'package:flutter/material.dart';
import '/ui/pegawai/pegawai_page.dart';
import '../pegawai/pegawai_detail.dart';

class PegawaiForm extends StatefulWidget {
  const PegawaiForm({Key? key}) : super(key: key);

  @override
  _PegawaiFormState createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipPegawaiCtrl = TextEditingController();
  final _tgllahirCtrl = TextEditingController();
  final _notelpCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pegawai"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaPegawai(),
                _verticalSpacing(),
                _fieldNipPegawai(),
                _verticalSpacing(),
                _fieldTglLahir(),
                _verticalSpacing(),
                _fieldNoTelp(),
                _verticalSpacing(),
                _fieldEmail(),
                _verticalSpacing(),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _verticalSpacing() {
    return SizedBox(height: 20);
  }

  Widget _fieldNamaPegawai() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Pegawai",
        border: OutlineInputBorder(),
      ),
      controller: _namaPegawaiCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pegawai tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldNipPegawai() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "NIP Pegawai",
        border: OutlineInputBorder(),
      ),
      controller: _nipPegawaiCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'NIP Pegawai tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldTglLahir() {
    return InkWell(
      onTap: () {
        _selectDate(context);
      },
      child: IgnorePointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: "Tanggal Lahir",
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(),
          ),
          controller: _tgllahirCtrl,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tanggal Lahir tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _fieldNoTelp() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nomor Telepon",
        border: OutlineInputBorder(),
      ),
      controller: _notelpCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _fieldEmail() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      controller: _emailCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Pegawai pegawai = Pegawai(
            namaPegawai: _namaPegawaiCtrl.text,
            nipPegawai: _nipPegawaiCtrl.text,
            tgllahir: _tgllahirCtrl.text,
            notelp: _notelpCtrl.text,
            email: _emailCtrl.text,
          );

          await PegawaiService().simpan(pegawai).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PegawaiPage(),
              ),
            );
          });
        }
      },
      child: const Text("Simpan"),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _tgllahirCtrl.text = _selectedDate!.toLocal().toString().split(' ')[0];
      });
    }
  }
}
