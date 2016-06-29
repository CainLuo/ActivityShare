//
//  ViewController.m
//  ActivityViewControllerDemo
//
//  Created by Cain on 5/20/16.
//  Copyright © 2016 Cain. All rights reserved.
//

#import "ViewController.h"
#import "AspActivityViewController.h"

#define CAL_GET_OBJECT(objc) if (objc) return objc

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *shareTitle;
@property (weak, nonatomic) IBOutlet UITextField *shareContent;

@property (nonatomic, strong) AspActivityViewController *activityViewController;

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
    
    [self presentViewController:self.activityViewController animated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 0) {

        self.activityViewController.customShareMessage.shareTitle = [NSString stringWithFormat:@"标题: %@", textField.text];
    } else {
     
        self.activityViewController.customShareMessage.shareDescription = [NSString stringWithFormat:@"介绍内容: %@", textField.text];
    }
}

- (AspActivityViewController *)activityViewController {

    CAL_GET_OBJECT(_activityViewController);
    
    _activityViewController = [[AspActivityViewController alloc] initAspActivityControllerWithContent:self.items];
    
    _activityViewController.customShareMessage.shareLink = @"http://www.apple.com.cn";

    _activityViewController.customShareMessage.shareImage     = [UIImage imageNamed:@"Icon-60"];
    _activityViewController.customShareMessage.shareThumbnail = [UIImage imageNamed:@"Icon-60"];
    
    return _activityViewController;
}

@end