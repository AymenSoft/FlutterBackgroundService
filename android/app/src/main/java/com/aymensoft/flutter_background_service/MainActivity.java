package com.aymensoft.flutter_background_service;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private Intent forService;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this.getFlutterEngine());

        forService = new Intent(MainActivity.this,MyService.class);

        new MethodChannel(getFlutterEngine().getDartExecutor(),"com.aymensoft.messages")
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NonNull MethodCall methodCall, @NonNull MethodChannel.Result result) {
                        String method = methodCall.method;
                        switch (method){
                            case "startService":
                                startService();
                                result.success("start_success");
                                break;
                            case "stopService":
                                stopService(forService);
                                result.success("stop_success");
                                break;
                        }
                    }
                });

    }

    private void startService(){
        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O){
            startForegroundService(forService);
        } else {
            startService(forService);
        }
    }

}
