//
//  CALCustomShare+CALCustomShareTencent.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 28/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare.h"
#import "CALCustomShareMessage.h"

@interface CALCustomShare (CALCustomShareTencent)

/**
 *  注册Tencent平台, 可以分享到:QQ好友或QQ空间, 但需要去腾讯平台申请一个AppKey, 自己去搜吧
 *
 *  @param appTypeOrKey <#appTypeOrKey description#>
 */
+ (void)registerTencentWithAppId:(NSDictionary *)appTypeOrKey;

/**
 *  判断是否能响应Tencent请求
 *
 *  @return BOOL
 */
+ (BOOL)isTencentInstalled;

/**
 *  分享给QQ好友
 *
 *  @param message    分享的消息实例
 *  @param shareBlock 分享回调
 */
+ (void)shareToTencentQQFriends:(CALCustomShareMessage *)message
                     shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  分享到QQ空间
 *
 *  @param message    分享的消息实例
 *  @param shareBlock 分享的回调
 */
+ (void)shareToTencentQQZone:(CALCustomShareMessage *)message
                     shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  分享给QQ收藏
 *
 *  @param message    分享的消息实例
 *  @param shareBlock 分享的回调
 */
+ (void)shareToTencentQQFavorites:(CALCustomShareMessage *)message
                     shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  分享到我的电脑
 *
 *  @param message    分享的消息实例
 *  @param shareBlock 分享的回调
 */
+ (void)shareToTencentQQDataline:(CALCustomShareMessage *)message
                     shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  使用QQ快捷登录
 *
 *  @param scop      scop
 *  @param authBlock 快捷登录的回调
 */
+ (void)tencentQQAuth:(NSString *)scope
            authBlock:(calCustomAuthBlock)authBlock;

/**
 *  打开指定QQ号码的通讯界面
 *
 *  @param number 指定的QQ号码
 */
+ (void)openChatWithQQNumber:(NSString *)number;

/**
 *  打开指定QQ群的通讯界面
 *
 *  @param number 指定的QQ群号码
 */
+ (void)openChatWithQQGroup:(NSString *)number;

/**
 *  处理QQ回调回来的URL
 *
 *  @return BOOL
 */
+ (BOOL)QQ_handleOpenURL;

@end
