//
//  CALCustomShare+CALCustomShare_WeChat.h
//  ActivityViewControllerDemo
//
//  Created by Cain on 27/6/16.
//  Copyright © 2016年 Cain. All rights reserved.
//

#import "CALCustomShare.h"
#import "CALCustomShareMessage.h"

@interface CALCustomShare (CALCustomShareWeChat)

/**
 *  注册微信AppKey
 *
 *  @param appTypeOrKey 传入的参数
 */
+ (void)registerWeixinWithAppId:(NSDictionary *)appTypeOrKey;

/**
 *  判断是否能响应微信分享请求
 *
 *  @return BOOL
 */
+ (BOOL)isWeixinInstalled;


/**
 *  分享到微信好友
 *
 *  @param message    分享消息实例
 *  @param shareBlock 分享回调
 */
+ (void)shareToWeixinSession:(CALCustomShareMessage *)message
                  shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  分享到微信朋友圈
 *
 *  @param message    分享消息实例
 *  @param shareBlock 分享回调
 */
+ (void)shareToWeixinTimeline:(CALCustomShareMessage *)message
                   shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  分享到微信收藏
 *
 *  @param message    分享消息实例
 *  @param shareBlock 分享回调
 */
+ (void)shareToWeixinFavorite:(CALCustomShareMessage *)message
                   shareBlock:(calCustomShareBlock)shareBlock;

/**
 *  微信登录, 该方法仅限于已获得认证的开发者申请, 需要去微信开发平台先注册
 *
 *  @param scope     scope
 *  @param authBlock 微信登录的回调
 */
+ (void)WeixinAuth:(NSString *)scope authBlock:(calCustomAuthBlock)authBlock;

/**
 *  微信支付, 参数是由服务器生成的
 *
 *  @param link     服务器返回的Link, 直接打开支付
 *  @param payBlock 微信支付的回调
 */
+ (void)WeixinPay:(NSString *)link payBlock:(calCustomPayBlock)payBlock;

@end
