//
//  LEOABindEmailControllerView.m
//  LinKingOASDK
//
//  Created by leon on 2021/9/9.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOABindEmailControllerView.h"
#import "LEOABindEmailView.h"
#import "LEEmailApi.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "NSObject+LEAdditions.h"
#import "LEBindingApi.h"
#import "LKLog.h"
@interface LEOABindEmailControllerView ()

@end

@implementation LEOABindEmailControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showBindEmailViewView];
}

- (void)showBindEmailViewView{
    LEOABindEmailView *bindEmailView = [LEOABindEmailView instanceOAEmailBindView];
    
    [self.view insertSubview:bindEmailView atIndex:self.view.subviews.count];
    CGFloat width = 320;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    if (width > screen_width) {
        width = screen_width - 40;
    }
    bindEmailView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    bindEmailView.closeAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.closeViewController) {
                self.closeViewController();
            }
        }];
    };
    bindEmailView.bindingEmailEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email, NSString * _Nonnull code, NSString * _Nonnull password) {
        
        [self bindingEmailRequestWithEmail:email code:code password:password];
        
    };
    
    bindEmailView.getVerificationCodeEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email) {
        [self getVerificationCode:email];
    };
    
    
    [self setAlterContentView:bindEmailView];
    [self setAlterHeight:330];
    [self setAlterWidth:width];
    [self layoutConstraint];
    
    [bindEmailView setContextView:self.view];
    
}


- (void)getVerificationCode:(NSString *)email{
    [self showMaskView];
    [LEEmailApi fetchBindingEmailCode:email complete:^(NSError * _Nullable error) {
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

- (void)bindingEmailRequestWithEmail:(NSString *)email code:(NSString *)code password:(NSString *)password{
    [self showMaskView];
    
    [LEBindingApi emailBindingAccountWithEmail:email code:code password:password complete:^(NSError * _Nonnull error, LEUser * _Nonnull user) {
        [self hiddenMaskView];
        if (error == nil) {
            NSString *tip = [NSBundle le_localizedStringForKey:@"Binding success"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    
                    if (user != nil ) {
                        if (self.bindingCompleteCallBack) {
                            self.bindingCompleteCallBack(user, error);
                        }
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
                        });
                        if (self.bindingCompleteCallBack) {
                            self.bindingCompleteCallBack(user, error);
                        }
                    }
                }];
            });
        }else{
            
            NSError *errorRes = [self responserErrorMsg:error.localizedDescription code:1004];
            if (self.bindingCompleteCallBack) {
                self.bindingCompleteCallBack(nil, errorRes);
            }
            LKLogInfo(@"=====%@",[NSThread currentThread]);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
            });
            
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
