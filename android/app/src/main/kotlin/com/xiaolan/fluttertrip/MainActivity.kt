package com.xiaolan.fluttertrip

import android.os.Bundle
import androidx.annotation.NonNull
import com.xiaolan.plugin.asr.AsrPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import org.devio.flutter.splashscreen.SplashScreen

class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        SplashScreen.show(this,true)
        super.onCreate(savedInstanceState)
    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        registerSelfPlugin()
    }

    private fun registerSelfPlugin() {
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine!!)
        AsrPlugin.registerWith(shimPluginRegistry.registrarFor("com.xiaolan.plugin.asr.AsrPlugin"))
    }
}
