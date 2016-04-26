//
//  ZXVideoPlayerController.h
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/21.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

@interface ZXVideoPlayerController : MPMoviePlayerController

@property (nonatomic, copy) void(^dimissCompleteBlock)(void);
@property (nonatomic, assign) CGRect frame;

/// 将要切换到小屏模式
@property (nonatomic, copy) void(^willRestoreOriginalScreenMode)(NSTimeInterval duration);
/// 将要切换到全屏模式
@property (nonatomic, copy) void(^willSwitchToFullScreenMode)(NSTimeInterval duration);

- (instancetype)initWithFrame:(CGRect)frame;
/// 展示播放器
- (void)showInWindow;
/// 关闭播放器
- (void)dismiss;

@end
