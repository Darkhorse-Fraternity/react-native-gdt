package com.ineva.gdt;

import android.app.Activity;
import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.qq.e.ads.nativ.NativeUnifiedADData;
import com.qq.e.ads.nativ.widget.NativeAdContainer;

class RNGDTNativeUnifiedADViewManager extends SimpleViewManager {
    public static final String REACT_CLASS = "RNGDTNativeUnifiedADView";
    private NativeAdContainer mContainer;
    @NonNull
    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @NonNull
    @Override
    protected View createViewInstance(@NonNull ThemedReactContext reactContext) {
        View view = LayoutInflater.from(reactContext).inflate(R.layout.activity_native_unified_ad_simple, null);
//        mContainer = view.findViewById(R.id.native_ad_container);
//        return mContainer;
        return  view;
    }

    @ReactProp(name = "index")
    public void setIndex(View view,  int index) {
        if(RNGDTNativeUnifiedADData.getInstance().list.size() >0){
            NativeUnifiedADData data = RNGDTNativeUnifiedADData.getInstance().list.get(index);
        }
        mContainer = view.findViewById(R.id.native_ad_container);
//        view.setSource(sources);
    }

}
