//
//  UnifiedNativeAdCustomView.m
//  GDTMobApp
//
//  Created by royqpwang on 2019/5/19.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import "UnifiedNativeAdCustomView.h"
#import <React/RCTUtils.h>
@implementation UnifiedNativeAdCustomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.mediaView];
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.descLabel];
        [self addSubview:self.clickButton];
        [self addSubview:self.leftImageView];
        [self addSubview:self.midImageView];
        [self addSubview:self.rightImageView];
        [self addSubview:self.CTAButton];
        self.viewController = RCTPresentedViewController();
    }
    return self;
}

- (void)setupWithUnifiedNativeAdObject:(GDTUnifiedNativeAdDataObject *)unifiedNativeDataObject
{
    self.titleLabel.text = unifiedNativeDataObject.title;
    self.descLabel.text = unifiedNativeDataObject.desc;
    NSURL *iconURL = [NSURL URLWithString:unifiedNativeDataObject.iconUrl];
    NSURL *imageURL = [NSURL URLWithString:unifiedNativeDataObject.imageUrl];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *iconData = [NSData dataWithContentsOfURL:iconURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconImageView.image = [UIImage imageWithData:iconData];
            self.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    if ([unifiedNativeDataObject.callToAction length] > 0) {
        [self.clickButton setHidden:YES];
        [self.CTAButton setHidden:NO];
        [self.CTAButton setTitle:unifiedNativeDataObject.callToAction forState:UIControlStateNormal];
    }
    else {
        [self.clickButton setHidden:NO];
        [self.CTAButton setHidden:YES];
        
        if (unifiedNativeDataObject.isAppAd) {
            [self.clickButton setTitle:@"下载" forState:UIControlStateNormal];
        } else {
            [self.clickButton setTitle:@"打开" forState:UIControlStateNormal];
        }
    }
    
    
//    if (unifiedNativeDataObject.isVideoAd || unifiedNativeDataObject.isVastAd) {
//        self.mediaView.hidden = NO;
//    } else {
//        self.mediaView.hidden = YES;
//    }
    self.mediaView.hidden = YES;
      
    
    if (unifiedNativeDataObject.isThreeImgsAd) {
        self.imageView.hidden = YES;
        self.leftImageView.hidden = NO;
        self.midImageView.hidden = NO;
        self.rightImageView.hidden = NO;
        NSURL *leftURL = [NSURL URLWithString:unifiedNativeDataObject.mediaUrlList[0]];
        NSURL *midURL = [NSURL URLWithString:unifiedNativeDataObject.mediaUrlList[1]];
        NSURL *rightURL = [NSURL URLWithString:unifiedNativeDataObject.mediaUrlList[2]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *leftData = [NSData dataWithContentsOfURL:leftURL];
            NSData *midData = [NSData dataWithContentsOfURL:midURL];
            NSData *rightData = [NSData dataWithContentsOfURL:rightURL];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.leftImageView.image = [UIImage imageWithData:leftData];
                self.midImageView.image = [UIImage imageWithData:midData];
                self.rightImageView.image = [UIImage imageWithData:rightData];
            });
        });
    } else {
        self.imageView.hidden = NO;
        self.leftImageView.hidden = YES;
        self.midImageView.hidden = YES;
        self.rightImageView.hidden = YES;
    }
    
    
    CGFloat imageRate = 16 / 9.0;
      if (unifiedNativeDataObject.imageHeight > 0) {
          imageRate = unifiedNativeDataObject.imageWidth / (CGFloat)unifiedNativeDataObject.imageHeight;
      }
      CGFloat width = [UIScreen mainScreen].bounds.size.width - 16;
//      self.backgroundColor = [UIColor grayColor];
      self.iconImageView.frame = CGRectMake(8, 8, 40, 40);
    self.iconImageView.layer.cornerRadius = 20;
    self.iconImageView.layer.masksToBounds = YES;
      self.clickButton.frame = CGRectMake(width - 68, 8, 60, 44);
      self.titleLabel.frame = CGRectMake(66, 8+5, 250, 30);
    [self.titleLabel setFont:[UIFont systemFontOfSize:13]];
      self.descLabel.frame = CGRectMake(8, 76, width, 30);
        CGFloat imageLeft = 55;
      CGFloat imageWidth = width - imageLeft - 70;

    self.imageView.frame = CGRectMake(8+ imageLeft, 114, imageWidth ,  imageWidth   / imageRate );
      // mediaView logoView frame 更新在父view之后设置
    self.imageView.layer.cornerRadius = 10;
    self.imageView.layer.masksToBounds = YES;
    self.mediaView.frame = CGRectMake(8 + imageLeft, 114, imageWidth, imageWidth / imageRate);
      
    self.logoView.frame = CGRectMake(CGRectGetWidth(self.frame) - kGDTLogoImageViewDefaultWidth, CGRectGetHeight(self.frame) - kGDTLogoImageViewDefaultHeight, kGDTLogoImageViewDefaultWidth, kGDTLogoImageViewDefaultHeight);
    
