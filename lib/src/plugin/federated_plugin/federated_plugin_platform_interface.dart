// // Copyright 2020 The Flutter team. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';
//
// import 'battery_method_channel.dart';
//
// ///【plugin_platform_interface使用步骤】1、
// /// 创建接口定义： 首先，在你的插件包中创建一个接口，定义插件应该提供的功能和方法。
// /// 这个接口应该继承自 PlatformInterface 类，以及定义插件的方法和属性。
//
// /// Interface which allows all the platform plugins to implement the same
// /// functionality.
// abstract class FederatedPluginInterface extends PlatformInterface {
//   FederatedPluginInterface() : super(token: _object);
//
//   static FederatedPluginInterface _federatedPluginInterface =
//       BatteryMethodChannel();
//
//   static final Object _object = Object();
//
//   /// Provides instance of [BatteryMethodChannel] to invoke platform calls.
//   static FederatedPluginInterface get instance => _federatedPluginInterface;
//
//   static set instance(FederatedPluginInterface instance) {
//     PlatformInterface.verifyToken(instance, _object);
//     _federatedPluginInterface = instance;
//   }
//
//   /// Returns the current battery level of device.
//   Future<int> getBatteryLevel() async {
//     throw UnimplementedError('getBatteryLevel() has not been implemented.');
//   }
// }


//#总的来说，plugin_platform_interface 提供了一种更高级别的抽象，使得插件的平台接口和实现可以更好地分离，从而提高了代码的可维护性和可测试性。
//#而 MethodChannel 和 invokeMethod() 则是一种更底层的原生交互方式，适用于简单的原生交互场景。
// #（目前项目中只需要简单调用原生代码，没必要抽离出独立的模块，所以在暂不使用。可参考flutter官方demo）