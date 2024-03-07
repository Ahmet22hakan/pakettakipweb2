import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:PrimeTasche/controller/base_controller.dart';
import 'package:PrimeTasche/main.dart';
import 'package:PrimeTasche/route_provider.dart';

class InputController extends BaseController {
  void popPageWithAction() {
    final connectedRef = FirebaseDatabase.instance.ref(".info/connected");
    connectedRef.onValue.listen((event) {
      final connected = event.snapshot.value as bool;
      if (connected) {
        debugPrint("Connected.");
     
      } else {
        debugPrint("Not connected.");
        
      }
    });
  }
}

final utilsProvider = ChangeNotifierProvider<InputController>((_) => InputController());
