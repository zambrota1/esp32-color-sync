
# ESP32 BLE Color Sync Project

This project allows smartphones to synchronize their screen color with an ESP32 device using Bluetooth Low Energy (BLE).

## Hardware Requirements
- ESP32 Dev Board
- Bluetooth-enabled smartphones (iOS or Android)
- USB cable for ESP32 power and flashing

## Software Requirements
- Arduino IDE for ESP32 (with BLE libraries)
- Flutter (for iOS and Android development)

## Steps

### 1. Set Up ESP32
- Flash the `esp32_color_sync.ino` code to the ESP32.
- Make sure the ESP32 is broadcasting BLE data.

### 2. Run the Flutter App
- Install the Flutter app on your device.
- The app will automatically connect to the ESP32 and change screen color based on BLE data.

## License
This project is open-source under the MIT license.
