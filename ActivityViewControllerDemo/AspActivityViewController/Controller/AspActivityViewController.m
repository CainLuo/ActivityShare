//
//  AspActivityViewController.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 23/5/2016.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "AspActivityViewController.h"

#import "WeiboActionActivity.h"
#import "WeChatSessionActivity.h"
#import "WeChatTimelineActivity.h"
#import "TencentQQActivity.h"
#import "TencentQZoneActivity.h"

#define AspWS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface AspActivityViewController ()

@property (nonatomic, strong) WeiboActionActivity *sinaWeiboActivity;
@property (nonatomic, strong) WeChatSessionActivity  *weChatSessionActivity;
@property (nonatomic, strong) WeChatTimelineActivity *weChatTimelineActivity;
@property (nonatomic, strong) TencentQZoneActivity   *tencentQZoneActivity;
@property (nonatomic, strong) TencentQQActivity      *tencentQQActivity;

@end

@implementation AspActivityViewController

- (instancetype)initAspActivityControllerWithContent:(NSArray *)activityContent activities:(NSArray *)activities {
    
    if (self = [super initWithActivityItems:activityContent applicationActivities:activities]) {
        
        self.customShareMessage = [[CALCustomShareMessage alloc] init];
    }
    
    return self;
}

- (instancetype)initAspActivityControllerWithContent:(NSArray *)activityContent {
    
    NSArray *activitys = @[self.sinaWeiboActivity,
                           self.weChatSessionActivity,
                           self.weChatTimelineActivity,
                           self.tencentQQActivity,
                           self.tencentQZoneActivity];
    
    if (self = [super initWithActivityItems:activityContent applicationActivities:activitys]) {
        
        self.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                       UIActivityTypePostToTwitter,
                                       UIActivityTypePostToWeibo,
                                       UIActivityTypeMail,
                                       UIActivityTypePrint,
                                       UIActivityTypeCopyToPasteboard,
                                       UIActivityTypeAssignToContact,
                                       UIActivityTypeSaveToCameraRoll,
                                       UIActivityTypeAddToReadingList,
                                       UIActivityTypePostToFlickr,
                                       UIActivityTypePostToVimeo,
                                       UIActivityTypePostToTencentWeibo,
                                       UIActivityTypeAirDrop,
                                       UIActivityTypeOpenInIBooks];
        
        [self activitysAction];
    }
    
    return self;
}

#pragma mark - Init Custom Activitys
- (WeiboActionActivity *)sinaWeiboActivity {
    
    if (!_sinaWeiboActivity) {
        
        _sinaWeiboActivity = [[WeiboActionActivity alloc] init];
    }
    
    return _sinaWeiboActivity;
}

- (WeChatSessionActivity *)weChatSessionActivity {
    
    if (!_weChatSessionActivity) {
        
        _weChatSessionActivity = [[WeChatSessionActivity alloc] init];
    }
    
    return _weChatSessionActivity;
}

- (WeChatTimelineActivity *)weChatTimelineActivity {
    
    if (!_weChatTimelineActivity) {
        
        _weChatTimelineActivity = [[WeChatTimelineActivity alloc] init];
    }
    
    return _weChatTimelineActivity;
}

- (TencentQQActivity *)tencentQQActivity {
    
    if (!_tencentQQActivity) {
        
        _tencentQQActivity = [[TencentQQActivity alloc] init];
    }
    
    return _tencentQQActivity;
}

- (TencentQZoneActivity *)tencentQZoneActivity {
    
    if (!_tencentQZoneActivity) {
        
        _tencentQZoneActivity = [[TencentQZoneActivity alloc] init];
    }
    
    return _tencentQZoneActivity;
}

#pragma mark - Activitys Actions
- (void)activitysAction {
    
    AspWS(weakSelf);
    
    if (!self.customShareMessage) {
        self.customShareMessage = [[CALCustomShareMessage alloc] init];
    }
    
    [self.sinaWeiboActivity setWeiboActivityBlock:^{
        
        [CALCustomShare shareToWeibo:weakSelf.customShareMessage
                          shareBlock:^(CALCustomShareMessage *customShareMessage, NSError *error) {
            
                              [CALCustomShareBlock customShareBlockMessage:customShareMessage error:error];
                          }];
    }];
    
    [self.weChatSessionActivity setWeChatSessionActivityBlock:^{
        
        [CALCustomShare shareToWeixinSession:weakSelf.customShareMessage
                                  shareBlock:^(CALCustomShareMessage *customShareMessage, NSError *error) {
            
                                      [CALCustomShareBlock customShareBlockMessage:customShareMessage error:error];
                                  }];
    }];
    
    [self.weChatTimelineActivity setWeChatTimelineActivityBlock:^{
        
        [CALCustomShare shareToWeixinTimeline:weakSelf.customShareMessage
                                   shareBlock:^(CALCustomShareMessage *customShareMessage, NSError *error) {
                                       
                                       [CALCustomShareBlock customShareBlockMessage:customShareMessage error:error];
                                   }];
    }];
    
    [self.tencentQZoneActivity setTencentQZoneActivityBlock:^{
        
        
        [CALCustomShare shareToTencentQQZone:weakSelf.customShareMessage
                                  shareBlock:^(CALCustomShareMessage *customShareMessage, NSError *error) {
            
                                      [CALCustomShareBlock customShareBlockMessage:customShareMessage error:error];
                                  }];
    }];
    
    [self.tencentQQActivity setTencentQQActivityBlock:^{
        
        [CALCustomShare shareToTencentQQFriends:weakSelf.customShareMessage
                                     shareBlock:^(CALCustomShareMessage *customShareMessage, NSError *error) {
                                         
                                         [CALCustomShareBlock customShareBlockMessage:customShareMessage error:error];
                                     }];
    }];
}

@end
