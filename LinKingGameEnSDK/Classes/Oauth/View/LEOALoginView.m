//
//  LEOALoginView.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEOALoginView.h"
#import "NSBundle+LEAdditions.h"
#import "UIImage+LEAdditions.h"
#import <Toast/Toast.h>
#import "NSObject+LEAdditions.h"
@interface LEOALoginView ()
@property (nonatomic,weak) UIView *contentView;
@end

@implementation LEOALoginView

+ (instancetype)instanceOALoginView{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"LinKingGameEnSDKBundle" withExtension:@"bundle"]];
    LEOALoginView *view = [[bundle loadNibNamed:@"LEOALoginView" owner:nil options:nil] firstObject];
   view.layer.cornerRadius = 15;
   view.clipsToBounds = YES;
    
    
    view.label_or.text = [NSBundle le_localizedStringForKey:@"OR"];
    view.label_Agree.text = [NSBundle le_localizedStringForKey:@"agree"];
    [view.button_PrivacyPolicy setTitle:[NSBundle le_localizedStringForKey:@"Privacy Policy"] forState:UIControlStateNormal];
    [view.button_UserAgreement setTitle:[NSBundle le_localizedStringForKey:@"User Agreement"] forState:UIControlStateNormal];
   
   [view.button_Tourist setTitle:[NSBundle le_localizedStringForKey:@"Tourist"] forState:UIControlStateNormal];
    [view.button_Register setTitle:[NSBundle le_localizedStringForKey:@"Register"] forState:UIControlStateNormal];
   

   NSLog(@"==%@",[NSBundle le_localizedStringForKey:@"Sign in with Apple"]);
    view.label_Apple.text = [NSBundle le_localizedStringForKey:@"Sign in with Apple"];
    view.label_Facebook.text = [NSBundle le_localizedStringForKey:@"Sign in with Facebook"];
    view.label_Mail.text = [NSBundle le_localizedStringForKey:@"Mailbox login"];
   
   


    [self drawDashLine:view.view_LeftLine lineLength:3 lineSpacing:3 lineColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1]];
    
    [self drawDashLine:view.view_RightLine lineLength:3 lineSpacing:3 lineColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1]];
    
    view.view_Mail.layer.cornerRadius = 5;
    view.view_Mail.clipsToBounds = YES;
    
    view.view_Facebook.layer.cornerRadius = 5;
    view.view_Apple.clipsToBounds = YES;
    
    view.view_Apple.layer.cornerRadius = 5;
    view.view_Apple.clipsToBounds = YES;
    
    view.button_Apple.layer.cornerRadius = 5;
    view.button_Apple.clipsToBounds = YES;
    
    view.button_Mail.layer.cornerRadius = 5;
    view.button_Mail.clipsToBounds = YES;
    
    view.button_Apple.layer.cornerRadius = 5;
    view.button_Apple.clipsToBounds = YES;
    
    view.button_Register.layer.cornerRadius = 5;
    view.button_Register.clipsToBounds = YES;
    
    view.button_Tourist.layer.cornerRadius = 5;
    view.button_Tourist.clipsToBounds = YES;
    
    
    
//    view.button_Facebook.layer.cornerRadius = 8;
//    view.button_Facebook.clipsToBounds = YES;
//    view.button_Facebook.layer.borderWidth = 1;
//    view.button_Facebook.layer.borderColor = [UIColor colorWithRed:60/255.0 green:90/255.0 blue:153/255.0 alpha:1].CGColor;
//    [view.button_Facebook setBackgroundColor:[UIColor clearColor]];
//
//
//    view.button_Google.layer.cornerRadius = 8;
//    view.button_Google.clipsToBounds = YES;
//    view.button_Google.layer.borderWidth = 1;
//    view.button_Google.layer.borderColor = [UIColor colorWithRed:226/255.0 green:115/255.0 blue:16/255.0 alpha:1].CGColor;
//    [view.button_Google setBackgroundColor:[UIColor clearColor]];
//
    
    view.button_Register.layer.cornerRadius = 8;
    view.button_Register.clipsToBounds = YES;
    view.button_Register.layer.borderWidth = 1;
    view.button_Register.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    [view.button_Register setBackgroundColor:[UIColor clearColor]];
    [view.button_Register setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1] forState:UIControlStateNormal];
    
    view.button_Tourist.layer.cornerRadius = 8;
    view.button_Tourist.clipsToBounds = YES;
    view.button_Tourist.layer.borderWidth = 1;
    view.button_Tourist.layer.borderColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor;
    [view.button_Tourist setBackgroundColor:[UIColor clearColor]];
    [view.button_Tourist setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1] forState:UIControlStateNormal];

    return view;
}
- (void)setLESuperView:(UIView *)superView{
    self.contentView = superView;
}


- (IBAction)mailboxLogin:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.mailLoginEvent != nil) {
        self.mailLoginEvent(sender);
    }
    
}


- (IBAction)appleLogin:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.appleLoginEvent != nil) {
        self.appleLoginEvent(sender);
    }
}
- (IBAction)facebookLogin:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.facebookLoginEvent != nil) {
        self.facebookLoginEvent(sender);
    }
}
- (IBAction)googleLogin:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.googleLoginEvent != nil) {
        self.googleLoginEvent(sender);
    }
}

- (IBAction)gotoRegister:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.registerEvent != nil) {
        self.registerEvent(sender);
    }
}

- (IBAction)touristLogin:(UIButton *)sender {
    if (self.button_CheckBox.selected == NO) {
          [self endEditing:YES];
        NSString *tip = [NSBundle le_localizedStringForKey:@"Agreement not checked"];
         [self.contentView makeToast:tip duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.touristEvent != nil) {
        self.touristEvent(sender);
    }
}
- (IBAction)checkBox:(UIButton *)sender {
    if (self.button_CheckBox.isSelected) {
        [self.button_CheckBox setBackgroundImage:[UIImage le_ImageNamed:@"nocheckmark"] forState:UIControlStateNormal];
        
    }else{
        [self.button_CheckBox setBackgroundImage:[UIImage le_ImageNamed:@"checkmark"] forState:UIControlStateNormal];
    }

    self.button_CheckBox.selected = !sender.selected;
}
- (IBAction)userAgreement:(UIButton *)sender {
    sender.tag = 10;
    if (self.useAgreemmentCallBack) {
        self.useAgreemmentCallBack(self.button_CheckBox.isSelected, sender);
    }
}
- (IBAction)privacyPolicy:(UIButton *)sender {
    sender.tag = 20;
    if (self.useAgreemmentCallBack) {
        self.useAgreemmentCallBack(self.button_CheckBox.isSelected, sender);
    }
}
/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
  CAShapeLayer *shapeLayer = [CAShapeLayer layer];
  [shapeLayer setBounds:lineView.bounds];
  [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
  [shapeLayer setFillColor:[UIColor clearColor].CGColor];
  //  设置虚线颜色为blackColor
  [shapeLayer setStrokeColor:lineColor.CGColor];
  //  设置虚线宽度
  [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
  [shapeLayer setLineJoin:kCALineJoinRound];
  //  设置线宽，线间距
  [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
  //  设置路径
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathMoveToPoint(path, NULL, 0, 0);
  CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
  [shapeLayer setPath:path];
  CGPathRelease(path);
  //  把绘制好的虚线添加上来
  [lineView.layer addSublayer:shapeLayer];
}
- (IBAction)closeAlterView:(UIButton *)sender {
    if (self.closeAlterViewEvent) {
        self.closeAlterViewEvent(sender);
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
