//
//  AspActivityViewController.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 23/5/2016.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "CALActivityController.h"

#import "CALSinaWeiboActivity.h"
#import "CALWeChatSessionActivity.h"
#import "CALWeChatTimelineActivity.h"
#import "CALTencentQQActivity.h"
#import "CALTencentQZoneActivity.h"

#define AspWS(weakSelf) __weak __typeof(&*self)weakSelf = self

@interface CALActivityController ()

@property (nonatomic, strong) CALSinaWeiboActivity      *sinaWeiboActivity;
@property (nonatomic, strong) CALWeChatSessionActivity  *weChatSessionActivity;
@property (nonatomic, strong) CALWeChatTimelineActivity *weChatTimelineActivity;
@property (nonatomic, strong) CALTencentQZoneActivity   *tencentQZoneActivity;
@property (nonatomic, strong) CALTencentQQActivity      *tencentQQActivity;

@end

@implementation CALActivityController

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
- (CALSinaWeiboActivity *)sinaWeiboActivity {
    
    CAL_GET_OBJECT(_sinaWeiboActivity);
    
    _sinaWeiboActivity = [[CALSinaWeiboActivity alloc] init];
    
    return _sinaWeiboActivity;
}

- (CALWeChatSessionActivity *)weChatSessionActivity {
    
    CAL_GET_OBJECT(_weChatSessionActivity);
    
    _weChatSessionActivity = [[CALWeChatSessionActivity alloc] init];
    
    return _weChatSessionActivity;
}

- (CALWeChatTimelineActivity *)weChatTimelineActivity {
    
    CAL_GET_OBJECT(_weChatTimelineActivity);
    
    _weChatTimelineActivity = [[CALWeChatTimelineActivity alloc] init];
    
    return _weChatTimelineActivity;
}

- (CALTencentQQActivity *)tencentQQActivity {
    
    CAL_GET_OBJECT(_tencentQQActivity);
    
    _tencentQQActivity = [[CALTencentQQActivity alloc] init];
    
    return _tencentQQActivity;
}

- (CALTencentQZoneActivity *)tencentQZoneActivity {
    
    CAL_GET_OBJECT(_tencentQZoneActivity);
    
    _tencentQZoneActivity = [[CALTencentQZoneActivity alloc] init];
    
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
