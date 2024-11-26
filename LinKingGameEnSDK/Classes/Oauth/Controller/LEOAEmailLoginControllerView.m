//
//  LEOAEmailLoginControllerView.m
//  LinKingOASDK
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOAEmailLoginControllerView.h"
#import "LEOAemailLoginView.h"
#import "LEEmailApi.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "LEUser.h"
#import "NSObject+LEAdditions.h"
@interface LEOAEmailLoginControllerView ()

@end

@implementation LEOAEmailLoginControllerView

- (void)viewDidLoad {
    [super viewDidLoad];
    //dsadasdsadad
    [self showRegisterView];
}
- (void)showRegisterView{
    LEOAemailLoginView *loginView = [LEOAemailLoginView instanceOAemailLoginView];

   [self.view insertSubview:loginView atIndex:self.view.subviews.count];
   CGFloat width = 320;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    if (width > screen_width) {
        width = screen_width - 40;
    }
    loginView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    loginView.closeAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.closeViewController) {
                self.closeViewController();
            }
        }];
    };
    
    loginView.gotoBackAlterViewEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.gotoBackViewController) {
                self.gotoBackViewController();
            }
        }];
    };
    
    loginView.registerEmailEvent = ^(UIButton * _Nonnull sender) {
      
        [self dismissViewControllerAnimated:NO completion:^{
            if (self.gotoRegisterViewController) {
                self.gotoRegisterViewController();
            }
        }];
        
    };
    
    loginView.forgetPasswordEvent = ^(UIButton * _Nonnull sender) {
        [self dismissViewControllerAnimated:NO completion:^{
           
            if (self.gotoForgetPasswordViewController) {
                self.gotoForgetPasswordViewController();
            }
            
        }];
    };
    
    loginView.loginEmailEvent = ^(UIButton * _Nonnull sender, NSString * _Nonnull email, NSString * _Nonnull password) {
      
        [self requestLoginEmail:email password:password];
    };
    
    NSString *email =[[NSUserDefaults standardUserDefaults] objectForKey:@"USEREMAIL"];
    if (email.exceptNull != nil) {
        loginView.textField_Email.text = email;
    }
    
    
   [loginView setContextView:self.view];
   [self setAlterContentView:loginView];
   [self setAlterHeight:280];
   [self setAlterWidth:width];
   [self layoutConstraint];
    
}

- (void)requestLoginEmail:(NSString *)email password:(NSString *)password{
    
    [self showMaskView];
    [LEEmailApi registerAndLoginWithEmail:email checkCode:nil password:password complete:^(NSError * _Nonnull error) {
        [self hiddenMaskView];
        if (error == nil) {

            LEUser * user =[LEUser getUser];
            NSString *tip = [NSBundle le_localizedStringForKey:@"Login Successful"];
            [self.view makeToast:tip duration:2 position:CSToastPositionCenter];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:^{
                    if (self.loginEmailCompleteCallBack) {
                        self.loginEmailCompleteCallBack(user, nil);
                    }
                }];
            });

        }else {
            [self.view makeToast:error.localizedDescription duration:2 position:CSToastPositionCenter];
            if (self.loginEmailCompleteCallBack) {
                self.loginEmailCompleteCallBack(nil, error);
            }
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
