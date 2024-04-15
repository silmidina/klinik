import 'package:flutter/material.dart';
import 'package:klinikkk/helpers/data_pref.dart';
import 'pasien_insert.dart';
import '/widget/sidebar.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  var savedData = [];

  void getSavedData() async {
    var data = await DataPref.getData();
    setState(() {
      savedData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getSavedData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data Pasien"),
        backgroundColor: Colors.orange,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PasienInsert(
                    index: null,
                    value: null,
                  ),
                ),
              ).then(
                (_) {
                  getSavedData();
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: savedData.isEmpty
            ? const Center(
                child: Text("No Data"),
              )
            : ListView.builder(
                itemCount: savedData.length,
                itemBuilder: (ctx, i) => Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 5.0, // Sesuaikan dengan kebutuhan Anda
                    horizontal: 3.0, // Sesuaikan dengan kebutuhan Anda
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(color: Colors.lightGreen),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('${1 + i}'),
                      ),
                      title: Text(savedData[i]['Nama Pasien']!),
                      subtitle: Text(
                        savedData[i]['Nomor RM']! +
                            " / " +
                            savedData[i]['Tanggal Lahir']! +
                            " / " +
                            savedData[i]['Nomor Telepon']! +
                            " / " +
                            savedData[i]['Alamat']!,
                      ),
                      contentPadding: EdgeInsets.all(0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasienInsert(
                              index: i,
                              value: savedData[i],
                            ),
                          ),
                        ).then(
                          (_) => getSavedData(),
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
