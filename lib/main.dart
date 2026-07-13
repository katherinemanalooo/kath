import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;

  Future<void> ledLight(bool state) async {
    final response = await http.post(
      Uri.parse("http://192.168.4.1/api/status/"),
      body: {
        "state": state ? "on" : "off",
      },
    );

    debugPrint(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("ESP32 LED Control"),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                    title: const Text("LED NI SIR RONNIE"),
                    trailing: CupertinoSwitch(
                      value: value,
                      onChanged: (led) {
                        setState(() {
                          value = led;
                        });

                        ledLight(led);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}