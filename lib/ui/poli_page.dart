import 'package:flutter/material.dart';
import '/model/poli.dart';
import '/service/poli_service.dart';
import '/ui/poli_detail.dart';
import '/ui/poli_form.dart';
import '/ui/poli_item.dart';
import '/widget/sidebar.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({Key? key}) : super(key: key);

  @override
  _PoliPageState createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  Stream<List<Poli>> getList() async* {
    List<Poli>? data = await PoliService().listData();
    yield data!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Poli"),
        backgroundColor: Colors.grey,
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PoliForm()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<Poli>>(
        stream: getList(),
        builder: (context, AsyncSnapshot<List<Poli>> snapshot) {
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
              return PoliItem(poli: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
