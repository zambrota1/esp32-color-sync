
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ColorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});
  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final flutterReactiveBle = FlutterReactiveBle();
  late DiscoveredDevice device;
  late QualifiedCharacteristic characteristic;
  Color bgColor = Colors.black;

  @override
  void initState() {
    super.initState();
    scanAndConnect();
  }

  void scanAndConnect() {
    flutterReactiveBle.scanForDevices(withServices: [Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E")])
        .listen((d) async {
      if (d.name == "ESP32-ColorCaster") {
        setState(() => device = d);
        flutterReactiveBle.connectToDevice(id: d.id).listen((connectionState) async {
          if (connectionState.connectionState == DeviceConnectionState.connected) {
            characteristic = QualifiedCharacteristic(
              serviceId: Uuid.parse("6E400001-B5A3-F393-E0A9-E50E24DCCA9E"),
              characteristicId: Uuid.parse("6E400003-B5A3-F393-E0A9-E50E24DCCA9E"),
              deviceId: device.id,
            );
            flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
              final color = String.fromCharCodes(data).toUpperCase().trim();
              setState(() {
                if (color == "RED") bgColor = Colors.red;
                else if (color == "BLUE") bgColor = Colors.blue;
                else if (color == "GREEN") bgColor = Colors.green;
              });
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: const Center(
        child: Text(
          "Waiting for Color...",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
