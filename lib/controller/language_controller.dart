import 'package:PrimeTasche/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:PrimeTasche/controller/base_controller.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:riverpod_context/riverpod_context.dart';

class LanguageController extends BaseController {
  bool? isEnglish = true;
  final storage = GetStorage();
  Widget languageWidget = Consumer(
    builder: (context, ref, child) {
      bool? english = ref.watch(languageProvider.select((value) => value.isEnglish));
  if(english==null){
     return GestureDetector(
          onTap: () {
           context.read(languageProvider).changeLanguage(true);
            container.read(languageProvider).storage.write("lang", false);
           
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "TR",
                style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        );
    
  }

      if (english) {
        return GestureDetector(
          onTap: () {
           context.read(languageProvider).changeLanguage(false);
            container.read(languageProvider).storage.write("lang", false);
           
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "EN",
                style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () {
            context.read(languageProvider).changeLanguage(null);
            container.read(languageProvider).storage.write("lang", true);
           
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                "DE",
                style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        );
      }
    },
  );

  void changeLanguage(bool? newLang) {
    isEnglish = newLang;
    notifyListeners();
  }


}

final languageProvider = ChangeNotifierProvider<LanguageController>((_) => LanguageController());
