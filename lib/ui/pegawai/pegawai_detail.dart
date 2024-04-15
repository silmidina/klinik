import 'package:klinikkk/model/pegawai.dart';
import 'package:klinikkk/service/pegawai_service.dart';
import 'package:klinikkk/ui/pegawai/pegawai_page.dart';
import 'package:klinikkk/ui/pegawai/pegawai_update_form.dart';
import 'package:klinikkk/ui/poli_update_form.dart';
import 'package:flutter/material.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);

  @override
  _PegawaiDetailState createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  Stream<Pegawai> getData() async* {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pegawai"),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot<Pegawai> snapshot) {
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
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildDetailInfo("Nama Pegawai", snapshot.data!.namaPegawai),
              _buildDetailInfo("NIP Pegawai", snapshot.data!.nipPegawai),
              _buildDetailInfo("Tanggal Lahir", snapshot.data!.tgllahir),
              _buildDetailInfo("Nomor Telepon", snapshot.data!.notelp),
              _buildDetailInfo("Email", snapshot.data!.email),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton("Ubah", Colors.green, () {
                    _navigateToPegawaiUpdateForm(snapshot.data!);
                  }),
                  _buildActionButton("Hapus", Colors.red, () {
                    _showDeleteConfirmationDialog(snapshot.data!);
                  }),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String label, Color color, void Function()? onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(primary: color),
      child: Text(label),
    );
  }

  void _navigateToPegawaiUpdateForm(Pegawai pegawai) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PegawaiUpdateForm(pegawai: pegawai),
      ),
    );
  }

  void _showDeleteConfirmationDialog(Pegawai pegawai) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Yakin ingin menghapus data ini?"),
        actions: [
          _buildActionButton("Ya", Colors.red, () async {
            await PegawaiService().hapus(pegawai).then((value) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PegawaiPage()),
              );
            });
          }),
          _buildActionButton("Tidak", Colors.green, () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
