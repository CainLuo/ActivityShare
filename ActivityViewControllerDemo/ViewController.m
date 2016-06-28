//
//  ViewController.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 5/20/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "ViewController.h"
#import "AspActivityViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (IBAction)presentAction:(UIButton *)sender {
    
    NSString *textItem = @"Check out the yourAppNameHere app: itunes http link to your app here";
    UIImage *imageToShare = [UIImage imageNamed:@"wechat_session"];
    
    NSArray *items = @[textItem, imageToShare];
    
    AspActivityViewController *activityVC = [[AspActivityViewController alloc] initAspActivityControllerWithContent:items];
    
//    activityVC.customShareMessage.shareTitle = @"腾讯QQ分享";
//    activityVC.customShareMessage.shareLink = @"http://www.qq.com";
//    activityVC.customShareMessage.shareImage = [UIImage imageNamed:@"wechat_timeline"];
//    activityVC.customShareMessage.shareThumbnail = [UIImage imageNamed:@"wechat_timeline"];
//    activityVC.customShareMessage.shareDescription = [NSString stringWithFormat:@"这里写的是message.description %f", [[NSDate date] timeIntervalSince1970]];
        
//    activityVC.customShareMessage.shareImage = imageToShare;
    
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (IBAction)shareWeiBo:(UIButton *)sender {
    
//    UIImage *imageToShare = [UIImage imageNamed:@"wechat_session"];
//
//    OSMessage *message = [[OSMessage alloc]init];
//    message.title = @"分享到微信好友";
//    message.desc = @"测试测试测试";
//    message.image = imageToShare;
//    
//    [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
//        NSLog(@"分享成功 -> %@", message);
//        
//    } Fail:^(OSMessage *message, NSError *error) {
//        NSLog(@"分享失败 -> %@ -> %@", message, error);
//    }];
}

@end

// com.tencent.xin.sharetimeline
// com.apple.share.SinaWeibo.post