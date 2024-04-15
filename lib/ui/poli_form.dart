import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';
import 'poli_page.dart';
import 'poli_detail.dart';

class PoliForm extends StatefulWidget {
  const PoliForm({Key? key}) : super(key: key);

  @override
  _PoliFormState createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Poli"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _fieldNamaPoli(),
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

  Widget _fieldNamaPoli() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Poli",
        border: OutlineInputBorder(),
      ),
      controller: _namaPoliCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Poli tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Poli poli = Poli(namaPoli: _namaPoliCtrl.text);

          await PoliService().simpan(poli).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PoliPage(),
              ),
            );
          });
        }
      },
      child: const Text("Simpan"),
    );
  }
}
