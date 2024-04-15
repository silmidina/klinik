import 'package:klinikkk/service/pegawai_service.dart';
import 'package:flutter/material.dart';
import '/model/pegawai.dart';
import '/ui/pegawai/pegawai_detail.dart';
import '/ui/pegawai/pegawai_form.dart';
import '/ui/pegawai/pegawai_item.dart';
import '/widget/sidebar.dart';

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({Key? key}) : super(key: key);

  @override
  _PegawaiPageState createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  Stream<List<Pegawai>> getList() async* {
    List<Pegawai>? data = await PegawaiService().listData();
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        backgroundColor: Colors.green,
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PegawaiForm()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<Pegawai>>(
        stream: getList(),
        builder: (context, AsyncSnapshot<List<Pegawai>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return const Text('Data Kosong');
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return PegawaiItem(pegawai: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
