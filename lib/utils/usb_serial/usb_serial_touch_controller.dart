import 'dart:async';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart' as serial;
import 'package:flutter/services.dart';

class UsbSerialController extends GetxController {
  Rx<UsbPort?> port = Rx<UsbPort?>(null);
  RxString status = "Idle".obs;
  RxList<Widget> ports = <Widget>[].obs;
  RxList<Widget> serialData = <Widget>[].obs;

  StreamSubscription<Uint8List>? _subscription;

  Transaction<String>? _transaction;

  UsbDevice? _device;
  List<int> _buffer = [];

  final MethodChannel _channel = const MethodChannel('touch_events');

  TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      getPorts();
    });
    getPorts();
  }

  Future<bool> connectTo(UsbDevice? device) async {
    serialData.clear();
    _subscription?.cancel();
    _subscription = null;
    _transaction?.dispose();
    _transaction = null;
    port.value?.close();
    port.value = null;

    if (device == null) {
      _device = null;
      status.value = "Disconnected";
      return true;
    }

    port.value = await device.create();

    if (!(await port.value!.open())) {
      status.value = "Failed to open port";
      return false;
    }
    _device = device;

    await port.value!.setDTR(true);
    await port.value!.setRTS(true);

    await port.value!.setPortParameters(
      9600,
      serial.UsbPort.DATABITS_8,
      serial.UsbPort.STOPBITS_1,
      serial.UsbPort.PARITY_NONE,
    );

    _subscription = port.value!.inputStream?.listen((data) {
      _buffer.addAll(data as Iterable<int>);
      if (_buffer.length >= 20) {
        String receivedData = String.fromCharCodes(_buffer).trim();
        processTouchData(receivedData); // Process when we have enough data
        _buffer.clear();
      }
    });

    status.value = "Connected";
    return true;
  }

  void processTouchData(String receivedData) {
    print("✅ Full Message: $receivedData"); // Debugging log

    String cleanData = receivedData.replaceAll(RegExp(r'[^0-9A-Fa-f]'), '');
    // Convert Hex to Decimal if needed
    try {
      if (cleanData.length >= 8) {
        int xCoord = int.parse(cleanData.substring(0, 4),
            radix: 16); // Convert Hex to Decimal
        int yCoord = int.parse(cleanData.substring(4, 8), radix: 16);
        sendTouchEvent((xCoord * 2.1).ceil(), (yCoord * 1.5).ceil());
        print(" X: ${(xCoord * 2.1).ceil()}, Y: ${(yCoord * 1.5).ceil()}");
      }
    } catch (e) {
      print(e);
    }
  }

  void sendTouchEvent(int x, int y) async {
    try {
      await _channel.invokeMethod('simulateTouch', {"x": x, "y": y});
    } catch (e) {
      print("Error sending touch event: $e");
    }
  }

  void getPorts() async {
    ports.clear();
    List<UsbDevice> devices = await UsbSerial.listDevices();

    if (!devices.contains(_device)) {
      connectTo(null);
    }

    for (var device in devices) {
      if (device.productName == 'USB-Serial Controller D') {
        Future.delayed(const Duration(seconds: 2), () {
          print('-------------------------------------');
          print(device);
          connectTo(device);
        });
      }
    }
  }
}
