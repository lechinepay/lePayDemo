//
//  CommonUtils.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/8/2.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonUtils : NSObject

// 根据尺寸和颜色返回image
+ (UIImage *)getCustomImage:(CGSize)size andColor:(UIColor *)color;

// 网络状态查询
+(BOOL)checkCurrentNetworkcheck;

/** 检查银行卡是否合法 (Luhn算法)*/
+ (BOOL)validateCardNumber:(NSString *)cardNumber;

/** 验证字符是否为合法的姓名*/
+ (BOOL)valiName:(NSString *)name;

/** 验证身份证是否合法*/
+ (BOOL)Chk18PaperId:(NSString *)sPaperId;

/** 验证手机号码*/
+ (BOOL)isMobileNumber:(NSString *)mobileNum;


@end
