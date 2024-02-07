// // Copyright 2020 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'package:flutter/services.dart';
//
// import 'federated_plugin_platform_interface.dart';
//
// ///【plugin_platform_interface使用步骤】2、
// ///创建跨平台实现： 接着，为不同的平台分别创建插件的实现类，并继承自接口定义。
// ///实现类应该实现接口定义中的所有方法和属性，以及定义插件的具体逻辑。
//
// /// Implements [FederatedPluginInterface] using [MethodChannel] to fetch
// /// battery level from platform.
// class BatteryMethodChannel extends FederatedPluginInterface {
//   static const MethodChannel _methodChannel = MethodChannel('battery');
//
//   @override
//   Future<int> getBatteryLevel() async {
//     return await _methodChannel.invokeMethod<int>('getBatteryLevel') as int;
//   }
// }


//#总的来说，plugin_platform_interface 提供了一种更高级别的抽象，使得插件的平台接口和实现可以更好地分离，从而提高了代码的可维护性和可测试性。
//#而 MethodChannel 和 invokeMethod() 则是一种更底层的原生交互方式，适用于简单的原生交互场景。
// #（目前项目中只需要简单调用原生代码，没必要抽离出独立的模块，所以在暂不使用。可参考flutter官方demo）