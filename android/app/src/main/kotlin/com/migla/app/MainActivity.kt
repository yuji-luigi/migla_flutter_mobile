package com.migla.app

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.pm.PackageManager
import android.media.AudioAttributes
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL_ID = "high_importance"
    private val METHOD_CHANNEL = "app.native/notifier"
    private val REQ_POST_NOTIFICATIONS = 1001

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Create high-importance channel (with sound/vibration)
        val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,
                "High Importance",
                NotificationManager.IMPORTANCE_HIGH
            ).apply {
                description = "Default channel for important notifications"
                enableVibration(true)
                val soundUri = android.provider.Settings.System.DEFAULT_NOTIFICATION_URI
                val attrs = AudioAttributes.Builder()
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .build()
                setSound(soundUri, attrs)
            }
            nm.createNotificationChannel(channel)
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "showNotification" -> {
                        val title = call.argument<String>("title") ?: ""
                        val body = call.argument<String>("body") ?: ""
                        showLocal(title, body)
                        result.success(null)
                    }
                    "requestPermission" -> {
                        requestPostNotificationsPermission()
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun requestPostNotificationsPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            val granted = ContextCompat.checkSelfPermission(
                this, Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED
            if (!granted) {
                ActivityCompat.requestPermissions(
                    this,
                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                    REQ_POST_NOTIFICATIONS
                )
            }
        }
    }

    private fun showLocal(title: String, body: String) {
        val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        val notification = NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle(title)
            .setContentText(body)
            .setStyle(NotificationCompat.BigTextStyle().bigText(body))
            .setSmallIcon(R.drawable.ic_stat_notify)
            // .setSmallIcon(
            //     resources.getIdentifier("ic_notification", "drawable", packageName)
            //         .takeIf { it != 0 } ?: resources.getIdentifier("ic_launcher", "mipmap", packageName)
            // )
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setAutoCancel(true)
            .build()
        nm.notify((System.currentTimeMillis() % Int.MAX_VALUE).toInt(), notification)
    }
}