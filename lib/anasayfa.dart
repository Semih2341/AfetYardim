// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

int userType = 0; //1 tedarikçi, 2 bağışçı, 3 depremzede

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/arka_plan.jpg'), // Eklemek istediğiniz arka plan resminin yolu
            fit: BoxFit
                .cover, // Resmin ekranı kaplaması için BoxFit.cover kullanıldı
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("DOST",
                  style: TextStyle(
                    fontSize: 80,
                  )),
              Center(
                  child: Text(
                "Doğal Afet Ortamından Stok Teknolojisi",
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    userType = 1;
                    Navigator.pushNamed(context, "/logIn");
                  },
                  child: const Text(
                    "Tedarikçi Giriş",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    userType = 2;
                    Navigator.pushNamed(context, "/logIn");
                  },
                  child: const Text(
                    "Bağışçı Giriş",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    userType = 3;
                    Navigator.pushNamed(context, "/logIn");
                  },
                  child: const Text(
                    "Depremzede Giriş",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
