import 'package:PrimeTasche/controller/kurye_controller.dart';
import 'package:PrimeTasche/controller/language_controller.dart';
import 'package:PrimeTasche/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:PrimeTasche/controller/connection_controller.dart';
import 'package:PrimeTasche/main.dart';
import 'package:PrimeTasche/route_provider.dart';
import 'package:riverpod_context/riverpod_context.dart';
import 'package:latlong2/latlong.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read(mapProvider).konumuGetir();
      context.read(mapProvider).getMarkers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, snapshot) {
      ref.watch(languageProvider.select((value) => value.isEnglish));
      return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              container.read(languageProvider).languageWidget,
              Text(
                "Mod",
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.blue,
                  )),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 8,
                          margin: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                              onPressed: () {
                                context.read(routeProvider).push("/kuryelist");
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    container.read(languageProvider).isEnglish == null
                                        ? "Kurye listesi"
                                        : container.read(languageProvider).isEnglish!
                                            ? "Courier List"
                                            : "Fahrer List",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 8,
                          margin: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                              onPressed: () {
                                context.read(routeProvider).push("/teslimat");
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    container.read(languageProvider).isEnglish == null
                                        ? "Teslimat listesi"
                                        : container.read(languageProvider).isEnglish!
                                            ? "Delivery List"
                                            : "Zustellung List",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 8,
                          margin: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                              onPressed: () {
                                //context.read(bagListProvider).ver();
                                context.read(routeProvider).push("/baglist");
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    container.read(languageProvider).isEnglish == null
                                        ? "Çanta listesi"
                                        : container.read(languageProvider).isEnglish!
                                            ? "Bag List"
                                            : "Tasche List",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        Container(
                          height: 70,
                          width: MediaQuery.of(context).size.width / 8,
                          margin: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.transparent))),
                              onPressed: () {
                                //context.read(bagListProvider).ver();
                                context.read(routeProvider).push("/qrislem");
                              },
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: Center(
                                  child: Text(
                                    container.read(languageProvider).isEnglish == null
                                        ? "QR ile çanta işlemleri"
                                        : container.read(languageProvider).isEnglish!
                                            ? "Bag transactions with Qr"
                                            : "Taschen-Transaktionen mit Qr",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Expanded(
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(50.047243, 10.2500361),
                          initialZoom: 13,
                          interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.rotate),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.yemekqr.pakettakip',

                            // Other parameters as normal
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              ref.watch(mapProvider.select((value) => value.state));
                              return MarkerLayer(markers: context.read(mapProvider).marker);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        var pin = ref.watch(mapProvider.select((value) => value.pinler));

                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
                          child: pin.length > 0
                              ? Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Consumer(
                                      builder: (context, ref, child) {
                                        var pin = ref.watch(mapProvider.select((value) => value.pinler));
                                        print(pin);
                                        print("hello");
                                        print(pin);
                                        return Container(
                                          child: pin.length > 0
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          container.read(languageProvider).isEnglish == null
                                                              ? "Kurye Adı:"
                                                              : container.read(languageProvider).isEnglish!
                                                                  ? "Courier name: "
                                                                  : "Fahrername:",
                                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          context
                                                              .read(kuryeListProvider)
                                                              .kuryeVer()
                                                              .values
                                                              .where((element) {
                                                                return element["mail"] == pin["lastUser"].toString();
                                                              })
                                                              .toSet()
                                                              .map((e) => e["name"])
                                                              .toString()
                                                              .replaceAll(")", "")
                                                              .replaceAll("(", ""),
                                                          style: GoogleFonts.openSans(color: Colors.blue),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text("QR: ",
                                                            style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
                                                        Text(
                                                          context.read(mapProvider).getKey(),
                                                          style: GoogleFonts.openSans(color: Colors.blue),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          container.read(languageProvider).isEnglish == null
                                                              ? "Teslimat tarihi:"
                                                              : container.read(languageProvider).isEnglish!
                                                                  ? "Delivery date:"
                                                                  : "Liefertermin: ",
                                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                            "${DateTime.fromMillisecondsSinceEpoch(pin["timestamp"]).toString().split(":")[0]}:${DateTime.fromMillisecondsSinceEpoch(pin["timestamp"]).toString().split(":")[1]}",
                                                            style: GoogleFonts.openSans(color: Colors.blue)),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          container.read(languageProvider).isEnglish == null
                                                              ? "Şifre:"
                                                              : container.read(languageProvider).isEnglish!
                                                                  ? "Password: "
                                                                  : "Passwort:",
                                                          style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
                                                        ),
                                                        Text(
                                                          "${pin["pass"]}",
                                                          style: GoogleFonts.openSans(color: Colors.blue),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  container.read(languageProvider).isEnglish == null
                                                      ? "Detaylı bilgi için pinlere dokunun."
                                                      : container.read(languageProvider).isEnglish!
                                                          ? "Tap the pins on the map for details."
                                                          : "Tippen Sie auf die Stecknadeln auf der Karte, um Details zu erfahren.",
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.blue, fontWeight: FontWeight.w500),
                                                ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              : Text(
                                  container.read(languageProvider).isEnglish == null
                                      ? "Detaylı bilgi için pinlere dokunun."
                                      : container.read(languageProvider).isEnglish!
                                          ? "Tap the pins on the map for details."
                                          : "Tippen Sie auf die Stecknadeln auf der Karte, um Details zu erfahren.",
                                  style: GoogleFonts.openSans(color: Colors.blue, fontWeight: FontWeight.w500),
                                ),
                        );
                      },
                    ),
                    Container(
                      height: 5,
                      width: double.infinity,
                      color: Colors.transparent,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class FirebaseAuth {}
