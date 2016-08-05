//
//  CALCustomShare+SinaWeibo.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare+SinaWeibo.h"

static NSDictionary *weiboDictionary;

static NSString *platformName = @"Weibo";

@implementation CALCustomShare (SinaWeibo)

+ (void)registerWeiboWithAppKey:(NSDictionary *)appTypeOrKey {
    
    weiboDictionary = appTypeOrKey;
    
    NSDictionary *platform = @{@"appKey" : [appTypeOrKey objectForKey:@"appKey"]};
    
    [self registerPlatforms:platform platform:platformName];
}

+ (BOOL)isWeiboInstalled {
    return [self canOpenURL:@"weibosdk://request"];
}

+ (void)shareToWeibo:(CALCustomShareMessage *)message shareBlock:(calCustomShareBlock)block {
    
    if (![self beginShare:platformName message:message callBlackBlock:block]) {
        return;
    }
    
    NSDictionary *shareMessage;
    
    if ([message isEmptyWithValueOfKeys:@[@"shareLink", @"shareImage"] notEmpty:@[@"shareTitle"]]) {
        
        shareMessage = @{@"__class" : @"WBMessageObject",
                         @"text" : message.shareTitle};
    } else if ([message isEmptyWithValueOfKeys:@[@"shareLink"] notEmpty:@[@"shareTitle", @"shareImage"]]) {
        
        NSDictionary *imageData = @{@"imageData" : [self dataWithImage:message.shareImage]};
        
        shareMessage = @{@"__class" : @"WBMessageObject",
                         @"imageObject" : imageData,
                         @"text" : message.shareTitle};
        
    } else if ([message isEmptyWithValueOfKeys:nil notEmpty:@[@"shareLink", @"shareTitle", @"shareImage"]]) {
        
        NSDictionary *mediaDictionary = @{@"__class" : @"WBWebpageObject",
                                          @"description" : message.shareDescription ? : message.shareTitle,
                                          @"objectID" : @"identifier1",
                                          @"thumbnailData" : message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)],
                                          @"title" : message.shareTitle,
                                          @"webpageUrl" : message.shareLink};
        
        shareMessage = @{@"__class" : @"WBMessageObject",
                         @"mediaObject" : mediaDictionary};
    }
    
    NSString *uuid       = [[NSUUID UUID] UUIDString];
    NSArray *messageData = @[@{@"transferObject" : [NSKeyedArchiver archivedDataWithRootObject:@{@"__class" : @"WBSendMessageToWeiboRequest",
                                                                                                 @"message" : shareMessage,
                                                                                                 @"requestID" : uuid,
                                                                                                 }]},
                             @{@"userInfo" : [NSKeyedArchiver archivedDataWithRootObject:@{}]},
                             @{@"app" : [NSKeyedArchiver archivedDataWithRootObject:@{@"appKey" : [self getPlatforms:platformName][@"appKey"],
                                                                                      @"bundleID" : [self CFBundleIdentifier]}]
                               }];
    
    [UIPasteboard generalPasteboard].items = messageData;
    
    [self openURL:[NSString stringWithFormat:@"weibosdk://request?id=%@&sdkversion=003013000",uuid]];
}

+ (void)WeiboAuth:(NSString *)scope redirectURI:(NSString*)redirectURI shareBlock:(calCustomAuthBlock)block {
    
    if (![self beginAuth:platformName calBlackBlock:block]) {
        return;
    }
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    NSArray *authData = @[@{@"transferObject" : [NSKeyedArchiver archivedDataWithRootObject:@{@"__class" : @"WBAuthorizeRequest",
                                                                                              @"redirectURI" : redirectURI,
                                                                                              @"requestID" : uuid,
                                                                                              @"scope":  scope ? : @"all"}]},
                          @{@"userInfo" : [NSKeyedArchiver archivedDataWithRootObject:@{@"mykey" : @"as you like",
                                                                                        @"SSO_From" : @"SendMessageToWeiboViewController"}]},
                          
                          @{@"app" : [NSKeyedArchiver archivedDataWithRootObject:@{@"appKey" :[self getPlatforms:platformName][@"appKey"],
                                                                                   @"bundleID" : [self CFBundleIdentifier],
                                                                                   @"name" :[self CFBundleDisplayName]}]
                            }];
    
    [UIPasteboard generalPasteboard].items = authData;
    
    [self openURL:[NSString stringWithFormat:@"weibosdk://request?id=%@&sdkversion=003013000",uuid]];
}

+ (BOOL)Weibo_handleOpenURL {
    
    NSURL *url = [self returnedURL];
    
    if ([url.scheme hasPrefix:@"wb"]) {
        
        NSArray *items = [UIPasteboard generalPasteboard].items;
        
        NSMutableDictionary *ret = [NSMutableDictionary dictionaryWithCapacity:items.count];
        
        for (NSDictionary *item in items) {
            
            for (NSString *index in item) {
                
                ret[index] = [index isEqualToString:@"sdkVersion"] ? item[index] : [NSKeyedUnarchiver unarchiveObjectWithData:item[index]];
            }
        }
        
        NSDictionary *transferObject = ret[@"transferObject"];
        
        if ([transferObject[@"__class"] isEqualToString:@"WBAuthorizaResponse"]) {
            
            if ([transferObject[@"statusCode"] intValue] == 0) {
                
                if ([self customAuthBlock]) {
                    [self customAuthBlock](transferObject, nil);
                }
                
            } else {
                
                if ([self customAuthBlock]) {
                    
                    NSError *error = [NSError errorWithDomain:@"weibo_auth_response"
                                                         code:[transferObject[@"statusCode"] intValue]
                                                     userInfo:transferObject];
                    
                    [self customAuthBlock](transferObject, error);
                }
            }
        } else if ([transferObject[@"__class"] isEqualToString:@"WBSendMessageToWeiboResponse"]) {
            
            if ([transferObject[@"statusCode"] intValue] == 0) {
                
                if ([self customShareBlock]) {
                    [self customShareBlock]([self shareMessage], nil);
                }
                
            } else {
                
                if ([self customShareBlock]) {
                    
                    NSError *error = [NSError errorWithDomain:@"weibo_share_response"
                                                         code:[transferObject[@"statusCode"] intValue]
                                                     userInfo:transferObject];
                    
                    [self customShareBlock]([self shareMessage], error);
                }
            }
        }
        
        return YES;
    } else {
    
        return NO;
    }
}

@end
