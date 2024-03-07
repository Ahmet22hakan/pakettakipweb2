import 'package:PrimeTasche/controller/input_controller.dart';
import 'package:PrimeTasche/controller/language_controller.dart';
import 'package:PrimeTasche/main.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_context/riverpod_context.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Image.asset("assets/images/box.png")),
              Gap(16),
              Text(container.read(languageProvider).isEnglish==null?"Admin Paneli":
                container.read(languageProvider).isEnglish!?
                "Admin Panel":"Administrationsbereich",
                style: GoogleFonts.openSans(color: Colors.blue, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Gap(16),
              Container(
                width: 450,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                child: TextField(
                  controller: context.read(inputProvider).mail,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: Colors.blueAccent,
                        size: 30,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Gap(16),
              Container(
                width: 450,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                child: TextField(
                  onSubmitted: (value)async {
                      await auth.signInWithEmailAndPassword(
                            email: context.read(inputProvider).mail.text,
                            password: context.read(inputProvider).pass.text);
                  },
                  controller: context.read(inputProvider).pass,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.blueAccent,
                        size: 25,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.all(16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 1,
                        ),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Gap(16),
              Container(
                width: 415,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                    onPressed: () async {
                        await auth.signInWithEmailAndPassword(
                            email: context.read(inputProvider).mail.text,
                            password: context.read(inputProvider).pass.text);
                            
                    },
                    child:  SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(
                        child: Text(
                          container.read(languageProvider).isEnglish==null?"Giriş yap":
                         container.read(languageProvider).isEnglish! ? "Log in" : "Einloggen",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
