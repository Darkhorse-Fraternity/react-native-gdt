package com.ineva.gdt;

import com.qq.e.ads.nativ.NativeUnifiedADData;

import java.util.List;

class RNGDTNativeUnifiedADData {
    private static final RNGDTNativeUnifiedADData ourInstance = new RNGDTNativeUnifiedADData();

    public List<NativeUnifiedADData> list;

    static RNGDTNativeUnifiedADData getInstance() {
        return ourInstance;
    }

    private RNGDTNativeUnifiedADData() {
    }
}
