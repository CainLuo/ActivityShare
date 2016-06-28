//
//  AspShareActivity.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 23/5/2016.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "AspShareActivity.h"
//#import "OpenShareHeader.h"

@implementation AspShareActivity

//+ (UIActivityCategory)activityCategory {
//    
//    return UIActivityCategoryShare;
//}

- (NSString *)activityType {
    
    return @"AspShareActivity";
}

- (NSString *)activityTitle {
    
    return @"微信好友";
}

/**
 *  如果正常的调用activityImage, 那么图片只有灰色的, 如果要使图片显示正常, 就要直接调用这个私用方法_activityImage
 *
 *  @return UIImage
 */
- (UIImage *)_activityImage {
    
    // Note: These images need to have a transparent background and I recommend these sizes:
    // iPadShare@2x should be 126 px, iPadShare should be 53 px, iPhoneShare@2x should be 100
    // px, and iPhoneShare should be 50 px. I found these sizes to work for what I was making.
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return [UIImage imageNamed:@"AppIcon.bundle/sns_icon_22"];
        
    } else {
        
        return [UIImage imageNamed:@"AppIcon.bundle/sns_icon_22"];
    }
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    if (activityItems.count > 0) {
        
        return YES;
    }
    
    NSLog(@"哈哈哈%s ----- %@", __FUNCTION__, activityItems);
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
    NSLog(@"呵呵呵%s ----- %@", __FUNCTION__, activityItems);
    
//    NSLog(@"I Have App? %@", [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo://"]] ? @"YES" : @"NO");
}

- (UIViewController *)activityViewController {
    
    NSLog(@"嘿嘿嘿%s",__FUNCTION__);
    
    return nil;
}

- (void)performActivity {
    
    // This is where you can do anything you want, and is the whole reason for creating a custom
    // UIActivity
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqqwpa://im/chat?"]];
    [self activityDidFinish:YES];
}

- (void)activityDidFinish:(BOOL)completed {
    
    NSLog(@"completed = %@", completed ? @"YES" : @"NO");
}

@end
