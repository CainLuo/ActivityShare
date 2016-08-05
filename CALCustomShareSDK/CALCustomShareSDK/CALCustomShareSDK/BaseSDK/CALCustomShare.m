//
//  CALCustomShare.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare.h"

@interface CALCustomShare()

@end

static NSMutableDictionary *platformKeys;
static NSDictionary *returnedData;
static NSURL        *returnedURL;

static calCustomShareBlock customShareBlock;
static calCustomAuthBlock  customAuthBlock;
static calCustomPayBlock   customPayBlock;

static CALCustomShareMessage *customShareMessage;

@implementation CALCustomShare

#pragma mark - Register Platforms
+ (void)registerPlatforms:(NSDictionary *)platform platform:(NSString *)platformName {

    if (!platformKeys) {
        platformKeys = [[NSMutableDictionary alloc] init];
    }
    
    platformKeys[platformName] = platform;
}

+ (NSDictionary *)getPlatforms:(NSString *)platform {
    
    return [platformKeys valueForKey:platform] ? platformKeys[platform] : nil;
}

#pragma mark - Check URL
+ (void)openURL:(NSString *)url {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+ (BOOL)canOpenURL:(NSString *)url {
    
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]];
}

+ (BOOL)handleOpenURL:(NSURL *)url {
    
    returnedURL = url;
    
    for (NSString *key in platformKeys) {
        
        SEL sel = NSSelectorFromString([key stringByAppendingString:@"_handleOpenURL"]);
        
        if ([self respondsToSelector:sel]) {
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:sel]];
            
            [invocation setSelector:sel];
            [invocation setTarget:self];
            [invocation invoke];
            
            BOOL returnValue;
            
            [invocation getReturnValue:&returnValue];
            
            if (returnValue) {
                
                return YES;
            } else {
                
                NSLog(@"fatal error: %@ is should have a method: %@", key, [key stringByAppendingString:@"_handleOpenURL"]);
            }
        }
    }
    
    return NO;
}

+ (NSURL *)returnedURL {
    
    return returnedURL;
}

#pragma mark - Custom Share Block
+ (calCustomShareBlock)customShareBlock {
    return customShareBlock;
}

#pragma mark - Custom Auth Block
+ (calCustomAuthBlock)customAuthBlock {
    return customAuthBlock;
}

#pragma mark - Custom Pay Block
+ (calCustomPayBlock)customPayBlock {
    return customPayBlock;
}

+ (NSDictionary *)returnedData {
    
    return returnedData;
}

+ (void)setReturnedData:(NSDictionary *)retData {
    returnedData = retData;
}

+ (CALCustomShareMessage *)shareMessage {
    return customShareMessage ? :[[CALCustomShareMessage alloc] init];
}

+ (void)setShareMessage:(CALCustomShareMessage *)shareMessage {
    customShareMessage = shareMessage;
}

#pragma mark - Share Call Black Block And Pay Method
+ (void)setShareCallBackWithBlock:(calCustomShareBlock)shareBlock {
    customShareBlock = shareBlock;
}

+ (void)setPayCallBackWithBlock:(calCustomPayBlock)payBlock {
    customPayBlock = payBlock;
}

#pragma mark - Share And Auth Method
+ (BOOL)beginShare:(NSString *)platform message:(CALCustomShareMessage *)message callBlackBlock:(calCustomShareBlock)shareBlock {
    
    if ([self getPlatforms:platform]) {
        
        customShareMessage = message;
        customShareBlock   = shareBlock;
        
        return YES;
    } else {
        
        NSLog(@"You Don't Connect Anything Platform");
        
        return NO;
    }
}

+ (BOOL)beginAuth:(NSString *)platform calBlackBlock:(calCustomAuthBlock)authBlock {
    
    if ([self getPlatforms:platform]) {
        
        customAuthBlock = authBlock;
        
        return YES;
    } else {
        
        NSLog(@"You Don't Connect Anything Platform");
        
        return NO;
    }
}

#pragma mark - Public Method

