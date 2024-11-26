//
//  LEOAForgetPasswordControllerView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOAForgetPasswordControllerView.h"
#import "LEOAForgetPasswordView.h"
#import "LEEmailApi.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "NSObject+LEAdditions.h"
@interface LEOAForgetPasswordControllerView ()

@end

@implementation LEOAForgetPasswordControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showForgetPasswordView];
}

- (void)showForgetPasswordView{
    LEOAForgetPasswordView *passwordView = [LEOAForgetPasswordView instanceOAForgetPasswordView];
    
    [self.view insertSubview:passwordView atIndex:self.view.subviews.count];
    CGFloat width = 320;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    if (width > screen_width) {
        width = screen_width - 40;
    }
    passwordView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    passwordView.closeAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.closeViewController) {
                self.closeViewController();
            }
        }];
    };
    
    passwordView.getVerificationCodeEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email) {
        [self getVerificationCodeWithEmail:email];
    };
    
    passwordView.resetEmailPasswordEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email, NSString * _Nonnull code, NSString * _Nonnull password) {
        [self resetEmailPasswordWithEmail:email code:code password:password];
    };
    
    passwordView.gotoBackAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.gotoBackViewController) {
                self.gotoBackViewController();
            }
        }];
    };
    
    
    [passwordView setContextView:self.view];
    [self setAlterContentView:passwordView];
    [self setAlterHeight:311];
    [self setAlterWidth:width];
    [self layoutConstraint];
    
}



- (void)getVerificationCodeWithEmail:(NSString *)email{
    [self showMaskView];
    [LEEmailApi fetchCheckCodeForgetPasswordEmailCode:email complete:^(NSError * _Nullable error) {
        [self hiddenMaskView];
        if (error != nil) {
            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
        } else {
            NSString *tip = [NSBundle le_localizedStringForKey:@"Success"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
        }
    }];
}

- (void)resetEmailPasswordWithEmail:(NSString *)email code:(NSString *)code password:(NSString *)password{
    [self showMaskView];
    [LEEmailApi reserPaswwordEmail:email checkCode:code password:password complete:^(NSError * _Nullable error) {
        [self hiddenMaskView];
        if (error == nil) {
            
            NSString *tip = [NSBundle le_localizedStringForKey:@"Reset Password Success"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    [self dismissViewControllerAnimated:NO completion:^{
                        if (self.gotoLoginEmailViewController) {
                            self.gotoLoginEmailViewController();
                        }
                    }];
                }];
            });
        } else {
            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
        }
    }];
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
