import 'package:finance/page/signin.dart';
import 'package:finance/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Header(title: "Profil"),
            Positioned(
              top: 150,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: OutlinedButton(
                      onPressed: () async {
                        await _disconnect(context);
                      },
                      child: Text('Sign out'))),
            )
          ],
        ),
      ),
    );
  }

  static _disconnect(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => SignIn()), (route) => false);
  }
}
