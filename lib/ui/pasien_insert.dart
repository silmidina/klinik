import 'package:flutter/material.dart';
import '../helpers/data_pref.dart';

class PasienInsert extends StatefulWidget {
  final int? index;
  final Map<String, dynamic>? value;

  const PasienInsert({
    required this.index,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  State<PasienInsert> createState() => _PasienInsertState();
}

class _PasienInsertState extends State<PasienInsert> {
  late int? index;
  late Map<String, dynamic>? value;

  final _namapasienC = TextEditingController();
  final _normC = TextEditingController();
  final _tanggallahirC = TextEditingController();
  final _nomorteleponC = TextEditingController();
  final _alamatC = TextEditingController();

  bool isDataValid() {
    return _namapasienC.text.isNotEmpty &&
        _normC.text.isNotEmpty &&
        _tanggallahirC.text.isNotEmpty &&
        _nomorteleponC.text.isNotEmpty &&
        _alamatC.text.isNotEmpty;
  }

  void getData() {
    if (index != null && value != null) {
      setState(() {
        _namapasienC.text = value!['Nama Pasien'];
        _normC.text = value!['Nomor RM'];
        _tanggallahirC.text = value!['Tanggal Lahir'];
        _nomorteleponC.text = value!['Nomor Telepon'];
        _alamatC.text = value!['Alamat'];
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: currentDate,
    );

    if (pickedDate != null && pickedDate != currentDate) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
      setState(() {
        _tanggallahirC.text = formattedDate;
      });
    }
  }

  void saveData() async {
    if (isDataValid()) {
      var user = {
        'Nama Pasien': _namapasienC.text,
        'Nomor RM': _normC.text,
        'Tanggal Lahir': _tanggallahirC.text,
        'Nomor Telepon': _nomorteleponC.text,
        'Alamat': _alamatC.text,
      };
      var savedData = await DataPref.getData();

      if (index == null) {
        savedData.insert(0, user);
      } else {
        savedData[index!] = user;
      }

      await DataPref.savedData(savedData);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Empty Field"),
          content: const Text("Please fill all fields"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  void deleteData() async {
    var savedData = await DataPref.getData();
    if (index != null) {
      savedData.removeAt(index!);
      await DataPref.savedData(savedData);
      setState(() {
        // Update state jika diperlukan
      });
      Navigator.pop(context);
    }
  }

  Widget getDeleteButton() {
    if (index != null && value != null) {
      return TextButton(
        onPressed: deleteData,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  void initState() {
    super.initState();
    index = widget.index;
    value = widget.value;
    getData();
  }

  @override
  void dispose() {
    _namapasienC.dispose();
    _normC.dispose();
    _tanggallahirC.dispose();
    _nomorteleponC.dispose();
    _alamatC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Insert"),
        backgroundColor: Colors.orange,
        actions: [
          getDeleteButton(),
          TextButton(
            onPressed: () {
              saveData();
            },
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nama Pasien"),
            TextField(
              controller: _namapasienC,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Nomor RM"),
            TextField(
              controller: _normC,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Tanggal Lahir"),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextFormField(
                  controller: _tanggallahirC,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Nomor Telepon"),
            TextField(
              controller: _nomorteleponC,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Alamat"),
            TextField(
              controller: _alamatC,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
