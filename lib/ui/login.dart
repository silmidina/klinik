import 'package:flutter/material.dart';
import '/ui/beranda.dart';
import '/service/login_service.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            JudulFormLogin(),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: _FormLogin(),
                ),
                Center(child: _LogoAplikasi()),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FormLogin extends StatelessWidget {
  const _FormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.grey[400],
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              label: 'username',
            ),
            InputField(
              label: 'password',
              obscure: true,
            ),
            _TombolLogin()
          ],
        ),
      ),
    );
  }
}

class _TombolLogin extends StatelessWidget {
  const _TombolLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => Beranda()));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('login'),
          )),
    );
  }
}

class InputField extends StatelessWidget {
  final String label;
  final bool obscure;

  const InputField({super.key, this.label = '', this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 0),
                  borderRadius: BorderRadius.circular(8)),
              fillColor: Colors.white,
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 12)),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class _LogoAplikasi extends StatelessWidget {
  const _LogoAplikasi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Image.asset(
        'assets/hospital.png',
        width: 150,
      ),
    );
  }
}

class JudulFormLogin extends StatelessWidget {
  const JudulFormLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Text('LOGIN',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
          textAlign: TextAlign.center),
    ));
  }
}
