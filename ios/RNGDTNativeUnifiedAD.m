//
//  RNGDTNativeUnifiedAD.m
//  Base64
//
//  Created by tonyYo on 2020/6/17.
//

#import "RNGDTNativeUnifiedAD.h"
#import <objc/runtime.h>


@implementation SingleNativeUnifiedADData

static SingleNativeUnifiedADData *single = nil;
+ (instancetype)shareSingleObjc
{
    if (single == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            single = [[SingleNativeUnifiedADData alloc] init];
        });
    }
    return single;
}
@end


@interface RNGDTNativeUnifiedAD() <GDTUnifiedNativeAdDelegate>
@property (nonatomic, strong) GDTUnifiedNativeAd * unifiedNativeAd;
@property(nonatomic,copy) RCTPromiseResolveBlock resolve;
@property(nonatomic,copy) RCTPromiseRejectBlock reject;

@end

@implementation RNGDTNativeUnifiedAD
RCT_EXPORT_MODULE();

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


RCT_EXPORT_METHOD(loadWithObjectInfo:(NSDictionary *)objectInfo
    backData:(RCTPromiseResolveBlock)resolve
    rejecter:(RCTPromiseRejectBlock)reject)
{
        if (!self.unifiedNativeAd) {
            self.unifiedNativeAd = [[GDTUnifiedNativeAd alloc]initWithAppId:objectInfo[@"appId"] placementId:objectInfo[@"placementId"] ];
            self.unifiedNativeAd.delegate = self;
      
        }
    
      
    if([SingleNativeUnifiedADData shareSingleObjc].loaded){
        if([SingleNativeUnifiedADData shareSingleObjc].dataList.count > 0 ){
            return  resolve(@([SingleNativeUnifiedADData shareSingleObjc].dataList.count));
        }else {
            return  reject(0,@"没有数据",nil);
        }
    }

    self.resolve = resolve;
    self.reject = reject;
    [self.unifiedNativeAd loadAdWithAdCount:10];
    
}
- (void)gdt_unifiedNativeAdLoaded:(NSArray<GDTUnifiedNativeAdDataObject *> *)unifiedNativeAdDataObjects error:(NSError *)error
{
    [SingleNativeUnifiedADData shareSingleObjc].loaded = YES;
    if (!error && unifiedNativeAdDataObjects.count > 0) {
         

        [SingleNativeUnifiedADData shareSingleObjc].dataList = unifiedNativeAdDataObjects;
       
        if(self.resolve){
            self.resolve(@(unifiedNativeAdDataObjects.count));
            self.resolve = nil;
        }
       
  
        return ;
    }
    if(self.reject){
        self.reject([@(error.code) stringValue], @"",error );
        self.reject = nil;
    }
   

  
    
   if (error.code == 5004) {
          NSLog(@"没匹配的广告，禁止重试，否则影响流量变现效果");
      } else if (error.code == 5005) {
          NSLog(@"流量控制导致没有广告，超过日限额，请明天再尝试");
      } else if (error.code == 5009) {
          NSLog(@"流量控制导致没有广告，超过小时限额");
      } else if (error.code == 5006) {
          NSLog(@"包名错误");
      } else if (error.code == 5010) {
          NSLog(@"广告样式校验失败");
      } else if (error.code == 3001) {
          NSLog(@"网络错误");
      } else if (error.code == 5013) {
          NSLog(@"请求太频繁，请稍后再试");
      } else if (error) {
          NSLog(@"ERROR: %@", error);
      }
}


//Add this utility method in your class.
//- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
//{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//
//    unsigned count;
//    objc_property_t *properties = class_copyPropertyList([obj class], &count);
//
//    for (int i = 0; i < count; i++) {
//        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
//         id value = [obj valueForKey:key];
////        if([key isEqualToString:@"dataObjectAdapter"] || [key isEqualToString:@"networkConfigModel"] || [key isEqualToString:@"mediaUrlList"] || [key isEqualToString:@"appPrice"] || [key isEqualToString:@"videoConfig"]){
////            continue;
////        }
//       if (value == nil) {
//            // nothing todo
//        }
//        else if ([value isKindOfClass:[NSNumber class]]
//            || [value isKindOfClass:[NSString class]]
//            || [value isKindOfClass:[NSDictionary class]]) {
//        // TODO: extend to other types
//            [dict setObject:value forKey:key];
//        }
//        else if ([value isKindOfClass:[NSObject class]]) {
//            [dict setObject:[self dictionaryWithPropertiesOfObject:value] forKey:key];
//        }
//        else {
//            NSLog(@"Invalid type for %@ (%@)", NSStringFromClass([self class]), key);
//        }
//    }
//
//    free(properties);
//
//    return [NSDictionary dictionaryWithDictionary:dict];
//}


@end
