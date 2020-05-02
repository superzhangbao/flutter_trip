package com.xiaolan.fluttertrip

import androidx.annotation.NonNull
import com.xiaolan.plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        registerSelfPlugin()
    }

    private fun registerSelfPlugin() {
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine!!)
        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.xiaolan.plugin.asr.AsrPlugin"))
    }
}
