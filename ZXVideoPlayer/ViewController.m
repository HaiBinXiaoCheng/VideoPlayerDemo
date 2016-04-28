//
//  ViewController.m
//  ZXVideoPlayer
//
//  Created by Shawn on 16/4/20.
//  Copyright © 2016年 Shawn. All rights reserved.
//

#import "ViewController.h"
#import "ZXVideoPlayerController.h"
#import <AVKit/AVKit.h>
#import "ZXVideoPlayerBrightnessView.h"

@interface ViewController ()

@property (nonatomic, strong) ZXVideoPlayerController *videoController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
    self.tabBarItem.title = @"Home";
}

- (IBAction)playLocalVideo:(id)sender {
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    [self playVideoWithURL:videoURL];
}

- (IBAction)playRemoteVideo:(id)sender {
    // http://baobab.wdjcdn.com/1451897812703c.mp4
    // http://krtv.qiniudn.com/150522nextapp
    NSURL *videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1451897812703c.mp4"];
    [self playVideoWithURL:videoURL];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[ZXVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        self.videoController.willRestoreOriginalScreenMode = ^(NSTimeInterval duration){
            NSLog(@"%g 秒后切换为小屏模式", duration);
        };
        self.videoController.willSwitchToFullScreenMode = ^(NSTimeInterval duration){
            NSLog(@"%g 秒后切换为全屏模式", duration);
        };
        
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

@end
