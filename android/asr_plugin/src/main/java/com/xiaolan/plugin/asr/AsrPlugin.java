package com.xiaolan.plugin.asr;

import android.Manifest;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * author : zhangbao
 * date : 2020/5/2 4:01 PM
 * description :
 */
public class AsrPlugin implements MethodChannel.MethodCallHandler, FlutterPlugin, ActivityAware {
    private static final String TAG = "AsrPlugin";
    private Activity activity;
    private ResultStateful resultStateful;
    private AsrManager asrManager;

    private AsrPlugin(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), "asr_plugin");
        AsrPlugin instance = new AsrPlugin(registrar.activity());
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall call, @NotNull MethodChannel.Result result) {
        initPermission();
        switch (call.method) {
            case "start":
                resultStateful = ResultStateful.of(result);
                start(call, resultStateful);
                break;
            case "stop":
                stop(call, result);
                break;
            case "cancel":
                cancel(call,result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void start(MethodCall call, ResultStateful resultStateful) {
        if (activity == null) {
            Log.e(TAG, "Ignored start,current activity is null.");
            resultStateful.error("Ignored start,current activity is null.", null, null);
            return;
        }
        if (getAsrManager() != null) {
            getAsrManager().start(call.arguments instanceof Map ? (Map) call.arguments : null);
        } else {
            Log.e(TAG, "Ignored start,current getAsrManager is null.");
            resultStateful.error("Ignored start,current getAsrManager is null.", null, null);
        }
    }

    private void stop(MethodCall call, MethodChannel.Result result) {
        if (asrManager != null) {
            asrManager.stop();
        }
    }

    private void cancel(MethodCall call, MethodChannel.Result result) {
        if (asrManager != null) {
            asrManager.cancel();
        }
    }

    @Nullable
    private AsrManager getAsrManager() {
        if (asrManager == null) {
            if (activity != null && !activity.isFinishing()) {
                asrManager = new AsrManager(activity, onAsrListener);
            }
        }
        return asrManager;
    }

    /**
     * android 6.0 以上需要动态申请权限
     */
    private void initPermission() {
        String permissions[] = {Manifest.permission.RECORD_AUDIO,
                Manifest.permission.ACCESS_NETWORK_STATE,
                Manifest.permission.INTERNET,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };

        ArrayList<String> toApplyList = new ArrayList<String>();

        for (String perm :permissions){
            if (PackageManager.PERMISSION_GRANTED != ContextCompat.checkSelfPermission(activity, perm)) {
                toApplyList.add(perm);
                //进入到这里代表没有权限.

            }
        }
        String tmpList[] = new String[toApplyList.size()];
        if (!toApplyList.isEmpty()){
            ActivityCompat.requestPermissions(activity, toApplyList.toArray(tmpList), 123);
        }

    }

    private OnAsrListener onAsrListener = new OnAsrListener() {
        @Override
        public void onAsrReady() {

        }

        @Override
        public void onAsrBegin() {

        }

        @Override
        public void onAsrEnd() {

        }

        @Override
        public void onAsrPartialResult(String[] results, RecogResult recogResult) {

        }

        @Override
        public void onAsrOnlineNluResult(String nluResult) {

        }

        @Override
        public void onAsrFinalResult(String[] results, RecogResult recogResult) {
            if (resultStateful!= null) {
                resultStateful.success(results[0]);
            }
        }

        @Override
        public void onAsrFinish(RecogResult recogResult) {

        }

        @Override
        public void onAsrFinishError(int errorCode, int subErrorCode, String descMessage, RecogResult recogResult) {
            if (resultStateful!= null) {
                resultStateful.error(descMessage,null,null);
            }
        }

        @Override
        public void onAsrLongFinish() {

        }

        @Override
        public void onAsrVolume(int volumePercent, int volume) {

        }

        @Override
        public void onAsrAudio(byte[] data, int offset, int length) {

        }

        @Override
        public void onAsrExit() {

        }

        @Override
        public void onOfflineLoaded() {

        }

        @Override
        public void onOfflineUnLoaded() {

        }
    };

    @Override
    public void onAttachedToEngine(FlutterPluginBinding binding) {
        Log.e(TAG,"onAttachedToEngine");
//        MethodChannel channel = new MethodChannel(binding.getBinaryMessenger(), "asr_plugin");
//        AsrPlugin instance = new AsrPlugin();
//        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        Log.e(TAG,"onDetachedFromEngine");
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        Log.e(TAG,"onAttachedToActivity");
        this.activity = binding.getActivity();
        initPermission();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Log.e(TAG,"onDetachedFromActivityForConfigChanges");
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        Log.e(TAG,"onReattachedToActivityForConfigChanges");
    }

    @Override
    public void onDetachedFromActivity() {
        Log.e(TAG,"onDetachedFromActivity");
    }
}
