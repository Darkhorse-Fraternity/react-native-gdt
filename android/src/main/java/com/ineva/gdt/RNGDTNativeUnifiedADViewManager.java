package com.ineva.gdt;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.net.Uri;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.facebook.common.executors.UiThreadImmediateExecutorService;
import com.facebook.common.references.CloseableReference;
import com.facebook.datasource.DataSource;
import com.facebook.drawee.backends.pipeline.Fresco;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.facebook.drawee.view.SimpleDraweeView;
import com.facebook.imagepipeline.common.ResizeOptions;
import com.facebook.imagepipeline.core.ImagePipeline;
import com.facebook.imagepipeline.datasource.BaseBitmapDataSubscriber;
import com.facebook.imagepipeline.image.CloseableImage;
import com.facebook.imagepipeline.request.ImageRequest;
import com.facebook.imagepipeline.request.ImageRequestBuilder;
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
    private SimpleDraweeView mImagePoster;
    private SimpleDraweeView mImageLogo;
    private TextView mTitle;
    private TextView mDesc;
    private  ThemedReactContext mReactContext;
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
//        mContainer = view.findViewById(R.id.native_ad_container);
//        return mContainer;
        return  view;
    }

    @ReactProp(name = "index")
    public void setIndex(View view,  int index) {
        if(RNGDTNativeUnifiedADData.getInstance().list.size() >0){
            NativeUnifiedADData ad = RNGDTNativeUnifiedADData.getInstance().list.get(index);

//            ad.getIconUrl()
            int patternType = ad.getAdPatternType();
            mContainer = view.findViewById(R.id.native_ad_container);
            mImagePoster = view.findViewById(R.id.img_poster);
            mImageLogo = view.findViewById(R.id.img_logo);
//            mImageLogo.setBackgroundColor(Color.BLACK);
            Uri iconUri=Uri.parse(ad.getIconUrl());
            mImageLogo.setImageURI(iconUri);
            String imageUriString =  ad.getImgUrl();
            if(patternType == AdPatternType.NATIVE_3IMAGE){
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
//            this._getImage(iconUri, null, new ImageCallback() {
//                @Override
//                public void invoke(@Nullable Bitmap bitmap) {
//                    mImageLogo.setImageBitmap(bitmap);
//                }
//            });
//            this._getImage(imageUri, null, new ImageCallback() {
//                @Override
//                public void invoke(@Nullable Bitmap bitmap) {
//                    mImagePoster.setImageBitmap(bitmap);
//                }
//            });
        }


//        view.setSource(sources);
    }

    private void _getImage(Uri uri, ResizeOptions resizeOptions, final ImageCallback imageCallback) {
        BaseBitmapDataSubscriber dataSubscriber = new BaseBitmapDataSubscriber() {
            @Override
            protected void onNewResultImpl(Bitmap bitmap) {
                if (bitmap != null) {
                    if (bitmap.getConfig() != null) {
                        bitmap = bitmap.copy(bitmap.getConfig(), true);
                        imageCallback.invoke(bitmap);
                    } else {
                        bitmap = bitmap.copy(Bitmap.Config.ARGB_8888, true);
                        imageCallback.invoke(bitmap);
                    }
                } else {
                    imageCallback.invoke(null);
                }
            }

            @Override
            protected void onFailureImpl(DataSource<CloseableReference<CloseableImage>> dataSource) {
                imageCallback.invoke(null);
            }
        };

        ImageRequestBuilder builder = ImageRequestBuilder.newBuilderWithSource(uri);
        if (resizeOptions != null) {
            builder = builder.setResizeOptions(resizeOptions);
        }
        ImageRequest imageRequest = builder.build();

        ImagePipeline imagePipeline = Fresco.getImagePipeline();
        DataSource<CloseableReference<CloseableImage>> dataSource = imagePipeline.fetchDecodedImage(imageRequest, null);
        dataSource.subscribe(dataSubscriber, UiThreadImmediateExecutorService.getInstance());
    }

    private interface ImageCallback {
        void invoke(@Nullable Bitmap bitmap);
    }

}
