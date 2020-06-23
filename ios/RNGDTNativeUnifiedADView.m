//
//  RNGDTBanner.m
//  RNGdt
//
//  Created by Steven on 2017/6/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "RNGDTNativeUnifiedADView.h"
#import "GDTUnifiedNativeAd.h"
#import "RNGDTNativeUnifiedAD.h"
@interface RNGDTNativeUnifiedADView() <GDTUnifiedNativeAdViewDelegate>


@end

@implementation RNGDTNativeUnifiedADView


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.adView = [[UnifiedNativeAdCustomView alloc] init];
//        [self addSubview:self.adView];
//    }
//    return self;
//}
//


//- (void)setInterval:(int)interval { self.bannerView.interval = interval; }
//- (int)interval { return self.bannerView.interval; }
//- (void)setIsGpsOn:(BOOL)isGpsOn { self.bannerView.isGpsOn = isGpsOn; }
//- (BOOL)isGpsOn { return self.bannerView.isGpsOn; }
//- (void)setIsAnimationOn:(BOOL)isAnimationOn { self.bannerView.isAnimationOn = isAnimationOn; }
//- (BOOL)isAnimationOn { return self.bannerView.isAnimationOn; }
//- (void)setShowCloseBtn:(BOOL)showCloseBtn { self.bannerView.showCloseBtn = showCloseBtn; }
//- (BOOL)showCloseBtn { return self.bannerView.showCloseBtn; }

#pragma mark - GDTMobBannerViewDelegate

- (void)bannerViewMemoryWarning {
    NSLog(@"bannerViewMemoryWarning");
}

///**
// *  请求广告条数据成功后调用
// *  详解:当接收服务器返回的广告数据成功后调用该函数
// */
//- (void)bannerViewDidReceived {
//    if (self.onReceived) {
//        self.onReceived(nil);
//    }
//}

/**
 *  请求广告条数据失败后调用
 *  详解:当接收服务器返回的广告数据失败后调用该函数
 */
//- (void)bannerViewFailToReceived:(NSError *)error {
//    if (self.onFailToReceived) {
//        self.onFailToReceived(@{@"error": error.localizedDescription});
//    }
//}

/**
 *  应用进入后台时调用
 *  详解:当点击应用下载或者广告调用系统程序打开，应用将被自动切换到后台  111
 */
- (void)gdt_unifiedNativeAdViewApplicationWillEnterBackground:(GDTUnifiedNativeAdView *)unifiedNativeAdView {
    if (self.onViewWillLeaveApplication) {
        self.onViewWillLeaveApplication(nil);
    }
}

/**
 *  banner条被用户关闭时调用
 *  详解:当打开showCloseBtn开关时，用户有可能点击关闭按钮从而把广告条关闭
 */
//- (void)bannerViewWillClose {
//    if (self.onViewWillClose) {
//        self.onViewWillClose(nil);
//    }
//}

/**
 *  广告详情页面即将打开
 */
- (void)gdt_unifiedNativeAdDetailViewWillPresentScreen {
    if (self.onViewWillExposure) {
        self.onViewWillExposure(nil);
    }
}

/**
 *  banner条点击回调
 */
//- (void)bannerViewClicked {
//    if (self.onClicked) {
//        self.onClicked(nil);
//    }
//}

/**
 *  banner广告点击以后即将弹出全屏广告页
 */
- (void)bannerViewWillPresentFullScreenModal {
    if (self.onViewWillPresentFullScreenModal) {
        self.onViewWillPresentFullScreenModal(nil);
    }
}

/**
 *  banner广告点击以后弹出全屏广告页完毕
 */
- (void)bannerViewDidPresentFullScreenModal {
    if (self.onViewDidPresentFullScreenModal) {
        self.onViewDidPresentFullScreenModal(nil);
    }
}

/**
 *  全屏广告页即将被关闭
 */
- (void)bannerViewWillDismissFullScreenModal {
    if (self.onViewWillDismissFullScreenModal) {
        self.onViewWillDismissFullScreenModal(nil);
    }
}

///**
// *  全屏广告页已经被关闭
// */
//- (void)bannerViewDidDismissFullScreenModal {
//    if (self.onViewDidDismissFullScreenModal) {
//        self.onViewDidDismissFullScreenModal(nil);
//    }
//}

- (void)gdt_unifiedNativeAdView:(GDTUnifiedNativeAdView *)unifiedNativeAdView playerStatusChanged:(GDTMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"视频广告状态变更");
    switch (status) {
        case GDTMediaPlayerStatusInitial:
            NSLog(@"视频初始化");
            break;
        case GDTMediaPlayerStatusLoading:
            NSLog(@"视频加载中");
            break;
        case GDTMediaPlayerStatusStarted:
            NSLog(@"视频开始播放");
            break;
        case GDTMediaPlayerStatusPaused:
            NSLog(@"视频暂停");
            break;
        case GDTMediaPlayerStatusStoped:
            NSLog(@"视频停止");
            break;
        case GDTMediaPlayerStatusError:
            NSLog(@"视频播放出错");
        default:
            break;
    }
    if (userInfo) {
        long videoDuration = [userInfo[kGDTUnifiedNativeAdKeyVideoDuration] longValue];
        NSLog(@"视频广告长度为 %ld s", videoDuration);
    }
}

-(void)setIndex:(int)index{
    GDTUnifiedNativeAdDataObject * data = [SingleNativeUnifiedADData shareSingleObjc].dataList[index];
    [self setupWithUnifiedNativeAdObject:data];
}


@end
