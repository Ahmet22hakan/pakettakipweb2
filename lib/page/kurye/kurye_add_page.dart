import 'package:PrimeTasche/controller/language_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:PrimeTasche/controller/input_controller.dart';
import 'package:PrimeTasche/controller/kurye_controller.dart';
import 'package:PrimeTasche/main.dart';
import 'package:PrimeTasche/route_provider.dart';
import 'package:riverpod_context/riverpod_context.dart';

var auth = FirebaseAuth.instance;

class KuryeAddPage extends StatelessWidget {
  const KuryeAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(container.read(languageProvider).isEnglish==null?"Kurye ekle":
                  container.read(languageProvider).isEnglish!?
          "Add Courier":
          "Fahrer hinzufügen",
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              child: Column(
          children: [
            Gap(50),
            CircleAvatar(
              radius: MediaQuery.of(context).size.width / 25,
              child: Container(
                  width: MediaQuery.of(context).size.width / 20,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset("assets/images/profil.png")),
            ),
            const Gap(40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              child: TextField(
                controller: context.read(inputProvider).kuryeEkleMail,
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.openSans(),
                    hintText: "Mail",
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 1,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              child: TextField(
                controller: context.read(inputProvider).kuryeEkleism,
                decoration: InputDecoration(
                    hintText: container.read(languageProvider).isEnglish==null?"Ad Soyad":container.read(languageProvider).isEnglish! ?"Name Surname":"Name Nachname",
                    hintStyle: GoogleFonts.openSans(),
                    prefixIcon: const Icon(
                      Icons.label_outline,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 1,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              child: TextField(
                controller: context.read(inputProvider).kuryeEklepass,
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.openSans(),
                    hintText: container.read(languageProvider).isEnglish==null?"Şifre":container.read(languageProvider).isEnglish!? "Password":"Passwort",
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.blueAccent,
                      size: 25,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(16),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 1,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true),
              ),
            ),
            const Gap(32),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                  onPressed: () async {
                    await container.read(kuryeListProvider).register(
                        context.read(inputProvider).kuryeEkleMail.text, context.read(inputProvider).kuryeEklepass.text);
                  },
                  child:  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(container.read(languageProvider).isEnglish==null?"Ekle":
                        container.read(languageProvider).isEnglish!?
                        "Add":"Hinzufügen",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ),
          ],
        ),
       ),
          ],
        ),
      ),
    );
  }
}
