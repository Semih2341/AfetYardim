import 'package:farukhelp/Views/Bagisci/gidaPG.dart';
import 'package:farukhelp/Views/Bagisci/yapilanBagislar.dart';
import 'package:farukhelp/Views/Tedarikci/massages.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciMainPG.dart';
import 'package:farukhelp/anasayfa.dart';
import 'package:flutter/material.dart';

class BagiscimainPG extends StatefulWidget {
  const BagiscimainPG({super.key});

  @override
  State<BagiscimainPG> createState() => _BagiscimainPGState();
}

class _BagiscimainPGState extends State<BagiscimainPG> {
  @override
  void initState() {
    // TODO: implement initState
    userType = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bağışçı Ana Sayfa'),
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
                        builder: (context) => TedarikciSecim(
                          isBagisci: true,
                        ),
                      ),
                    );
                  },
                  buttonText: 'Bağış Listesi Oluştur'),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return YapilanbagislarPG(
                        isBagisci: true,
                      );
                    }));
                  },
                  buttonText: 'Yapılan Bağışlar'),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MassageSelectionPG(
                            owner: 'bagisci',
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
