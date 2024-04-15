import 'package:klinikkk/ui/pasien_page.dart';
import 'package:flutter/material.dart';
import 'package:klinikkk/ui/pegawai/pegawai_page.dart';
import '../ui/beranda.dart';
import '../ui/login.dart';
import '../ui/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Admin Klinik",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),
            ),
            accountEmail: Text("admin@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/3.png'),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/clinic.jpg'), fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Beranda()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.accessible),
            title: Text("Poli"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PoliPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text("Pegawai"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PegawaiPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box_sharp),
            title: Text("Pasien"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PasienPage())); // Handle the onTap action for "Pasien"
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Keluar"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
