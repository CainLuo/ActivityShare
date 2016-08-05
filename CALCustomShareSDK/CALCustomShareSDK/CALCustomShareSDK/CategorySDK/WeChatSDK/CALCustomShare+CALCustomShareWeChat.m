//
//  CALCustomShare+CALCustomShare_WeChat.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare+CALCustomShareWeChat.h"

typedef NS_ENUM(NSInteger, CALCustomShareWeChatType) {
    CALCustomShareWeChatSession = 0,
    CALCustomShareWeChatTimeLine,
    CALCustomShareWeChatFavorite
};

static NSDictionary *wechatDictionary;
static NSString *platformName = @"Weixin";

@implementation CALCustomShare (CALCustomShareWeChat)

+ (void)registerWeixinWithAppId:(NSDictionary *)appTypeOrKey {

    wechatDictionary = appTypeOrKey;
    
    NSDictionary *platform = @{@"appid" : [appTypeOrKey objectForKey:@"appid"]};
    
    [self registerPlatforms:platform platform:platformName];
}

+ (BOOL)isWeixinInstalled {
    
    return [self canOpenURL:@"weixin://"];
}

+ (void)shareToWeixinSession:(CALCustomShareMessage *)message
                  shareBlock:(calCustomShareBlock)shareBlock {
    
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self wechatShareURL:message shareType:CALCustomShareWeChatSession]];
    }
}

+ (void)shareToWeixinTimeline:(CALCustomShareMessage *)message
                   shareBlock:(calCustomShareBlock)shareBlock {
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self wechatShareURL:message shareType:CALCustomShareWeChatTimeLine]];
    }
}

+ (void)shareToWeixinFavorite:(CALCustomShareMessage *)message
                   shareBlock:(calCustomShareBlock)shareBlock {
 
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self wechatShareURL:message shareType:CALCustomShareWeChatFavorite]];
    }
}

/**
 *  分享Message到微信好友/朋友圈/收藏
 *
 *  @param message         分享的消息对象
 *  @param shareWechatType 0:微信好友 1:微信朋友圈 2:微信收藏
 *
 *  @return 需要打开的URL
 */
+ (NSString *)wechatShareURL:(CALCustomShareMessage *)message
                   shareType:(CALCustomShareWeChatType)shareWechatType {
    
    NSDictionary *parameter = @{@"result" : @"1",
                                @"returnFromApp" : @"0",
                                @"scene" : [NSString stringWithFormat:@"%ld", (long)shareWechatType],
                                @"sdkver" : @"1.7.1",
                                @"command" : @"1010"};
    
    NSMutableDictionary *parameterDictionary = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    
    if (!message.shareMultimediaType) {
        
        if ([message isEmptyWithValueOfKeys:@[@"shareImage", @"shareLink", @"shareGIFOrFile"] notEmpty:@[@"shareTitle"]]) {
            
            parameterDictionary[@"command"] = @"1020";
            parameterDictionary[@"title"] = message.shareTitle;
            
        } else if ([message isEmptyWithValueOfKeys:@[@"shareLink"] notEmpty:@[@"shareImage"]]) {
            
            parameterDictionary[@"title"] = message.shareTitle ? : @"";
            parameterDictionary[@"fileData"] = [self dataWithImage:message.shareImage];
            parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
            parameterDictionary[@"objectType"] = @"2";
            
        } else if ([message isEmptyWithValueOfKeys:nil notEmpty:@[@"shareLink", @"shareTitle", @"shareImage"]]) {
            
            parameterDictionary[@"description"] = message.shareDescription ? : message.shareTitle;
            parameterDictionary[@"mediaUrl"] = message.shareLink;
            parameterDictionary[@"objectType"] = @"5";
            parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
            parameterDictionary[@"title"] = message.shareTitle;
            
        } else if ([message isEmptyWithValueOfKeys:@[@"shareLink"] notEmpty:@[@"shareGIFOrFile"]]) {
            
            parameterDictionary[@"fileData"] = message.shareGIFOrFile ? message.shareGIFOrFile : [self dataWithImage:message.shareImage];
            parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
            parameterDictionary[@"objectType"] = @"8";
        }
    } else if (message.shareMultimediaType == CALCustomShareMessageMultimediaTypeAudio) {
        
        parameterDictionary[@"description"] = message.shareDescription ? : message.shareTitle;
        parameterDictionary[@"mediaUrl"] = message.shareLink;
        parameterDictionary[@"objectType"] = @"3";
        parameterDictionary[@"mediaDataUrl"] = message.shareMediaDataUrl;
        parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
        parameterDictionary[@"title"] = message.shareTitle;

    } else if (message.shareMultimediaType == CALCustomShareMessageMultimediaTypeVideo) {
        
        parameterDictionary[@"description"] = message.shareDescription ? : message.shareTitle;
        parameterDictionary[@"mediaUrl"] = message.shareLink;
        parameterDictionary[@"objectType"] = @"4";
        parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
        parameterDictionary[@"title"] = message.shareTitle;

    } else if (message.shareMultimediaType == CALCustomShareMessageMultimediaTypeApp) {
        
        parameterDictionary[@"description"] = message.shareDescription ? : message.shareTitle;
        
        if (message.shareExtInfo) {
            parameterDictionary[@"extInfo"] = message.shareExtInfo;
        }
        
        parameterDictionary[@"fileData"] = [self dataWithImage:message.shareImage];
        parameterDictionary[@"mediaUrl"] = message.shareLink;
        parameterDictionary[@"objectType"] = @"7";
        parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
        parameterDictionary[@"title"] = message.shareTitle;

    } else if (message.shareMultimediaType == CALCustomShareMessageMultimediaTypeFile) {
   
        parameterDictionary[@"description"] = message.shareDescription ? : message.shareTitle;
        parameterDictionary[@"fileData"] = [self dataWithImage:message.shareImage];
        parameterDictionary[@"objectType"] = @"6";
        parameterDictionary[@"fileExt"] = message.shareFileExt;
        parameterDictionary[@"thumbData"] = message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(100, 100)];
        parameterDictionary[@"title"] = message.shareTitle;
    }
        
    NSData *output = [NSPropertyListSerialization dataWithPropertyList:@{[self getPlatforms:platformName][@"appid"] : parameterDictionary}
                                                                format:NSPropertyListBinaryFormat_v1_0
                                                               options:0
                                                                 error:nil];
    
    [[UIPasteboard generalPasteboard] setData:output forPasteboardType:@"content"];
    
    return [NSString stringWithFormat:@"weixin://app/%@/sendreq/?", [self getPlatforms:platformName][@"appid"]];
}

