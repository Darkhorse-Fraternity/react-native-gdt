package com.ineva.gdt;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.qq.e.ads.nativ.NativeADUnifiedListener;
import com.qq.e.ads.nativ.NativeUnifiedAD;
import com.qq.e.ads.nativ.NativeUnifiedADData;
import com.qq.e.comm.util.AdError;

import java.util.List;

class RNGDTNativeUnifiedADModule extends ReactContextBaseJavaModule implements NativeADUnifiedListener {
    private static ReactApplicationContext reactContext;
    private NativeUnifiedAD mAdManager;
    private  Promise mPromise;
    @Override
    public String getName() {
        return "RNGDTNativeUnifiedAD";
    }

    public RNGDTNativeUnifiedADModule(ReactApplicationContext context) {
        super(reactContext);
        reactContext = context;
    }

    @ReactMethod
    public void loadWithObjectInfo(ReadableMap info, Promise promise) {

        if(mAdManager == null){
            mAdManager = new NativeUnifiedAD(reactContext, info.getString("placementId"), this);
            mPromise = promise;
            mAdManager.loadData(100);
        }else {
          if(RNGDTNativeUnifiedADData.getInstance().list != null) {
            promise.resolve(RNGDTNativeUnifiedADData.getInstance().list.size());
          }else {
            promise.resolve(0);
          }
        }
    }

    @Override
    public void onADLoaded(List<NativeUnifiedADData> list) {
        if(mPromise != null){
            mPromise.resolve(list.size());
            mPromise = null;
            RNGDTNativeUnifiedADData.getInstance().list = list;
        }
    }

    @Override
    public void onNoAD(AdError adError) {
        if(mPromise != null){
            mPromise.reject("0","广告加载失败");
            mPromise = null;
        }
    }
}
