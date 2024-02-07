// // Copyright 2020 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'dart:async';
//
// import 'package:reading_flutter/src/plugin/federated_plugin/battery_method_channel.dart';
//
// import 'federated_plugin/federated_plugin_platform_interface.dart';
//
// /// Returns the current battery level of device.
// ///
// /// It uses [FederatedPluginInterface] interface to provide current battery level.
// Future<int> getBatteryLevel() async {
//   return await BatteryMethodChannel.instance.getBatteryLevel();
//   // return await FederatedPluginInterface.instance.getBatteryLevel();
// }



//#总的来说，plugin_platform_interface 提供了一种更高级别的抽象，使得插件的平台接口和实现可以更好地分离，从而提高了代码的可维护性和可测试性。
//#而 MethodChannel 和 invokeMethod() 则是一种更底层的原生交互方式，适用于简单的原生交互场景。
// #（目前项目中只需要简单调用原生代码，没必要抽离出独立的模块，所以在暂不使用。可参考flutter官方demo）