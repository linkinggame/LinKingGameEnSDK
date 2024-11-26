//
//  LEOAEmailRegisterControllerView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOAEmailRegisterControllerView.h"
#import "LEOAEmailRegisterView.h"
#import "LEEmailApi.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "NSObject+LEAdditions.h"
#import "LEUser.h"
@interface LEOAEmailRegisterControllerView ()

@end

@implementation LEOAEmailRegisterControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showRegisterView];
   
}

- (void)showRegisterView{
    LEOAEmailRegisterView *registerView = [LEOAEmailRegisterView instanceOAEmailRegisterView];

   [self.view insertSubview:registerView atIndex:self.view.subviews.count];
   CGFloat width = 320;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    if (width > screen_width) {
        width = screen_width - 40;
    }
    registerView.translatesAutoresizingMaskIntoConstraints = NO;
    
  
    registerView.closeAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.closeViewController) {
                self.closeViewController();
            }
        }];
    };
    
    
    registerView.gotoBackAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.gotoBackViewController) {
                self.gotoBackViewController();
            }
        }];
    };
    
    
    registerView.loginEmailEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.gotoLoginEmailViewController) {
                self.gotoLoginEmailViewController();
            }
        }];
    };
    
    
    registerView.registerEmailEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email, NSString * _Nonnull code, NSString * _Nonnull password) {
        [self registerRequestEmail:email code:code password:password];
    };
    
    registerView.getVerificationCodeEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email) {
        [self getVerificationCode:email];
    };


   [self setAlterContentView:registerView];
   [self setAlterHeight:330];
   [self setAlterWidth:width];
   [self layoutConstraint];
    
    [registerView setContextView:self.view];
    
}


- (void)getVerificationCode:(NSString *)email{
    [self showMaskView];
    [LEEmailApi fetchCheckCodeRegisterEmailCode:email complete:^(NSError * _Nonnull error) {
        [self hiddenMaskView];
        if (error != nil) {
            //NSString *tip = [NSBundle le_localizedStringForKey:@"The two passwords are different"];
            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
        } else {
            NSString *tip = [NSBundle le_localizedStringForKey:@"Success"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
        }
    }];
}

- (void)registerRequestEmail:(NSString *)email code:(NSString *)code password:(NSString *)password{
    [self showMaskView];
    [LEEmailApi registerAndLoginWithEmail:email checkCode:code password:password complete:^(NSError * _Nonnull error) {
        [self hiddenMaskView];
        if (error == nil) {
            NSString *tip = [NSBundle le_localizedStringForKey:@"Login Successful"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    [self dismissViewControllerAnimated:NO completion:^{
                        if (self.registerCompleteCallBack) {
                            LEUser *user = [LEUser getUser];
                            self.registerCompleteCallBack(user, error);
                        }
                    }];
                }];
            });

        } else {
            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
        }
    }];
}


@end
