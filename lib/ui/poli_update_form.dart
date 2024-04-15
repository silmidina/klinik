import 'package:flutter/material.dart';
import '../model/poli.dart';
import '../service/poli_service.dart';
import 'poli_page.dart';
import 'poli_detail.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({Key? key, required this.poli}) : super(key: key);

  @override
  _PoliUpdateFormState createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaPoliCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    setState(() {
      _namaPoliCtrl.text = data.namaPoli;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Poli"),
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
                const SizedBox(height: 20),
                _tombolSimpan(),
              ],
            ),
          ),
        ),
      ),
    );
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
          String id = widget.poli.id.toString();
          await PoliService().ubah(poli, id).then((value) {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PoliPage(),
              ),
            );
          });
        }
      },
      child: const Text("Simpan Perubahan"),
    );
  }
}
