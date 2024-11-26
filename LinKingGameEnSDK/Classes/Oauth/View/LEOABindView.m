//
//  LEOABindView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOABindView.h"
#import <Toast/Toast.h>
#import "NSBundle+LEAdditions.h"
#import "UIButton+LKCountDown.h"
@interface LEOABindView ()
@property(nonatomic, strong) UIView *contentView;
@end

@implementation LEOABindView

+ (instancetype)instanceOABindView{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"LinKingOASDKBundle" withExtension:@"bundle"]];
    LEOABindView *view = [[bundle loadNibNamed:@"LEOABindView" owner:nil options:nil] firstObject];
   view.layer.cornerRadius = 15;
   view.clipsToBounds = YES;
    
    view.button_Mailbox.layer.cornerRadius = 5;
    view.button_Mailbox.clipsToBounds = YES;
    
    view.button_Apple.layer.cornerRadius = 5;
    view.button_Apple.clipsToBounds = YES;
    
    view.button_Facebook.layer.cornerRadius = 5;
    view.button_Facebook.clipsToBounds = YES;
    
    view.label_TipOne.text = [NSBundle le_localizedStringForKey:@"Bind your linking account"];
    view.label_TipTwo.text = [NSBundle le_localizedStringForKey:@"Choose your platform"];
    [view.button_Mailbox setTitle:[NSBundle le_localizedStringForKey:@"Mailbox"] forState:UIControlStateNormal];
    [view.button_Apple setTitle:[NSBundle le_localizedStringForKey:@"Apple"] forState:UIControlStateNormal];
    [view.button_Facebook setTitle:[NSBundle le_localizedStringForKey:@"Facebook"] forState:UIControlStateNormal];
    return view;
}

- (void)setContextView:(UIView *)contextView {
    self.contentView = contextView;
}
- (IBAction)touchEvent:(UIButton *)sender {
    
    if (sender.tag == 10) { // 邮箱
        
    } else if (sender.tag == 20) { // Apple
        
    } else if (sender.tag == 30) { // Facebook
        
    } else if (sender.tag == 40) { // Google
        
    }
    if (self.bindStyleAction) {
        self.bindStyleAction(sender);
    }
}
- (IBAction)closeAlterView:(UIButton *)sender {
    if (self.closeAlterViewEvent) {
        self.closeAlterViewEvent(sender);
    }
}

- (IBAction)gotoBack:(UIButton *)sender {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
