package com.fylan.reading_flutter

import com.fylan.reading_flutter.flutter.federated_plugin.FederatedPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // 在 FlutterEngine 中注册你的插件
        flutterEngine.plugins.add(FederatedPlugin())
    }
}
