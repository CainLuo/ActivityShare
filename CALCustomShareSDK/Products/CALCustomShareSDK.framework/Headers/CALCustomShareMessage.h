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

#pragma mark - 通用分享属性
/**
 *  分享标题
 */
@property (nonatomic, copy) NSString *shareTitle;

/**
 *  分享内容
 */
@property (nonatomic, copy) NSString *shareDescription;

/**
 *  分享URL
 */
@property (nonatomic, copy) NSString *shareLink;

/**
 *  分享图片
 */
@property (nonatomic, strong) UIImage *shareImage;

/**
 *  分享链接的缩略图
 */
@property (nonatomic, strong) UIImage *shareThumbnail;

/**
 *  分享的类型
 */
@property (nonatomic, assign) CALCustomShareMessageMultimediaType shareMultimediaType;

#pragma mark - 微信分享内容
/**
 *  分享内容
 */
@property (nonatomic, copy) NSString *shareExtInfo;

/**
 *  分享媒体及URL
 */
@property (nonatomic, copy) NSString *shareMediaDataUrl;

/**
 *  分享文件
 */
@property (nonatomic, copy) NSString *shareFileExt;

/**
 *  分享GIF图片
 */
@property (nonatomic, strong) NSData *shareGIFOrFile;

/**
 *  判断emptyValueForKeys都为空, notEmptyValueForKeys都不为空
 *
 *  @param emptyValueForKeys    空的key
 *  @param notEmptyValueForKeys 非空的key
 *
 *  @return YES / NO
 */
- (BOOL)isEmptyWithValueOfKeys:(NSArray *)emptyValueForKeys
                      notEmpty:(NSArray *)notEmptyValueForKeys;

@end
