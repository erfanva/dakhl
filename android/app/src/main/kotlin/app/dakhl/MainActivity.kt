package app.dakhl

import android.content.ComponentName
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * Bridges the device-level settings that decide whether background SMS
 * delivery works at all.
 *
 * Aggressive OEM power managers (Xiaomi/MIUI above all) refuse to start an
 * app's process for a broadcast unless the user has enabled "autostart".
 * There is no public API to *read* that state, so all the app can do is
 * take the user to the right screen and let them confirm afterwards.
 */
class MainActivity : FlutterActivity() {
    private companion object {
        const val CHANNEL = "app.dakhl/device_setup"

        /**
         * Vendor autostart screens, tried in order. These component names
         * are not public API and shift between ROM versions, hence the
         * fallback chain ending at the app's own details page.
         */
        val AUTOSTART_COMPONENTS = listOf(
            // Xiaomi / Redmi / POCO
            "com.miui.securitycenter" to
                "com.miui.permcenter.autostart.AutoStartManagementActivity",
            // Huawei / Honor
            "com.huawei.systemmanager" to
                "com.huawei.systemmanager.startupmgr.ui.StartupNormalAppListActivity",
            "com.huawei.systemmanager" to
                "com.huawei.systemmanager.optimize.process.ProtectActivity",
            // Oppo / Realme
            "com.coloros.safecenter" to
                "com.coloros.safecenter.permission.startup.StartupAppListActivity",
            "com.coloros.safecenter" to
                "com.coloros.safecenter.startupapp.StartupAppListActivity",
            // Vivo
            "com.vivo.permissionmanager" to
                "com.vivo.permissionmanager.activity.BgStartUpManagerActivity",
            // Letv
            "com.letv.android.letvsafe" to
                "com.letv.android.letvsafe.AutobootManageActivity",
        )
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "manufacturer" -> result.success(Build.MANUFACTURER.lowercase())
                    "openAutostartSettings" -> result.success(openAutostartSettings())
                    "openAppSettings" -> result.success(openAppDetails())
                    else -> result.notImplemented()
                }
            }
    }

    /** True if a vendor screen opened; false if we fell back to app details. */
    private fun openAutostartSettings(): Boolean {
        for ((pkg, activity) in AUTOSTART_COMPONENTS) {
            val intent = Intent().apply {
                component = ComponentName(pkg, activity)
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            }
            // Ask first: resolveActivity tells us whether this ROM has the
            // screen, instead of throwing once per wrong candidate.
            if (packageManager.resolveActivity(intent, 0) == null) continue
            try {
                startActivity(intent)
                return true
            } catch (_: Exception) {
                continue
            }
        }
        openAppDetails()
        return false
    }

    private fun openAppDetails(): Boolean {
        return try {
            startActivity(
                Intent(
                    Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
                    Uri.fromParts("package", packageName, null),
                ).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            )
            true
        } catch (_: Exception) {
            false
        }
    }
}