+ (NSMutableDictionary *)parseURL:(NSURL *)url {
    
    NSMutableDictionary *queryDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [[url query] componentsSeparatedByString:@"&"];
    
    for (NSString *keyValuePair in urlComponents) {
        NSRange range = [keyValuePair rangeOfString:@"="];
        
        [queryDictionary setObject:range.length > 0 ? [keyValuePair substringFromIndex:range.location + 1] : @"" forKey:(range.length ? [keyValuePair substringToIndex:range.location] : keyValuePair)];
    }
    
    return queryDictionary;
}

#pragma mark - Base 64 Method
+ (NSString *)base64Encode:(NSString *)input {
    
    return [[input dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
}

+ (NSString *)base64Decode:(NSString *)input {
    
    return [[NSString alloc ] initWithData:[[NSData alloc] initWithBase64EncodedString:input options:0]
                                  encoding:NSUTF8StringEncoding];
}

+ (NSString *)CFBundleDisplayName {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)CFBundleIdentifier {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (void)setGeneralPasteboardWithDictionary:(NSDictionary *)dictionary encoding:(CALCustomSharePboardEncoding)encoding {
    
    if (dictionary) {
        
        NSData *data = [[NSData alloc] init];
        NSError *error;
        
        switch (encoding) {
            case CALCustomSharePboardEncodingKeyedArchiver:
                
                data = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
                
                break;
            case CALCustomSharePboardEncodingPropertyListSerialization:
                
                data = [NSPropertyListSerialization dataWithPropertyList:dictionary
                                                                  format:NSPropertyListBinaryFormat_v1_0
                                                                 options:0
                                                                   error:&error];
                break;
            default:
                
                NSLog(@"Encoding Not Implemented");
                
                break;
        }
        
        if (error) {
            
            NSLog(@"Error When NSPropertListSerialication: %@", error);
            
        } else if (data) {
            
            [[UIPasteboard generalPasteboard] setData:data forPasteboardType:[dictionary objectForKey:@"key"]];
        }
    }
}

+ (NSDictionary *)generalPasteboardData:(NSString *)key encoding:(CALCustomSharePboardEncoding)encoding {
    
    NSData *data = [[UIPasteboard generalPasteboard] dataForPasteboardType:key];
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    
    if (data) {
        
        NSError *error = [[NSError alloc] init];
        
        switch (encoding) {
            case CALCustomSharePboardEncodingKeyedArchiver:
                
                dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
                break;
            case CALCustomSharePboardEncodingPropertyListSerialization:
                
                dictionary = [NSPropertyListSerialization propertyListWithData:data
                                                                       options:0
                                                                        format:0
                                                                         error:&error];
                
                break;
            default:
                break;
        }
        
        if (error) {
            
            NSLog(@"Error When NSPropertyList Serialization: %@", error);
        }
    }
    
    return nil;
}

+ (NSString *)base64AndURLEncode:(NSString *)string {
    
    return [[self base64Encode:string] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

+ (NSString *)URLDecode:(NSString *)input {
    
    return [[input stringByReplacingOccurrencesOfString:@"+" withString:@" "]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - Get Image
+ (UIImage *)screenshot {
    
    CGSize imageSize                   = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        
        imageSize = [UIScreen mainScreen].bounds.size;
        
    } else {
        
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    }
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x,
                              -window.bounds.size.height * window.layer.anchorPoint.y);
        
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
            
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
            
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
            
        } else {
            
            [window.layer renderInContext:context];
            
        }
        
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)screenshotWithSize:(CGSize)size {
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x,
                              -window.bounds.size.height * window.layer.anchorPoint.y);
        
        if (orientation == UIInterfaceOrientationLandscapeLeft) {
            
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -size.width);
            
        } else if (orientation == UIInterfaceOrientationLandscapeRight) {
            
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -size.height, 0);
            
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -size.width, -size.height);
        }
        
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
            
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
            
        } else {
            
            [window.layer renderInContext:context];
            
        }
        
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark - Get Image Data
+ (NSData *)dataWithImage:(UIImage *)image {
    
    return UIImageJPEGRepresentation(image, 1);
}

+ (NSData *)dataWithImage:(UIImage *)image scale:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(scaledImage, 1);
}

@end
