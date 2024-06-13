import 'package:farukhelp/Views/Tedarikci/Deneme.dart';
import 'package:farukhelp/Views/Tedarikci/massages.dart';
import 'package:farukhelp/anasayfa.dart';
import 'package:flutter/material.dart';

class TedarikcimainPG extends StatefulWidget {
  const TedarikcimainPG({super.key});

  @override
  State<TedarikcimainPG> createState() => _TedarikcimainPGState();
}

class _TedarikcimainPGState extends State<TedarikcimainPG> {
  @override
  void initState() {
    // TODO: implement initState
    userType = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tedarikçi Ana Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 175.0),
        child: Center(
          child: Column(
            children: [
              MyMenuElevetedButton(
                  function: () {
                    Navigator.pushNamed(context, '/tedarikStok');
                  },
                  buttonText: 'Tedarikçi Stok Bildirimi'),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.pushNamed(context, '/depremzedeIhtiyacList');
                  },
                  buttonText: 'Depremzede İhtiyaç Eşleşme Sayfası'),
              MyMenuElevetedButton(
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MassageSelectionPG(
                            owner: 'tedarikci',
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

class MyElevetedButton extends StatelessWidget {
  final Function function;
  final String buttonText;
  const MyElevetedButton(
      {super.key, required this.function, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.grey[300],
      ),
      onPressed: () {
        //Navigator.pushNamed(context, '/tedarikciDetay');
        //burada tedarikçi stok bildirimine gidecek
        function();
      },
      child: Text(buttonText),
    );
  }
}

class MyMenuElevetedButton extends StatelessWidget {
  final Function function;
  final String buttonText;
  const MyMenuElevetedButton(
      {super.key, required this.function, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(MediaQuery.of(context).size.width, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.grey[300],
          ),
          onPressed: () {
            //Navigator.pushNamed(context, '/tedarikciDetay');
            //burada tedarikçi stok bildirimine gidecek
            function();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 14,
            ),
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
