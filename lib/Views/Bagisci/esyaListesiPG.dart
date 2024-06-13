import 'package:farukhelp/Views/Bagisci/gidaPG.dart';
import 'package:farukhelp/Views/Tedarikci/tedarikciMainPG.dart';
import 'package:flutter/material.dart';

class BagislistesiPG extends StatefulWidget {
  final bool isBagisci;
  final String tedarikciAdi;
  const BagislistesiPG(
      {super.key, required this.tedarikciAdi, required this.isBagisci});

  @override
  State<BagislistesiPG> createState() => _BagislistesiPGState();
}

class _BagislistesiPGState extends State<BagislistesiPG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isBagisci ? 'Bağış Listesi' : 'İhtiyaç Listesi'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            MyMenuElevetedButton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GidaSecim(
                                kategori: 'Giyim ',
                                isBagisci: widget.isBagisci,
                                tedarikciName: widget.tedarikciAdi,
                              )));
                },
                buttonText: 'Giyim'),
            MyMenuElevetedButton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GidaSecim(
                                kategori: 'Gıda ',
                                isBagisci: widget.isBagisci,
                                tedarikciName: widget.tedarikciAdi,
                              )));
                },
                buttonText: 'Gıda'),
            MyMenuElevetedButton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GidaSecim(
                                kategori: 'Hijen ',
                                isBagisci: widget.isBagisci,
                                tedarikciName: widget.tedarikciAdi,
                              )));
                },
                buttonText: 'Hijyen'),
            MyMenuElevetedButton(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GidaSecim(
                                kategori: 'İlk Yardım',
                                isBagisci: widget.isBagisci,
                                tedarikciName: widget.tedarikciAdi,
                              )));
                },
                buttonText: 'İlk Yardım'),
          ],
        ),
      ),
    );
  }
}