/**
 *  微信登录, 该方法仅限于已获得认证的开发者申请, 需要去微信开发平台先注册
 *
 *  @param scope     scope
 *  @param authBlock 微信登录的回调
 */
+ (void)WeixinAuth:(NSString *)scope
         authBlock:(calCustomAuthBlock)authBlock {
    if ([self beginAuth:platformName calBlackBlock:authBlock]) {
        
        [self openURL:[NSString stringWithFormat:@"weixin://app/%@/auth/?scope=%@&state=Weixinauth", [self getPlatforms:platformName][@"appid"], scope]];
    }
}

/**
 *  微信支付, 参数是由服务器生成的
 *
 *  @param link     服务器返回的Link, 直接打开支付
 *  @param payBlock 微信支付的回调
 */
+ (void)WeixinPay:(NSString *)link
         payBlock:(calCustomPayBlock)payBlock {
    [self setPayCallBackWithBlock:payBlock];
    [self openURL:link];
}

/**
 *  处理微信回调回来的URL
 *
 *  @return BOOL
 */
+ (BOOL)Weixin_handleOpenURL {
    
    NSURL *WeChatURL = [self returnedURL];
    
    if ([WeChatURL.scheme hasPrefix:@"wx"]) {
        
        NSDictionary *returnDictionary = [NSPropertyListSerialization propertyListWithData:[[UIPasteboard generalPasteboard] dataForPasteboardType:@"content"] ? : [[NSData alloc] init]
                                                                                   options:0 format:0 error:nil];
                
        if ([WeChatURL.absoluteString rangeOfString:@"://oauth"].location != NSNotFound) {
            
            if ([self customAuthBlock]) {
                [self customAuthBlock]([self parseURL:WeChatURL], nil);
            }
        } else if ([WeChatURL.absoluteString rangeOfString:@"://pay/"].location != NSNotFound) {
            
            NSDictionary *URLMap = [self parseURL:WeChatURL];
            
            if ([URLMap[@"ret"] intValue] == 0) {
                
                if ([self customPayBlock]) {
                    [self customPayBlock](URLMap, nil);
                }
            } else {
                
                if ([self customPayBlock]) {
                    
                    NSError *error = [NSError errorWithDomain:@"weixin_pay" code:[URLMap[@"ret"] intValue] userInfo:returnDictionary];
                    
                    [self customPayBlock](URLMap, error);
                }
            }
        } else {
            
            if (returnDictionary[@"state"] && [returnDictionary[@"state"] isEqualToString:@"Weixinauth"] && [returnDictionary[@"result"] intValue] != 0) {
                
                if ([self customAuthBlock]) {
                    
                    NSError *error = [NSError errorWithDomain:@"weixin_auth" code:[returnDictionary[@"result"] intValue] userInfo:returnDictionary];
                    
                    [self customAuthBlock](returnDictionary, error);
                    
                } else if ([returnDictionary[@"result"] intValue] == 0) {
                    
                    if ([self customShareBlock]) {
                        [self customShareBlock]([self shareMessage], nil);
                    }
                    
                } else {
                    
                    if ([self customShareBlock]) {
                        
                        NSError *error = [NSError errorWithDomain:@"weixin_share" code:[returnDictionary[@"result"] intValue] userInfo:returnDictionary];

                        [self customShareBlock]([self shareMessage], error);
                    }
                }
            }
        }
        
        return YES;
    } else {
        
        return NO;
    }
}

@end
