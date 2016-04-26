//
//  ZXVideoPlayerTimeIndicatorView.m
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/21.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "ZXVideoPlayerTimeIndicatorView.h"
#import "ZXVideoPlayerControlView.h"

static const CGFloat kViewGap = 15.0;
static const CGFloat kTimeIndicatorAutoFadeOutTimeInterval = 1.5;

@interface ZXVideoPlayerTimeIndicatorView ()

@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong, readwrite) UILabel *label;

@end

@implementation ZXVideoPlayerTimeIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        [self createTimeIndicator];
    }
    return self;
}

- (void)setLabelText:(NSString *)labelText
{
    //    _labelText = [labelText copy];
    self.hidden = NO;
    self.label.text = labelText;
    
    // 防止重叠显示
    if (self.superview.accessibilityIdentifier) {
        ZXVideoPlayerControlView *playerView = (ZXVideoPlayerControlView *)self.superview;
        playerView.brightnessIndicatorView.hidden = YES;
        playerView.volumeIndicatorView.hidden = YES;
    } else {
        self.superview.accessibilityIdentifier = @"";
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(animateHide) object:nil];
    [self performSelector:@selector(animateHide) withObject:nil afterDelay:kTimeIndicatorAutoFadeOutTimeInterval];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.playState == ZXTimeIndicatorPlayStateRewind) {
        [self.imageView setImage:[UIImage imageNamed:@"zx-video-player-rewind"]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"zx-video-player-fastForward"]];
    }
}

- (void)createTimeIndicator
{
    CGFloat margin = (kVideoTimeIndicatorViewSide - 24 - 12 - kViewGap) / 2;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kVideoTimeIndicatorViewSide - 44) / 2, margin, 44, 24)];
    [self addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, margin + 24 + kViewGap, kVideoTimeIndicatorViewSide, 12)];
    _label.textColor = [UIColor whiteColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.font = [UIFont systemFontOfSize:12];
    _label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_label];
}

- (void)animateHide
{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        self.alpha = 1;
        self.superview.accessibilityIdentifier = nil;
    }];
}

@end
