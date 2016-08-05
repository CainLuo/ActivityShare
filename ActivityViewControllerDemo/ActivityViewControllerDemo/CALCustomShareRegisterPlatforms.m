//
//  CALCustomShareRegisterPlatforms.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShareRegisterPlatforms.h"

@implementation CALCustomShareRegisterPlatforms

+ (void)registerPlatformsWithDictionary:(NSArray *)platforms {
    
    for (NSInteger i = 0; i < platforms.count; i++) {

        NSDictionary *platform = platforms[i];
        NSString *platformType = [platform objectForKey:@"shareType"];
        
        if ([platformType isEqualToString:@"CALCustomShareWeibo"]) {
            
            [CALCustomShare registerWeiboWithAppKey:platform];
            
        } else if ([platformType isEqualToString:@"CALCustomShareWechat"]) {
            
            [CALCustomShare registerWeixinWithAppId:platform];
            
        } else if ([platformType isEqualToString:@"CALCustomShareTencent"]) {
            
            [CALCustomShare registerTencentWithAppId:platform];
        }
    }
}

@end
