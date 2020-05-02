package com.xiaolan.fluttertrip

import androidx.annotation.NonNull
import com.xiaolan.plugin.asr.AsrPlugin
import io.flutter.app.FlutterPluginRegistry
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val flutterPluginRegistry = FlutterPluginRegistry(FlutterEngine(this), this)
        registerSelfPlugin(flutterPluginRegistry)
    }

    private fun registerSelfPlugin(flutterPluginRegistry: FlutterPluginRegistry) {
        AsrPlugin.registerWith(flutterPluginRegistry.registrarFor("com.xiaolan.plugin.asr.AsrPlugin"))
    }
}
