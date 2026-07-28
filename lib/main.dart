import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';
import 'package:http/http.dart' as http;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LiquidGlassWidgets.initialize();
  runApp(LiquidGlassWidgets.wrap(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool value = false;
  bool clipFan = false;
  Future<void> led_light(bool kath) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.4.1/api/status/"),
        body: {
          "device": "led",
          "state": kath ? "on" : "off",
        },
      );

      print(response.body);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> clip_fan(bool kath) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.4.1/api/status/"),
        body: {
          "device": "fan",
          "state": kath ? "on" : "off",
        },
      );

      if (response.statusCode == 200) {
        print("Clip Fan: ${response.body}");
      } else {
        print("Failed to control Clip Fan. Status Code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("Error controlling Clip Fan: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: const CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: GlassScaffold(
        body: SafeArea(
          child: ListView(
            children: [
              CupertinoListSection.insetGrouped(
                backgroundColor: CupertinoColors.transparent,
                children: [
                  GlassContainer(
                    child: GlassListTile(
                      title: const Text("LED NI SIR RONNIE"),
                      trailing: GlassSwitch(
                        value: value,
                        onChanged: (led) {
                          setState(() {
                            value = led;
                          });
                          led_light(led);
                        },
                      ),
                    ),
                  ),
                  GlassContainer(
                    child: GlassListTile(
                      title: const Text("Clip Fan"),
                      trailing: GlassSwitch(
                        value: clipFan,
                        onChanged: (fan) {
                          setState(() {
                            clipFan = fan;
                          });
                          clip_fan(fan);
                        },
                      ),
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