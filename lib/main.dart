import 'package:finance/config.dart';
import 'package:finance/page/category.list.dart';
import 'package:finance/page/home.dart';
import 'package:finance/page/signin.dart';
import 'package:finance/page/splash.dart';
import 'package:finance/page/transaction.add.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'colory.dart';

void main() async {
  await Supabase.initialize(
      url: Config.supabaseUrl,
      anonKey: Config.supabaseAnnoKey,
      authFlowType: AuthFlowType.pkce);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colory.greenLight),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const Splash(),
        '/signin': (_) => const SignIn(),
        '/home': (_) => const Home(),
        '/addtransaction': (_) => const Add(),
        '/category': (_) => const Categories(),
      },
    );
  }
}
