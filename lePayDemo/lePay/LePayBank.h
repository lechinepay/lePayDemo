//
//  LePayBank.h
//  LePay
//
//  Created by 马洪亮 on 16/7/5.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHUD.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR   @"pdp_ip0"
#define IOS_WIFI       @"en0"
#define IOS_VPN        @"utun0"
#define IP_ADDR_IPv4   @"ipv4"
#define IP_ADDR_IPv6   @"ipv6"

@interface LePayBank : NSObject

/*
快捷支付的流程：创建订单-----> 成功 ------> 获取验证码 -----> 成功 ------> 提交订单 -------> 成功
*/

//创建订单
/*
 url:创建订单接口地址
 mchId:商户在本系统中注册时产生的唯一标识
 cmpAppId:商户在本系统登记应用产生的唯一标识
 payTypeCode:支付渠道编码
 outTradeNo:外部系统订单号(开发者传入的订单号)
 amount:交易金额(单位为分，示例值为1234.56元)
 summary:商品描述
 (void (^)(NSDictionary * resultDic))resultBlock: 成功请求后的回调
  WithtFailedBlock:(void (^)(NSError * error))tFailedBlock : 请求失败
*/
+ (void) sendRequestURL:(NSString*)url
                WithMchId:(NSString*)mchId
                WithCmpAppId:(NSString*)cmpAppId
                WithPayTypeCode:(NSString*)payTypeCode
                WithoutTradeNo:(NSString*)outTradeNo
                WithAmount:(NSString*)amount
                WithSummary:(NSString*)summary
                WithCompleteBlock:(void (^)(NSDictionary * resultDic))resultBlock
                WithtFailedBlock:(void (^)(NSError * error))tFailedBlock;

//发送验证码
/*
 url:获取验证码接口地址
 bankCardNo:银行卡号
 idName:持卡人姓名
 idCardNo:持卡人身份证号
 mobile:持卡人手机号
 cardYear:有效年份 （信用卡有效年份（非信用卡时可为空））
 cardMonth:有效月份 （信用卡有效月份（非信用卡时可为空））
 cvNum:信用卡验证号（信用卡背面3位数字（非信用卡时可为空））
 (void (^)(NSDictionary * resultDic))resultBlock: 成功请求后的回调
 WithtFailedBlock:(void (^)(NSError * error))tFailedBlock : 请求失败
 */
+ (void) sendSMSURL:(NSString*)url
                WithbankCardNo:(NSString*)bankCardNo
                WithidName:(NSString*)idName
                WithidCardNo:(NSString*)idCardNo
                Withmobile:(NSString*)mobile
                WithcardYear:(NSString*)cardYear
                WithcardMonth:(NSString*)cardMonth
                WithcvNum:(NSString*)cvNum
                WithCompleteBlock:(void (^)(NSDictionary * resultDic))resultBlock
                WithtFailedBlock:(void (^)(NSError * error))tFailedBlock;

//提交订单
/*
 url:提交订单接口地址
 verifyCode：短信验证码
(void (^)(NSDictionary * resultDic))resultBlock: 成功请求后的回调
 WithtFailedBlock:(void (^)(NSError * error))tFailedBlock : 请求失败
 */
+ (void) sendQuickpayURL:(NSString*)url
                WithverifyCode:(NSString*)verifyCode
                WithCompleteBlock:(void (^)(NSDictionary * resultDic))resultBlock
                WithtFailedBlock:(void (^)(NSError * error))tFailedBlock;


@end
