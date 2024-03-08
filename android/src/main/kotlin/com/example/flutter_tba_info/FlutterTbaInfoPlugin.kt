package com.example.flutter_tba_info

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Build.VERSION_CODES.P
import android.telephony.TelephonyManager
import android.util.Log
import android.webkit.WebSettings
import androidx.annotation.NonNull
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import org.json.JSONObject

/** FlutterTbaInfoPlugin */
class FlutterTbaInfoPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var mApplicationContext:Context
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_tba_info")
    channel.setMethodCallHandler(this)
    mApplicationContext=flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when(call.method){
      "getDistinctId"->result.success(getDistinctId(mApplicationContext))
      "getScreenRes"->result.success(getScreenRes(mApplicationContext))
      "getNetworkType"->result.success(getNetworkType(mApplicationContext))
      "getZoneOffset"->result.success(getZoneOffset())
      "getGaid"->GlobalScope.launch { result.success(getGaid(mApplicationContext)) }
      "getAppVersion"->result.success(getAppVersion(mApplicationContext))
      "getOsVersion"->result.success(getOsVersion())
      "getLogId"->result.success(getLogId())
      "getBrand"->result.success(getBrand())
      "getBundleId"-> result.success(getBundleId(mApplicationContext))
      "getManufacturer"-> result.success(getManufacturer())
      "getDeviceModel"-> result.success(getDeviceModel())
      "getAndroidId"-> result.success(getAndroidId(mApplicationContext))
      "getSystemLanguage"-> result.success(getSystemLanguage())
      "getOsCountry"-> result.success(getOsCountry())
      "getOperator"-> result.success(getOperator(mApplicationContext))
      "getDefaultUserAgent"->result.success( WebSettings.getDefaultUserAgent(mApplicationContext))
      "jumpToEmail"->{
        call.arguments?.let {
          runCatching {
            val intent = Intent(Intent.ACTION_SENDTO)
            intent.data= Uri.parse("mailto:")
            intent.flags=Intent.FLAG_ACTIVITY_NEW_TASK
            intent.putExtra(Intent.EXTRA_EMAIL,JSONObject(it.toString()).optString("address"))
            mApplicationContext.startActivity(intent)
          }
        }
      }
      "getBuild"->result.success("build/${Build.VERSION.RELEASE}")
      "connectReferrer"->connectReferrer()
    }
  }

  private fun connectReferrer(){
    val referrerClient = InstallReferrerClient.newBuilder(mApplicationContext).build()
    referrerClient.startConnection(object : InstallReferrerStateListener {
      override fun onInstallReferrerSetupFinished(responseCode: Int) {
        runCatching {
          when (responseCode) {
            InstallReferrerClient.InstallReferrerResponse.OK -> {
              checkReferrerResult(referrerClient.installReferrer)
            }
            else->{
              checkReferrerResult(null)
            }
          }
        }
        runCatching {
          referrerClient.endConnection()
        }
      }
      override fun onInstallReferrerServiceDisconnected() {
      }
    })
  }


  private fun checkReferrerResult(installReferrer: ReferrerDetails?) {
    if (null==installReferrer){
      channel.invokeMethod("connectReferrerFail", hashMapOf<String,Any?>())
      return
    }
    channel.invokeMethod("connectReferrerSuccess", hashMapOf<String,Any?>().apply {
      put("build","build/${Build.VERSION.RELEASE}")
      put("referrer_url",installReferrer.installReferrer)
      put("install_version",installReferrer.installVersion)
      put("referrer_click_timestamp_seconds",installReferrer.referrerClickTimestampSeconds)
      put("install_begin_timestamp_seconds",installReferrer.installBeginTimestampSeconds)
      put("referrer_click_timestamp_server_seconds",installReferrer.referrerClickTimestampServerSeconds)
      put("install_begin_timestamp_server_seconds",installReferrer.installBeginTimestampServerSeconds)
      put("install_first_seconds",getFirstInstallTime())
      put("last_update_seconds",getLastUpdateTime())
      put("google_play_instant",installReferrer.googlePlayInstantParam)
    })
  }

  private fun getFirstInstallTime():Long{
    try {
      val packageInfo = mApplicationContext.packageManager.getPackageInfo(mApplicationContext.packageName, 0)
      return packageInfo.firstInstallTime
    }catch (e:Exception){

    }
    return System.currentTimeMillis()
  }

  private fun getLastUpdateTime():Long{
    try {
      val packageInfo = mApplicationContext.packageManager.getPackageInfo(mApplicationContext.packageName, 0)
      return packageInfo.lastUpdateTime
    }catch (e:Exception){

    }
    return System.currentTimeMillis()
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
