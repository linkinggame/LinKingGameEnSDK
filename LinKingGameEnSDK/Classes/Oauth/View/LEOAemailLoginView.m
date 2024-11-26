//
//  LEOAemailLoginView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOAemailLoginView.h"
#import "NSObject+LEAdditions.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "UIButton+LKCountDown.h"
#import "UIImage+LEAdditions.h"
@interface LEOAemailLoginView ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation LEOAemailLoginView

+ (instancetype)instanceOAemailLoginView{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"LinKingGameEnSDKBundle" withExtension:@"bundle"]];
    LEOAemailLoginView *view = [[bundle loadNibNamed:@"LEOAemailLoginView" owner:nil options:nil] firstObject];
   view.layer.cornerRadius = 15;
   view.clipsToBounds = YES;
    
    view.textField_Password.secureTextEntry = YES;
    view.textField_Password.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_Email.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_Email.keyboardType = UIKeyboardTypeEmailAddress;
    
    view.button_Login.layer.cornerRadius = 5;
    view.button_Login.clipsToBounds = YES;
    
    view.button_Eye.selected = YES;
    
    
    [view.button_Register setTitle:[NSBundle le_localizedStringForKey:@"Register"] forState:UIControlStateNormal];
    view.label_Tip.text = [NSBundle le_localizedStringForKey:@"Login now"];
    view.textField_Email.placeholder = [NSBundle le_localizedStringForKey:@"Please enter your email account"];
    view.textField_Password.placeholder = [NSBundle le_localizedStringForKey:@"Please enter password"];
    [view.button_Forget setTitle:[NSBundle le_localizedStringForKey:@"Forgot password"] forState:UIControlStateNormal];
    view.label_bottom_Tip.text = [NSBundle le_localizedStringForKey:@"Don't have an account! Register"];
    [view.button_Login setTitle:[NSBundle le_localizedStringForKey:@"Login"] forState:UIControlStateNormal];
    
    return view;
}
- (void)setContextView:(UIView *)contextView {
    self.contentView = contextView;
}
- (IBAction)showPassword:(UIButton *)sender {
    
    if (sender.selected) {
        self.textField_Password.secureTextEntry = NO;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_hight_icon"] forState:UIControlStateNormal];
    }else {
        self.textField_Password.secureTextEntry = YES;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_icon"] forState:UIControlStateNormal];
    }
    
    sender.selected = !sender.selected;
}

- (IBAction)goToRegister:(id)sender {
    
    if (self.registerEmailEvent) {
        self.registerEmailEvent(sender);
    }
}

- (IBAction)forgetPassword:(id)sender {
    
    if (self.forgetPasswordEvent) {
        self.forgetPasswordEvent(sender);
    }
    
}

- (IBAction)loginEmailAction:(id)sender {
    
    if (self.textField_Email.text.exceptNull == nil) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter your email account"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.textField_Password.text.exceptNull == nil) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter password"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    
    if (self.textField_Password.text.length < 6 || self.textField_Password.text.length >= 20) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter valid password of 6 to 20 characters"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    
    
    if (self.loginEmailEvent) {
        self.loginEmailEvent(sender, self.textField_Email.text, self.textField_Password.text);
    }
}

- (IBAction)closeAlterView:(UIButton *)sender {
    if (self.closeAlterViewEvent) {
        self.closeAlterViewEvent(sender);
    }
}
- (IBAction)gotoBack:(id)sender {
    
    if (self.gotoBackAlterViewEvent) {
        self.gotoBackAlterViewEvent(sender);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
