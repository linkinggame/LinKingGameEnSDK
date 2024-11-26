//
//  LEOAForgetPasswordView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOAForgetPasswordView.h"
#import "NSObject+LEAdditions.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "UIButton+LKCountDown.h"
#import "UIImage+LEAdditions.h"
@interface LEOAForgetPasswordView ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation LEOAForgetPasswordView
+ (instancetype)instanceOAForgetPasswordView{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"LinKingOASDKBundle" withExtension:@"bundle"]];
    LEOAForgetPasswordView *view = [[bundle loadNibNamed:@"LEOAForgetPasswordView" owner:nil options:nil] firstObject];
   view.layer.cornerRadius = 15;
   view.clipsToBounds = YES;
    
    
    
    view.textField_Code.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_Email.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_Email.keyboardType = UIKeyboardTypeEmailAddress;
    view.textField_Password.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_SurePassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    view.textField_Password.secureTextEntry = YES;
    view.textField_SurePassword.secureTextEntry = YES;
    
   
    view.textField_Code.keyboardType = UIKeyboardTypeNumberPad;
    
    
    view.button_Reset.layer.cornerRadius = 5;
    view.button_Reset.clipsToBounds = YES;
    view.button_GetCode.layer.cornerRadius = 5;
    view.button_GetCode.clipsToBounds = YES;

    view.button_Eye.selected = YES;
    view.button_SureEye.selected = YES;

    [view.button_Reset setTitle:[NSBundle le_localizedStringForKey:@"Reset"] forState:UIControlStateNormal];
    view.label_TopTip.text = [NSBundle le_localizedStringForKey:@"Forgot password"];
    [view.button_GetCode setTitle:[NSBundle le_localizedStringForKey:@"Verification Code"] forState:UIControlStateNormal];
    view.textField_Email.placeholder = [NSBundle le_localizedStringForKey:@"Please enter your email account"];
    view.textField_Code.placeholder = [NSBundle le_localizedStringForKey:@"Enter verification code"];
    view.textField_Password.placeholder = [NSBundle le_localizedStringForKey:@"Set Password"];
    view.textField_SurePassword.placeholder = [NSBundle le_localizedStringForKey:@"Set Password again"];

    return view;
}

- (void)setContextView:(UIView *)contextView {
    self.contentView = contextView;
}
- (IBAction)getEmailCode:(UIButton *)sender {
    if (self.textField_Email.text.exceptNull == nil) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter your email account"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    
    NSString *randomKey = [NSString stringWithFormat:@"password-%ld",time(0)];
    NSString *regain = [NSBundle le_localizedStringForKey:@"Regain"];
    NSString *verificationCode = [NSBundle le_localizedStringForKey:@"Verification Code"];
    [sender startWithScheduledCountDownWithKey:randomKey WithTime:60 title:verificationCode countDownTitle:regain mainColor:[UIColor colorWithRed:41/255.0 green:95/255.0 blue:207/255.0 alpha:1] countColor:[UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1] complete:^{
        // 倒计时结束
    }];
    if (self.getVerificationCodeEvent) {
        self.getVerificationCodeEvent(sender, self.textField_Email.text);
    }
}

- (IBAction)showPasswordEye:(UIButton *)sender {
    if (sender.selected) {
        self.textField_Password.secureTextEntry = NO;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_hight_icon"] forState:UIControlStateNormal];
    }else {
        self.textField_Password.secureTextEntry = YES;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_icon"] forState:UIControlStateNormal];
    }
    
    sender.selected = !sender.selected;
}

- (IBAction)showSurePasswordEye:(UIButton *)sender {
    if (sender.selected) {
        self.textField_SurePassword.secureTextEntry = NO;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_hight_icon"] forState:UIControlStateNormal];
    }else {
        self.textField_SurePassword.secureTextEntry = YES;
        [self.button_Eye setImage:[UIImage le_ImageNamed:@"eye_icon"] forState:UIControlStateNormal];
    }
    
    sender.selected = !sender.selected;
}

- (IBAction)resetPasswordEmail:(UIButton *)sender {
    [self endEditing:YES];
    
    if (self.textField_Email.text.exceptNull == nil) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter your email account"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.textField_Code.text.exceptNull == nil) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"Please enter verification code"];
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
    
    if (![self.textField_Password.text isEqualToString:self.textField_SurePassword.text]) {
        NSString *tip = [NSBundle le_localizedStringForKey:@"The two passwords are different"];
        [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    
    
    if (self.resetEmailPasswordEvent) {
        self.resetEmailPasswordEvent(sender ,self.textField_Email.text, self.textField_Code.text, self.textField_Password.text);
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

@end