//      [self setupWithUnifiedNativeAdObject:unifiedNativeDataObject];
    [self unregisterDataObject];
      [self registerDataObject:unifiedNativeDataObject clickableViews:@[self.clickButton,
                                                                  self.iconImageView,
                                                                  self.imageView]];
//      [self.mediaView setPlayButtonImage:[UIImage imageNamed:@"play"] size:CGSizeMake(60, 60)]; // register方法后调用
//      if (unifiedNativeDataObject.isVideoAd) {
//          self.muteLabel.frame = CGRectMake(76, 40, 50, 40);
//          self.muteLabel.hidden = NO;
//          self.muteSwitch.frame = CGRectMake(120, 40, 50, 40);
//          self.muteSwitch.on = unifiedNativeDataObject.videoConfig.videoMuted;
//          self.muteSwitch.hidden = NO;
//          self.playButton.frame = CGRectMake(170, 40, 40, 40);
//          self.playButton.hidden = NO;
//          self.pauseButton.frame = CGRectMake(210, 40, 50, 40);
//          self.pauseButton.hidden = NO;
//          self.stopButton.frame = CGRectMake(260, 40, 40, 40);
//          self.stopButton.hidden = NO;
//      }
    
}

#pragma mark - proerty getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.accessibilityIdentifier = @"titleLabel_id";
    }
    return _titleLabel;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.accessibilityIdentifier = @"imageView_id";
    }
    return _imageView;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.accessibilityIdentifier = @"descLabel_id";
    }
    return _descLabel;
}

- (UIButton *)clickButton
{
    if (!_clickButton) {
        _clickButton = [[UIButton alloc] init];
        _clickButton.accessibilityIdentifier = @"clickButton_id";
    }
    return _clickButton;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.accessibilityIdentifier = @"iconImageView_id";
    }
    return _iconImageView;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.accessibilityIdentifier = @"leftImageView_id";
    }
    return _leftImageView;
}

- (UIImageView *)midImageView
{
    if (!_midImageView) {
        _midImageView = [[UIImageView alloc] init];
        _midImageView.accessibilityIdentifier = @"midImageView_id";
    }
    return _midImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.accessibilityIdentifier = @"rightImageView_id";
    }
    return _rightImageView;
}

- (UIButton *)CTAButton {
    if (!_CTAButton) {
        _CTAButton = [[UIButton alloc] init];
        _CTAButton.accessibilityIdentifier = @"CTAButton_id";
    }
    
    return _CTAButton;
}

#pragma mark - private
- (void)clickMuteSwitch
{
    [self.mediaView muteEnable:self.muteSwitch.on];
}

- (void)clickPlay
{
    [self.mediaView play];
}

- (void)clickPause
{
    [self.mediaView pause];
}

- (void)clickStop
{
    [self.mediaView stop];
}

//pragma mark - property getter
- (UISwitch *)muteSwitch
{
    if (!_muteSwitch) {
        _muteSwitch = [[UISwitch alloc] init];
        [_muteSwitch addTarget:self action:@selector(clickMuteSwitch) forControlEvents:UIControlEventValueChanged];
        _muteSwitch.accessibilityIdentifier = @"muteSwitch_id";
    }
    return _muteSwitch;
}

- (UILabel *)muteLabel
{
    if (!_muteLabel) {
        _muteLabel = [[UILabel alloc] init];
        _muteLabel.text = @"静音";
        _muteLabel.accessibilityIdentifier = @"muteLabel_id";
    }
    return _muteLabel;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setTitle:@"play" forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(clickPlay) forControlEvents:UIControlEventTouchUpInside];
        _playButton.accessibilityIdentifier = @"playButton_id";
    }
    return _playButton;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [[UIButton alloc] init];
        [_pauseButton setTitle:@"pause" forState:UIControlStateNormal];
        [_pauseButton addTarget:self action:@selector(clickPause) forControlEvents:UIControlEventTouchUpInside];
        _pauseButton.accessibilityIdentifier = @"pauseButton_id";
    }
    return _pauseButton;
}

- (UIButton *)stopButton
{
    if (!_stopButton) {
        _stopButton = [[UIButton alloc] init];
        [_stopButton setTitle:@"stop" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(clickStop) forControlEvents:UIControlEventTouchUpInside];
        _stopButton.accessibilityIdentifier = @"stopButton_id";
    }
    return _stopButton;
}

-(void)dealloc {
    [self unregisterDataObject];
}

@end
