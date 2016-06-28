//
//  TencentQZoneActivity.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "TencentQZoneActivity.h"

@implementation TencentQZoneActivity

- (NSString *)activityType {
    
    return @"AspTencentQZoneActivity";
}

- (NSString *)activityTitle {
    
    return @"QQ空间";
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
    
    return [UIImage imageNamed:@"ShareBundle.bundle/share_icon_2"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
    if (activityItems.count > 0) {
        
        return YES;
    }
    
    return NO;
}

- (void)performActivity {
    [self activityDidFinish:YES];
    
    if (self.tencentQZoneActivityBlock) {
        self.tencentQZoneActivityBlock();
    }
}

@end
