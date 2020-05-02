package com.xiaolan.plugin.asr;

import android.util.Log;

import io.flutter.plugin.common.MethodChannel;

/**
 * author : zhangbao
 * date : 2020/5/2 4:36 PM
 * description :
 */
public class ResultStateful implements MethodChannel.Result {
    private static final String TAG = "ResultStateful";
    private MethodChannel.Result result;
    private  boolean called;

    private ResultStateful(MethodChannel.Result result) {
        this.result = result;
    }

    public static ResultStateful of(MethodChannel.Result result) {
        return new ResultStateful(result);
    }
    @Override
    public void success(Object result) {
        if (called) {
            printError();
            return;
        }
        called = true;
        this.result.success(result);
    }

    @Override
    public void error(String errorCode, String errorMessage, Object errorDetails) {
        if (called) {
            printError();
            return;
        }
        called = true;
        this.result.error(errorCode,errorMessage,errorDetails);
    }

    @Override
    public void notImplemented() {
        if (called) {
            printError();
            return;
        }
        called = true;
        this.result.notImplemented();

    }

    private void printError() {
        Log.e(TAG,"error:result called");
    }
}
