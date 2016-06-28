//
//  CALCustomShareMessage.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 26/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 分享类型，除了news以外，还可能是video／audio／app等。
 */
typedef NS_ENUM (NSUInteger, CALCustomShareMessageMultimediaType) {
    
    CALCustomShareMessageMultimediaTypeNews = 0,
    CALCustomShareMessageMultimediaTypeAudio,
    CALCustomShareMessageMultimediaTypeVideo,
    CALCustomShareMessageMultimediaTypeApp,
    CALCustomShareMessageMultimediaTypeFile,
    CALCustomShareMessageMultimediaTypeUndefined
};

@interface CALCustomShareMessage : NSObject

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDescription;
@property (nonatomic, copy) NSString *shareLink;

@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) UIImage *shareThumbnail;

@property (nonatomic, assign) CALCustomShareMessageMultimediaType shareMultimediaType;

//for 微信
@property (nonatomic, copy) NSString *shareExtInfo;
@property (nonatomic, copy) NSString *shareMediaDataUrl;
@property (nonatomic, copy) NSString *shareFileExt;

@property (nonatomic, strong) NSData *shareGIFOrFile;

/**
 *  判断emptyValueForKeys都为空, notEmptyValueForKeys都不为空
 *
 *  @param emptyValueForKeys    空的key
 *  @param notEmptyValueForKeys 非空的key
 *
 *  @return YES / NO
 */
- (BOOL)isEmptyWithValueOfKeys:(NSArray *)emptyValueForKeys notEmpty:(NSArray *)notEmptyValueForKeys;

@end
