//
//  RNGDTNativeUnifiedAD.h
//  Base64
//
//  Created by tonyYo on 2020/6/17.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import "GDTUnifiedNativeAd.h"
NS_ASSUME_NONNULL_BEGIN

@interface RNGDTNativeUnifiedAD : NSObject<RCTBridgeModule>

@end

NS_ASSUME_NONNULL_END


@interface SingleNativeUnifiedADData:NSObject

@property (nonatomic, strong) NSArray<GDTUnifiedNativeAdDataObject*> * dataList;
@property (nonatomic, assign) BOOL  loaded;
+ (instancetype)shareSingleObjc;
@end
