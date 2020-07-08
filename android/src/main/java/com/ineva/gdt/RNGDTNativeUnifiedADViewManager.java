package com.ineva.gdt;

import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;
import androidx.annotation.NonNull;
import com.facebook.drawee.view.SimpleDraweeView;
import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.qq.e.ads.nativ.NativeUnifiedADData;
import com.qq.e.ads.nativ.widget.NativeAdContainer;
import com.qq.e.comm.constants.AdPatternType;
import java.util.ArrayList;
import java.util.List;

class RNGDTNativeUnifiedADViewManager extends SimpleViewManager {
    public static final String REACT_CLASS = "RNGDTNativeUnifiedADView";
    private NativeAdContainer mContainer;
    private RelativeLayout mCustomContainer;
    private SimpleDraweeView mImagePoster;
    private SimpleDraweeView mImageLogo;
    private TextView mTitle;
    private TextView mDesc;
    private ThemedReactContext mReactContext;

    @NonNull
    @Override
    public String getName() {
        return REACT_CLASS;
    }

    @NonNull
    @Override
    protected View createViewInstance(@NonNull ThemedReactContext reactContext) {
        mReactContext = reactContext;
        View view = LayoutInflater.from(reactContext).inflate(R.layout.activity_native_unified_ad_simple, null);
        // mContainer = view.findViewById(R.id.native_ad_container);
        // return mContainer;
        mContainer = view.findViewById(R.id.native_ad_container);
        mImagePoster = view.findViewById(R.id.img_poster);
        mImageLogo = view.findViewById(R.id.img_logo);
        mCustomContainer = view.findViewById(R.id.custom_container);
        int width = getScreenWidth(mReactContext);

        ViewGroup.LayoutParams mImagePosterParams = mImagePoster.getLayoutParams();
        mImagePosterParams.height = (int) (width * 0.65 * 9 / 16);
        mImagePoster.setLayoutParams(mImagePosterParams);

        ViewGroup.LayoutParams Params = mCustomContainer.getLayoutParams();

        Params.width = (int) (width * 0.65);
        mCustomContainer.setLayoutParams(Params);
        return view;
    }

    @ReactProp(name = "index")
    public void setIndex(View view, int index) {
        if (RNGDTNativeUnifiedADData.getInstance().list.size() > 0) {
            NativeUnifiedADData ad = RNGDTNativeUnifiedADData.getInstance().list.get(index);

            // ad.getIconUrl()
            int patternType = ad.getAdPatternType();

            // mImageLogo.setBackgroundColor(Color.BLACK);
            Uri iconUri = Uri.parse(ad.getIconUrl());
            mImageLogo.setImageURI(iconUri);
            String imageUriString = ad.getImgUrl();
            if (patternType == AdPatternType.NATIVE_3IMAGE) {
                imageUriString = ad.getImgList().get(0);
            }

            Uri imageUri = Uri.parse(imageUriString);
            mImagePoster.setImageURI(imageUri);

            mTitle = view.findViewById(R.id.text_title);
            mDesc = view.findViewById(R.id.text_desc);
            mTitle.setText(ad.getTitle());
            mDesc.setText(ad.getDesc());
            List<View> clickableViews = new ArrayList<>();
            clickableViews.add(mImagePoster);
            clickableViews.add(mImageLogo);
            clickableViews.add(mTitle);
            clickableViews.add(mDesc);
            ad.bindAdToView(mReactContext, mContainer, null, clickableViews);
            // this._getImage(iconUri, null, new ImageCallback() {
            // @Override
            // public void invoke(@Nullable Bitmap bitmap) {
            // mImageLogo.setImageBitmap(bitmap);
            // }
            // });
            // this._getImage(imageUri, null, new ImageCallback() {
            // @Override
            // public void invoke(@Nullable Bitmap bitmap) {
            // mImagePoster.setImageBitmap(bitmap);
            // }
            // });
        }

        // view.setSource(sources);
    }

    // private static Display getDisplay(Context context) {
    // WindowManager wm;
    // if (context instanceof Activity) {
    // Activity activity = (Activity) context;
    // wm = activity.getWindowManager();
    // } else {
    // wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
    // }
    // if (wm != null) {
    // return wm.getDefaultDisplay();
    // }
    // return null;
    // }

    private static int getScreenWidth(ThemedReactContext mReactContext) {
        return mReactContext.getCurrentActivity().getResources().getSystem().getDisplayMetrics().widthPixels;
    }

}
