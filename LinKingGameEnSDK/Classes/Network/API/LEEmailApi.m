//
//  LEEmailApi.m
//  LinKingOASDK_Example
//
//  Created by leon on 2021/9/8.
//  Copyright © 2021 dml1630@163.com. All rights reserved.
//

#import "LEEmailApi.h"
#import "LENetWork.h"
#import "LEUser.h"
#import "LELanguage.h"
#import "LESystem.h"
#import "LKLog.h"
@implementation LEEmailApi

// /login/email_login_code

/// 获取注册验证码
+ (void)fetchCheckCodeRegisterEmailCode:(NSString *)email complete:(void(^)(NSError *error))complete{
    
     NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],@"login/email_login_code"];
    
     NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self defaultParames]];
     
    [parameters setObject:email forKey:@"email"];
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];
//    [headers setObject:[LELanguage instance].preferredLanguage forKey:@"LK_LANGUAGE"];
    [LENetWork postWithURLString:url parameters:parameters HTTPHeaderField:headers success:^(id  _Nonnull responseObject) {

        NSNumber *success = responseObject[@"success"];
        NSString *desc = responseObject[@"desc"];
         NSString *errorCode = responseObject[@"code"];
        if ([success boolValue] == YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(nil);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
               complete([self responserErrorMsg:desc code:[errorCode intValue]]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(error);
        });
    }];
    
    return;
}


/**
 /login/phone_login  private String email;
 private String code;
 private String pwd;
 */

+ (void)registerAndLoginWithEmail:(NSString *)email checkCode:(NSString * __nullable)code password:(NSString *)password complete:(void(^)(NSError *error))complete{

         NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],@"login/email_login"];
         NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self defaultParames]];
         [parameters setObject:email forKey:@"email"];
         [parameters setObject:password forKey:@"pwd"];
         if (code != nil) {
             [parameters setObject:code forKey:@"code"];
         }
        NSMutableDictionary *headers = [NSMutableDictionary dictionary];
    
        [LENetWork postWithURLString:url parameters:parameters HTTPHeaderField:headers success:^(id  _Nonnull responseObject) {
            NSNumber *success = responseObject[@"success"];
            NSString *desc = responseObject[@"desc"];
            NSDictionary *data = responseObject[@"data"];
            NSString *errorCode = responseObject[@"code"];
            if ([success boolValue] == YES) {
                LEUser *user = [[LEUser alloc] initWithDictionary:data[@"user"]];
                if (user != nil) {
                    // 将用户信息存储到本地
                    if (password != nil) {
                        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"USERPASSWORD"];
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"USEREMAIL"];
                    [LEUser setUser:user];
                }

                dispatch_async(dispatch_get_main_queue(), ^{
                      if (complete) {
                          complete(nil);
                      }
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    complete([self responserErrorMsg:desc code:[errorCode intValue]]);
                });
            }
        } failure:^(NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(error);
            });
        }];
    
}


// /user/rs/email_pwd_code
+ (void)fetchCheckCodeForgetPasswordEmailCode:(NSString *)email complete:(void(^)(NSError *error))complete{
    NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],@"user/rs/email_pwd_code"];
   
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self defaultParames]];
    
   [parameters setObject:email forKey:@"email"];
   NSMutableDictionary *headers = [NSMutableDictionary dictionary];
//    [headers setObject:[LELanguage instance].preferredLanguage forKey:@"LK_LANGUAGE"];
   [LENetWork postWithURLString:url parameters:parameters HTTPHeaderField:headers success:^(id  _Nonnull responseObject) {

       NSNumber *success = responseObject[@"success"];
       NSString *desc = responseObject[@"desc"];
        NSString *errorCode = responseObject[@"code"];
       if ([success boolValue] == YES) {
           dispatch_async(dispatch_get_main_queue(), ^{
               complete(nil);
           });
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
              complete([self responserErrorMsg:desc code:[errorCode intValue]]);
           });
       }
   } failure:^(NSError * _Nonnull error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           complete(error);
       });
   }];
   

}
+ (void)reserPaswwordEmail:(NSString *)email checkCode:(NSString *)code password:(NSString *)password complete:(void(^)(NSError *error))complete {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],@"user/rs/email_pwd"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self defaultParames]];
    [parameters setObject:email forKey:@"email"];
    [parameters setObject:password forKey:@"pwd"];
    [parameters setObject:code forKey:@"code"];
   NSMutableDictionary *headers = [NSMutableDictionary dictionary];

   [LENetWork postWithURLString:url parameters:parameters HTTPHeaderField:headers success:^(id  _Nonnull responseObject) {
       NSNumber *success = responseObject[@"success"];
       NSString *desc = responseObject[@"desc"];
       NSString *errorCode = responseObject[@"code"];
       if ([success boolValue] == YES) {

           dispatch_async(dispatch_get_main_queue(), ^{
                 if (complete) {
                     complete(nil);
                 }
           });
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
               complete([self responserErrorMsg:desc code:[errorCode intValue]]);
           });
       }
   } failure:^(NSError * _Nonnull error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           complete(error);
       });
   }];
}


+ (void)fetchBindingEmailCode:(NSString *)email complete:(void(^)(NSError * __nullable error))complete{
    NSString *url = [NSString stringWithFormat:@"%@%@",[self baseURL],@"login/email_binding_code"];
   
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[self defaultParames]];
    
   [parameters setObject:email forKey:@"email"];
   NSMutableDictionary *headers = [NSMutableDictionary dictionary];
//    [headers setObject:[LELanguage instance].preferredLanguage forKey:@"LK_LANGUAGE"];
   [LENetWork postWithURLString:url parameters:parameters HTTPHeaderField:headers success:^(id  _Nonnull responseObject) {

       NSNumber *success = responseObject[@"success"];
       NSString *desc = responseObject[@"desc"];
        NSString *errorCode = responseObject[@"code"];
       if ([success boolValue] == YES) {
           dispatch_async(dispatch_get_main_queue(), ^{
               complete(nil);
           });
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
              complete([self responserErrorMsg:desc code:[errorCode intValue]]);
           });
       }
   } failure:^(NSError * _Nonnull error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           complete(error);
       });
   }];
}

@end
