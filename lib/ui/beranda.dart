import 'package:flutter/material.dart';
import 'package:klinikkk/ui/pegawai/pegawai_page.dart';
import 'package:klinikkk/ui/pasien_page.dart';
import 'package:klinikkk/ui/login.dart';
import 'package:klinikkk/ui/poli_page.dart';
import '../widget/sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class Beranda extends StatelessWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Beranda"),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selamat datang di EliteCare Clinic, kami siap melayani sepenuh hati. Kenyamanan dan kesembuhan Anda merupakan prioritas utama kami.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(25),
              crossAxisCount: 2,
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {},
                    splashColor: Colors.purple,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            size: 70,
                            color: Colors.purpleAccent,
                          ),
                          Text("Beranda", style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PoliPage()),
                      );
                    },
                    splashColor: Colors.purple,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.accessible,
                            size: 70,
                            color: Colors.purpleAccent,
                          ),
                          Text("Poli", style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PegawaiPage()),
                      );
                    },
                    splashColor: Colors.purple,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.people,
                            size: 70,
                            color: Colors.purpleAccent,
                          ),
                          Text("Pegawai", style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PasienPage()),
                      );
                    },
                    splashColor: Colors.purple,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.account_box_sharp,
                            size: 70,
                            color: Colors.purpleAccent,
                          ),
                          Text("Pasien", style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    splashColor: Colors.purple,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.logout_rounded,
                            size: 70,
                            color: Colors.purpleAccent,
                          ),
                          Text("Keluar", style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ], // Missing closing parenthesis here
            ),
          ),
        ],
      ),
    );
  }
}
