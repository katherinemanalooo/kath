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
  Future<void> led_light(bool desmer) async{
    String i = "";
    if (desmer) {
      i = "on";
    }
    else{
      i = "off";
    }
    final link = "http://192.168.4.1/api/status/";
    final response = await http.post(
        Uri.parse(link),
        body:
        {
          "state" : i,
        }
    );
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: GlassScaffold(body: SafeArea(child: ListView(children: [
        CupertinoListSection.insetGrouped(
          backgroundColor: CupertinoColors.transparent,
          children: [
            GlassContainer(child: GlassListTile(title: Text('LED NI SIR RONNIE'),
                trailing: GlassSwitch(value: value, onChanged: (led){setState(() {
                  value = led;
                  led_light(value);
                  CupertinoListSection.insetGrouped(
                    backgroundColor: CupertinoColors.transparent,
                    children: [
                      GlassContainer(child: GlassListTile(title: Text('LED NI SIR RONNIE'),
                          trailing: GlassSwitch(value: value, onChanged: (led){setState(() {
                            value = led;
                            led_light(value);
                          });

                          })),
                      )
                    ],);
                });
                })),
            )
          ],)
      ],))),
    );
  }
}
