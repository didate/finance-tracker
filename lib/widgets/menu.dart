import 'package:finance/colory.dart';
import 'package:finance/page/category.list.dart';
import 'package:finance/page/signin.dart';
import 'package:finance/page/statistics.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key, required this.gravatarUrl});

  String gravatarUrl;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colory.greenLight),
          accountName: const Text("Diallo Mamadou Lamarana"),
          accountEmail: const Text("Lyve.diallo@gmail.com"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(gravatarUrl),
            radius: 30,
          ),
        ),
        ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            leading: const Icon(Icons.category),
            title: const Text("Category"),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Categories()))),
        ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            leading: const Icon(Icons.line_axis),
            title: const Text("Statistics"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Statistics()));
            }),
        const Divider(),
        ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            leading: const Icon(Icons.logout),
            title: const Text("Deconnexion"),
            onTap: () => _disconnect(context))
      ],
    );
  }

  _disconnect(BuildContext context) async {
    await Supabase.instance.client.auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignIn(),
        ),
        (route) => false);
  }
}
