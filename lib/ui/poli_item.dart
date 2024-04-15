import 'package:flutter/material.dart';
import '/model/poli.dart';
import '/ui/poli_detail.dart';

class PoliItem extends StatelessWidget {
  final Poli poli;

  const PoliItem({Key? key, required this.poli}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoliDetail(poli: poli),
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
            child: Text('${poli.id}'),
          ),
          title: Text(poli.namaPoli),
        ),
      ),
    );
  }
}
