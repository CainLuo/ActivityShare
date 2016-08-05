//
//  CALCustomShare.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CALCustomShareMessage.h"

typedef NS_ENUM(NSInteger, CALCustomShareType) {
    
    CALCustomShareWeibo = 0,
    CALCustomShareWechat,
    CALCustomShareTencent,
};

typedef  NS_ENUM(NSInteger, CALCustomSharePboardEncoding) {
    CALCustomSharePboardEncodingKeyedArchiver = 0,
    CALCustomSharePboardEncodingPropertyListSerialization
};

typedef void (^calCustomShareBlock)(CALCustomShareMessage *customShareMessage, NSError *error);
typedef void (^calCustomAuthBlock)(NSDictionary *message, NSError *error);
typedef void (^calCustomPayBlock)(NSDictionary *message, NSError *error);

@interface CALCustomShare : NSObject

#pragma mark - Register Platforms Method
+ (void)registerPlatforms:(NSDictionary *)platform platform:(NSString *)platformName;
+ (NSDictionary *)getPlatforms:(NSString *)platform;

+ (void)openURL:(NSString *)url;
+ (BOOL)canOpenURL:(NSString *)url;
+ (BOOL)handleOpenURL:(NSURL *)url;
+ (NSMutableDictionary *)parseURL:(NSURL *)url;

+ (NSURL *)returnedURL;
+ (NSDictionary *)returnedData;

+ (void)setReturnedData:(NSDictionary *)retData;

#pragma mark - Get Custom Share Block
+ (calCustomShareBlock)customShareBlock;
+ (calCustomAuthBlock)customAuthBlock;
+ (calCustomPayBlock)customPayBlock;

#pragma mark - Set Share Message Method
+ (CALCustomShareMessage *)shareMessage;
+ (void)setShareMessage:(CALCustomShareMessage *)shareMessage;

#pragma mark - Set Share Call Back Block And Pay Method
+ (void)setShareCallBackWithBlock:(calCustomShareBlock)shareBlock;
+ (void)setPayCallBackWithBlock:(calCustomPayBlock)payBlock;

#pragma mark - Share And Auth Method
+ (BOOL)beginShare:(NSString *)platform message:(CALCustomShareMessage *)message callBlackBlock:(calCustomShareBlock)shareBlock;
+ (BOOL)beginAuth:(NSString *)platform calBlackBlock:(calCustomAuthBlock)authBlock;

#pragma mark - Puli Method
+ (NSString *)base64Encode:(NSString *)input;
+ (NSString *)base64Decode:(NSString *)input;

+ (NSString *)CFBundleDisplayName;
+ (NSString *)CFBundleIdentifier;

#pragma mark - Pastboard Method
+ (void)setGeneralPasteboardWithDictionary:(NSDictionary *)dictionary encoding:(CALCustomSharePboardEncoding)encoding;

+ (NSDictionary *)generalPasteboardData:(NSString *)key encoding:(CALCustomSharePboardEncoding)encoding;

+ (NSString *)base64AndURLEncode:(NSString *)string;
+ (NSString *)URLDecode:(NSString *)input;

/**
 *  截图当前屏幕大小的图片
 *
 *  @return UIImage
 */
+ (UIImage *)screenshot;

/**
 *  截取自定义Size大小的图片
 *
 *  @param size 自定义Size
 *
 *  @return UIImage
 */
+ (UIImage *)screenshotWithSize:(CGSize)size;

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size;

+ (NSData *)dataWithImage:(UIImage *)image;
+ (NSData *)dataWithImage:(UIImage *)image scale:(CGSize)size;

@end
