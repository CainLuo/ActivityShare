//
//  ViewController.m
//  activityControllerDemo
//
//  Created by Cain on 5/20/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "ViewController.h"
#import "CALActivityController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *shareTitle;
@property (weak, nonatomic) IBOutlet UITextField *shareContent;
@property (weak, nonatomic) IBOutlet UIButton *activityButton;

@property (nonatomic, strong) CALActivityController *activityController;

@property (nonatomic, strong) NSArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *textItem = self.shareTitle.text;
    UIImage *imageToShare = [UIImage imageNamed:@"Icon-60"];
    
    self.items = @[textItem, imageToShare];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)presentAction:(UIButton *)sender {
    [self.view endEditing:YES];

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"好"
                                              otherButtonTitles:nil, nil];
    

    if (self.shareTitle.text.length <= 0) {
        
        alertView.message = @"您尚未输入需要分享的标题, 请稍后重试.";
        [alertView show];
        
        return;
    }
    
    if (self.shareContent.text.length <= 0) {

        alertView.message = @"您尚未输入需要分享的内容, 请稍后重试.";

        [alertView show];
        
        return;
    }
    
    UIPopoverPresentationController *popover = self.activityController.popoverPresentationController;
    
    if (popover) {
        
        popover.sourceView = self.activityButton;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    
    [self presentViewController:self.activityController animated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 0) {

        self.activityController.customShareMessage.shareTitle = [NSString stringWithFormat:@"标题: %@", textField.text];
    } else {
     
        self.activityController.customShareMessage.shareDescription = [NSString stringWithFormat:@"介绍内容: %@", textField.text];
    }
}

- (CALActivityController *)activityController {

    CAL_GET_OBJECT(_activityController);
    
    _activityController = [[CALActivityController alloc] initAspActivityControllerWithContent:self.items];
    
    _activityController.customShareMessage.shareLink = @"http://www.apple.com.cn";

    _activityController.customShareMessage.shareImage     = [UIImage imageNamed:@"Icon-60"];
    _activityController.customShareMessage.shareThumbnail = [UIImage imageNamed:@"Icon-60"];
    
    return _activityController;
}

@end