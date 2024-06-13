import 'package:farukhelp/Views/Bagisci/BagisciMainPG.dart';
import 'package:farukhelp/Views/Bagisci/geicic.dart';
import 'package:farukhelp/Views/Depremzede/DepremzedeMainPG.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciMainPG.dart';
import 'package:farukhelp/anasayfa.dart';
import 'package:farukhelp/Views/Tedarikci/depremzedeEslesmePG.dart';
import 'package:farukhelp/firebase_options.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciStok.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Anasayfa(),
      routes: {
        '/logIn': (context) => const logInPG(),
        '/anasayfa': (context) => const Anasayfa(),
        //'/eDevlet': (context) => const Edevletgiris(),
        '/tedarikStok': (context) => const TedarikcistokPG(),
        '/depremzedeIhtiyacList': (context) => const DepremzedeeslesmePG(),
        '/tedarikciMain': (context) => const TedarikcimainPG(),
        '/depremzedeMain': (context) => const DepremzedemainPG(),
        '/bagisciMain': (context) => const BagiscimainPG(),
      },
    );
  }
}
