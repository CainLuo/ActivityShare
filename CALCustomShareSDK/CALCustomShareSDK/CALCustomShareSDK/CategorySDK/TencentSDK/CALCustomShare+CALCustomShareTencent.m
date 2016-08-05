//
//  CALCustomShare+CALCustomShareTencent.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare+CALCustomShareTencent.h"

typedef NS_ENUM(NSInteger, CALCustomShareTencentType) {
    CALCustomShareTencentQQFriends = 0,
    CALCustomShareTencentQQZone,
    CALCustomShareTencentQQFavorites,
    CALCustomShareTencentQQDataline,
};

static NSDictionary *tencentDictionary;
static NSString *platformName = @"QQ";

@implementation CALCustomShare (CALCustomShareTencent)

+ (void)registerTencentWithAppId:(NSDictionary *)appTypeOrKey {
    
    tencentDictionary = appTypeOrKey;
    NSString *appid = [appTypeOrKey objectForKey:@"appid"];
    
    NSDictionary *platform = @{@"appid" : appid,
                               @"callback_name" : [NSString stringWithFormat:@"QQ%02llx", [appid longLongValue]]};

    [self registerPlatforms:platform platform:platformName];
}

+ (BOOL)isTencentInstalled {
    
    return [self canOpenURL:@"mqqapi://"];
}

+ (void)shareToTencentQQFriends:(CALCustomShareMessage *)message
                     shareBlock:(calCustomShareBlock)shareBlock {
    
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self tencentShareURL:message shareType:CALCustomShareTencentQQFriends]];
    }
}

+ (void)shareToTencentQQZone:(CALCustomShareMessage *)message
                  shareBlock:(calCustomShareBlock)shareBlock {
    
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        
        [self openURL:[self tencentShareURL:message
                                  shareType:CALCustomShareTencentQQZone]];
    }
}

+ (void)shareToTencentQQFavorites:(CALCustomShareMessage *)message
                       shareBlock:(calCustomShareBlock)shareBlock {
    
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self tencentShareURL:message
                                  shareType:CALCustomShareTencentQQFavorites]];
    }
}

+ (void)shareToTencentQQDataline:(CALCustomShareMessage *)message
                      shareBlock:(calCustomShareBlock)shareBlock {
    
    if ([self beginShare:platformName message:message callBlackBlock:shareBlock]) {
        [self openURL:[self tencentShareURL:message
                                  shareType:CALCustomShareTencentQQDataline]];
    }
}

+ (NSString *)tencentShareURL:(CALCustomShareMessage *)message
                    shareType:(CALCustomShareTencentType)shareTencentType {
    
    NSMutableString *returnString = [[NSMutableString alloc] initWithString:@"mqqapi://share/to_fri?thirdAppDisplayName="];
    
    [returnString appendString:[self base64Encode:[self CFBundleDisplayName]]];
    [returnString appendString:@"&version=1&cflag="];
    [returnString appendFormat:@"%ld", (long)shareTencentType];
    [returnString appendString:@"&callback_type=scheme&generalpastboard=1"];
    [returnString appendString:@"&callback_name="];
    [returnString appendString:[self getPlatforms:platformName][@"callback_name"]];
    [returnString appendString:@"&src_type=app&shareType=0&file_type="];

    if ([message isEmptyWithValueOfKeys:@[@"shareImage", @"shareLink"] notEmpty:@[@"shareTitle"]]) {
        
        [returnString appendString:@"text&file_data="];
        [returnString appendString:[self base64AndURLEncode:message.shareTitle]];
        
    } else if ([message isEmptyWithValueOfKeys:@[@"shareLink"] notEmpty:@[@"shareTitle", @"shareImage", @"shareDescription"]]) {
        
        NSDictionary *dataDictionary = @{@"file_data" : [self dataWithImage:message.shareImage],
                                         @"previewimagedata" : message.shareThumbnail ? [self dataWithImage:message.shareThumbnail] : [self dataWithImage:message.shareImage scale:CGSizeMake(36, 36)]};
        
        NSDictionary *apiLargeData = @{@"com.tencent.mqq.api.apiLargeData" : dataDictionary};
        
        [self setGeneralPasteboardWithDictionary:apiLargeData encoding:CALCustomSharePboardEncodingKeyedArchiver];
        
        [returnString appendString:@"img&title="];
        [returnString appendString:[self base64Encode:message.shareTitle]];
        [returnString appendString:@"&objectlocation=pasteboard&description="];
        [returnString appendString:[self base64Encode:message.shareDescription]];

    } else if ([message isEmptyWithValueOfKeys:nil notEmpty:@[@"shareTitle", @"shareDescription", @"shareImage", @"shareLink", @"shareMultimediaType"]]) {
        
        NSDictionary *dataDictionary = @{@"previewimagedata" : [self dataWithImage:message.shareImage]};
        
        NSDictionary *apiLargeData = @{@"com.tencent.mqq.api.apiLargeData" : dataDictionary};
        
        [self setGeneralPasteboardWithDictionary:apiLargeData encoding:CALCustomSharePboardEncodingKeyedArchiver];
        
        NSString *messageType = @"news";
        
        if (message.shareMultimediaType == CALCustomShareMessageMultimediaTypeAudio) {
            
            messageType = @"audio";
        }
        
        [returnString appendFormat:@"%@&title=%@&url=%@&description=%@&objectlocation=pasteboard", messageType, [self base64AndURLEncode:message.shareTitle], [self base64AndURLEncode:message.shareLink], [self base64AndURLEncode:message.shareDescription]];
    }
    
    return returnString;
}

