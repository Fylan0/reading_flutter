import 'package:flutter/services.dart';

Future<int> getBatteryLevel() async {
  MethodChannel methodChannel = const MethodChannel('battery');
  return await methodChannel.invokeMethod<int>('getBatteryLevel') as int;
}
