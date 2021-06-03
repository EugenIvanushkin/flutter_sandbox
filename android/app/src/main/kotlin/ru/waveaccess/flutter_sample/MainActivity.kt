package com.wa.wavetalks

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

const val ENCRYPT_PIN_REQUEST_CODE = 100
const val DECRYPT_PIN_REQUEST_CODE = 101

class MainActivity: FlutterFragmentActivity() {

    companion object {
        private const val CHANNEL_NAME = "app.channel.shared.data"
    }

    private enum class ChannelMethods(val value: String) {
        IS_FIRST("readIsFirstStart"),
        ENCRYPT_PIN("encryptPin"),
        DECRYPT_PIN("decryptPin"),
        OPEN_SECURITY_SETTINGS("openSecuritySettings")
    }

    private object Keys {
        const val pin = "pin"
        const val resultCode = "resultCode"
    }

    private var isFirstStart: Boolean = true
    private lateinit var resultCallMethod: MethodChannel.Result

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (savedInstanceState != null) isFirstStart = false
    }

}
