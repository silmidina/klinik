import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/pegawai.dart';
import '/ui/pegawai/pegawai_page.dart';
import 'pegawai_detail.dart';
import 'package:klinikkk/service/pegawai_service.dart';

class PegawaiUpdateForm extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiUpdateForm({Key? key, required this.pegawai}) : super(key: key);

  @override
  _PegawaiUpdateFormState createState() => _PegawaiUpdateFormState();
}

class _PegawaiUpdateFormState extends State<PegawaiUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipPegawaiCtrl = TextEditingController();
  final _tgllahirCtrl = TextEditingController();
  final _notelpCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    setState(() {
      _namaPegawaiCtrl.text = data.namaPegawai;
      _nipPegawaiCtrl.text = data.nipPegawai;
      _tgllahirCtrl.text = data.tgllahir;
      _notelpCtrl.text = data.notelp;
      _emailCtrl.text = data.email;
      _selectedDate = DateFormat('yyyy-MM-dd').parse(data.tgllahir);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Pegawai"),
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
                const SizedBox(height: 20),
                _fieldNipPegawai(),
                const SizedBox(height: 20),
                _fieldTglLahir(),
                const SizedBox(height: 20),
                _fieldNoTelp(),
                const SizedBox(height: 20),
                _fieldEmail(),
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _tgllahirCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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
          String id = widget.pegawai.id.toString();
          await PegawaiService().ubah(pegawai, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PegawaiPage(),
              ),
            );
          });
        }
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
