//
//  CALCustomShare+AliPay.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare+AliPay.h"

static NSString *AliPay = @"Alipay";

@implementation CALCustomShare (AliPay)

+ (void)registerAliPay {
    
    [self registerPlatforms:@{@"schema" : AliPay} platform:AliPay];
}

+ (BOOL)isAliPayInstalled {
    
    return [self canOpenURL:@"alipay://"];
}

/*
 * 支付宝为了用户体验，会把截屏放在支付的后面当背景，可选项。
 * 当然也可以用其他的自己生成的UIImage，
 * 比如[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Default@2x" ofType:@"png"]]
 */
+ (void)AliPay:(NSString *)link payBlock:(calCustomPayBlock)block {
    [self setPayCallBackWithBlock:block];
    
    if ([self isAliPayInstalled]) {
        
        UIImage *screenShot = [self screenshot];
        
        NSString *linkString = [self URLDecode:[link substringFromIndex:NSMaxRange([link rangeOfString:@"?"])]];
        
        NSDictionary *linkDictionary = [NSJSONSerialization JSONObjectWithData:[linkString dataUsingEncoding:NSUTF8StringEncoding]
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:nil];
        
        //获取到fromAppUrlScheme，来设置截屏。
        NSDictionary *rootObject = @{@"image_data" : UIImagePNGRepresentation(screenShot),
                                     @"scheme" : linkDictionary[@"fromAppUrlScheme"]};
        
        [[UIPasteboard generalPasteboard] setData:[NSKeyedArchiver archivedDataWithRootObject:rootObject] forPasteboardType:@"com.alipay.alipayClient.screenImage"];
        //END 设置截屏(可以不设置,注释掉这块代码即可。)。

        [self openURL:link];
    }
}

+ (BOOL)AliPay_handleOpenURL {
    
    NSURL *returnURL = [self returnedURL];
    
    if ([returnURL.absoluteString rangeOfString:@"//safepay/"].location != NSNotFound) {
        
        NSError *error;
        
        NSDictionary *returnDictionary = [NSJSONSerialization JSONObjectWithData:[[self URLDecode:returnURL.query] dataUsingEncoding:NSUTF8StringEncoding]
                                                                         options:NSJSONReadingAllowFragments
                                                                           error:&error];
        
        if (error || returnDictionary[@"memo"] == [NSNull null] || [returnDictionary[@"memo"][@"ResultStatus"] intValue] != 9000) {
            
            if ([self customPayBlock]) {
                
                [self customPayBlock](returnDictionary, error ? : [NSError errorWithDomain:@"alipay_pay"
                                                                                      code:returnDictionary[@"memo"] != [NSNull null] ? [returnDictionary[@"memo"][@"ResultStatus"] intValue] : -1
                                                                                  userInfo:returnDictionary]);
            }
            
        } else {
            
            if ([self customPayBlock]) {
                
                [self customPayBlock](returnDictionary, nil);
            }
        }
        
        return YES;
        
    } else {
        
        return NO;
    }
}

@end
