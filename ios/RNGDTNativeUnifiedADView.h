//
//  RNGDTBanner.h
//  RNGdt
//
//  Created by Steven on 2017/6/14.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
#import "UnifiedNativeAdCustomView.h"

@interface RNGDTNativeUnifiedADView : UnifiedNativeAdCustomView

@property (nonatomic, assign) int index;

//@property (nonatomic, assign) int interval;
//@property (nonatomic, assign) BOOL isGpsOn;
//@property (nonatomic, assign) BOOL isAnimationOn;
//@property (nonatomic, assign) BOOL showCloseBtn;

@property (nonatomic, copy) RCTBubblingEventBlock onViewWillLeaveApplication;
@property (nonatomic, copy) RCTBubblingEventBlock onViewWillClose;
@property (nonatomic, copy) RCTBubblingEventBlock onViewWillExposure;
@property (nonatomic, copy) RCTBubblingEventBlock onClicked;
@property (nonatomic, copy) RCTBubblingEventBlock onViewWillPresentFullScreenModal;
@property (nonatomic, copy) RCTBubblingEventBlock onViewDidPresentFullScreenModal;
@property (nonatomic, copy) RCTBubblingEventBlock onViewWillDismissFullScreenModal;
@property (nonatomic, copy) RCTBubblingEventBlock onViewDidDismissFullScreenModal;

@end
