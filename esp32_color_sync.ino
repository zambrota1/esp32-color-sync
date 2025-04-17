
#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>

BLEServer* pServer = NULL;
BLECharacteristic* pCharacteristic;
bool deviceConnected = false;

#define SERVICE_UUID "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
#define CHARACTERISTIC_UUID "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"

void setup() {
  Serial.begin(115200);
  BLEDevice::init("ESP32-ColorCaster");
  pServer = BLEDevice::createServer();
  BLEService* pService = pServer->createService(SERVICE_UUID);
  pCharacteristic = pService->createCharacteristic(
                     CHARACTERISTIC_UUID,
                     BLECharacteristic::PROPERTY_READ |
                     BLECharacteristic::PROPERTY_NOTIFY
                   );
  pCharacteristic->setValue("RED");  // Start with RED
  pService->start();
  BLEAdvertising* pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->start();
  Serial.println("BLE advertising color...");
}

void loop() {
  delay(5000); // every 5 seconds, change color for demo
  static bool toggle = true;
  if (toggle) {
    pCharacteristic->setValue("BLUE");
  } else {
    pCharacteristic->setValue("RED");
  }
  pCharacteristic->notify();
  toggle = !toggle;
}
