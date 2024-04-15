import 'package:flutter/material.dart';
import '/model/pegawai.dart';
import '/ui/pegawai/pegawai_detail.dart';

class PegawaiItem extends StatelessWidget {
  final Pegawai pegawai;

  const PegawaiItem({Key? key, required this.pegawai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiDetail(pegawai: pegawai),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: const BorderSide(color: Colors.lightGreen),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${pegawai.id}'),
          ),
          title: Text(pegawai.namaPegawai),
          subtitle: Text(
            "${pegawai.nipPegawai} / ${pegawai.tgllahir} / ${pegawai.notelp} / ${pegawai.email}",
          ),
        ),
      ),
    );
  }
}
