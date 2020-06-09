package com.ineva.gdt;

import android.content.Context;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

import com.qq.e.comm.managers.GDTADManager;
import com.qq.e.comm.managers.setting.GlobalSetting;

public class GTDConfig {

    public static void config(Context context,String APPID) {
        // 通过调用此方法初始化 SDK。如果需要在多个进程拉取广告，每个进程都需要初始化 SDK。
        GDTADManager.getInstance().initWith(context, APPID);

        GlobalSetting.setChannel(9);
        GlobalSetting.setEnableMediationTool(true);
//        try {
//
//
////            String packageName = context.getPackageName();
//            //Get all activity classes in the AndroidManifest.xml
////            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(
////                    packageName, PackageManager.GET_ACTIVITIES | PackageManager.GET_META_DATA);
////            if (packageInfo.activities != null) {
////                for (ActivityInfo activity : packageInfo.activities) {
////                    Bundle metaData = activity.metaData;
////                    if (metaData != null && metaData.containsKey("id")
////                            && metaData.containsKey("content") && metaData.containsKey("action")) {
////                        Log.e("gdt", activity.name);
////                        try {
////                            Class.forName(activity.name);
////                        } catch (ClassNotFoundException e) {
////                            continue;
////                        }
////
////                    }
////                }
////            }
//        } catch (PackageManager.NameNotFoundException e) {
//            e.printStackTrace();
//        }
    }




}