+ (void)tencentQQAuth:(NSString *)scope authBlock:(calCustomAuthBlock)authBlock {
    
    if ([self beginAuth:platformName calBlackBlock:authBlock]) {
        
        NSDictionary *authData = @{@"app_id" : [self getPlatforms:platformName][@"appid"],
                                   @"app_name" : [self CFBundleDisplayName],
                                   @"client_id" : [self getPlatforms:platformName][@"appid"],
                                   @"response_type" : @"token",
                                   @"scope" : scope,
                                   @"sdkp" : @"i",
                                   @"sdkv" : @"2.9",
                                   @"status_mechine" : [[UIDevice currentDevice] model],
                                   @"status_os" : [[UIDevice currentDevice] systemVersion],
                                   @"status_version" : [[UIDevice currentDevice] systemVersion]};
        
        NSDictionary *tencentDictionary = @{[@"com.tencent.tencent" stringByAppendingString:[self getPlatforms:platformName][@"appid"]]: authData};
        
        [self setGeneralPasteboardWithDictionary:tencentDictionary encoding:CALCustomSharePboardEncodingKeyedArchiver];
        
        [self openURL:[NSString stringWithFormat:@"mqqOpensdkSSoLogin://SSoLogin/tencent%@/com.tencent%@?generalpastboard=1", [self getPlatforms:platformName][@"appid"], [self getPlatforms:platformName][@"appid"]]];
    }
}

+ (void)openChatWithQQGroup:(NSString *)number {
    
    [self openURL:[NSString stringWithFormat:@"mqqwpa://im/chat?uin=%@&thirdAppDisplayName=%@&callback_name=%@&src_type=app&version=1&chat_type=group&callback_type=scheme", number, [self base64Encode:[self CFBundleDisplayName]], [self getPlatforms:platformName][@"callback_name"]]];
}

+ (void)openChatWithQQNumber:(NSString *)number {
    
    [self openURL:[NSString stringWithFormat:@"mqqwpa://im/chat?uin=%@&thirdAppDisplayName=%@&callback_name=%@&src_type=app&version=1&chat_type=wpa&callback_type=scheme", number, [self base64Encode:[self CFBundleDisplayName]], [self getPlatforms:platformName][@"callback_name"]]];
}

+ (BOOL)QQ_handleOpenURL {
    
    NSURL *callBlackURL = [self returnedURL];
    
    if ([callBlackURL.scheme hasPrefix:@"QQ"]) {

        NSDictionary *dictionary = [self parseURL:callBlackURL];
        
        if (dictionary[@"error_description"]) {
            
            [dictionary setValue:[self base64Decode:dictionary[@"error_description"]] forKey:@"error_description"];
        }
        
        if ([dictionary[@"error"] intValue] != 0) {
            
            NSError *error = [NSError errorWithDomain:@"response_from_qq" code:[dictionary[@"error"] intValue] userInfo:dictionary];
            
            if ([self customShareBlock]) {
                [self customShareBlock]([self shareMessage], error);
            }
        } else {
            
            if ([self customShareBlock]) {
                [self customShareBlock]([self shareMessage], nil);
            }
        }
        
        return YES;
    } else if ([callBlackURL.scheme hasPrefix:@"tencent"]) {
        
        NSDictionary *returnDictionary = [self generalPasteboardData:[@"com.tencent.tencent" stringByAppendingString:[self getPlatforms:platformName][@"appid"]] encoding:CALCustomSharePboardEncodingKeyedArchiver];
        
        if (returnDictionary[@"ret"] && ([returnDictionary[@"ret"] intValue] == 0)) {
            
            if ([self customAuthBlock]) {
                
                [self customAuthBlock](returnDictionary, nil);
            }
            
        } else {
            
            NSError *error = [NSError errorWithDomain:@"auth_from_QQ"
                                             code:-1
                                         userInfo:returnDictionary];
            
            if ([self customAuthBlock]) {
                [self customAuthBlock](returnDictionary, error);
            }
        }

        return YES;
        
    } else {
    
        return NO;
    }
}

@end
