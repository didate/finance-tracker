import 'package:finance/page/category.list.dart';
import 'package:finance/widgets/header.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    List settings = ['Categories', 'Unites'];
    List<IconData> icons = [Icons.category, Icons.ac_unit];
    List actions = [Categories(), Categories()];

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Header(title: "Setting"),
            Positioned(
              top: 120,
              child: setting(settings, icons, actions),
            )
          ],
        )));
  }

  Container setting(
      List<dynamic> settings, List<IconData> icons, List<dynamic> actions) {
    return Container(
      height: 550,
      width: 340,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          ...List.generate(
              settings.length,
              (index) => Material(
                    type: MaterialType.transparency,
                    child: ListTile(
                      title: Text(settings[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => actions[index]));
                      },
                    ),
                  ))
        ],
      ),
    );
  }
}
