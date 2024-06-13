import 'package:farukhelp/Views/Bagisci/gidaPG.dart';
import 'package:farukhelp/Views/Bagisci/yapilanBagislar.dart';
import 'package:farukhelp/Views/Tedarikci/massages.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciMainPG.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciStok.dart';
import 'package:farukhelp/Views/logInPG.dart';
import 'package:farukhelp/anasayfa.dart';
import 'package:flutter/material.dart';

class DepremzedemainPG extends StatefulWidget {
  const DepremzedemainPG({super.key});
  @override
  State<DepremzedemainPG> createState() => _DepremzedemainPGState();
}

class _DepremzedemainPGState extends State<DepremzedemainPG> {
  @override
  void initState() {
    // TODO: implement initState
    userType = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depremzede Ana Sayfa'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 175.0),
        child: Center(
          child: Column(
            children: [
              MyMenuElevetedButton(
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TedarikciSecim(isBagisci: false),
                    ),
                  );
                },
                buttonText: 'İhtiyaç Listesi Oluştur',
              ),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return YapilanbagislarPG(
                        isBagisci: false,
                      );
                    }));
                  },
                  buttonText: 'Tedarikçi İhtiyaç Eşleşme'),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MassageSelectionPG(
                            owner: 'depremzede',
                          );
                        },
                      ),
                    );
                  },
                  buttonText: 'Mesajlar'),
            ],
          ),
        ),
      ),
    );
  }
}
