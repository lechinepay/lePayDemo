//
//  LepayRequest.h
//  LePay
//
//  Created by 马洪亮 on 16/6/6.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LePayWX.h"
#import "LePayAP.h"
#import "LePayBank.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR   @"pdp_ip0"
#define IOS_WIFI       @"en0"
#define IOS_VPN        @"utun0"
#define IP_ADDR_IPv4   @"ipv4"
#define IP_ADDR_IPv6   @"ipv6"
typedef enum {
    WxPay = 0,
    AliPay,
    BankPay,
} PayType;

typedef void(^ resultBlock)(NSDictionary * tBlock);
@interface LepayRequest : NSObject

{
    
    resultBlock _resultBlock;
}
/*
 url:微信。支付宝调起参数获取接口地址
 mchId:商户在本系统中注册时产生的唯一标识
 cmpAppId:商户在本系统登记应用产生的唯一标识
 payTypeCode:支付渠道编码
 outTradeNo:外部系统订单号(开发者传入的订单号)
 amount:交易金额(单位为分，示例值为1234.56元)
 summary:商品描述
 requestType:支付类型
*/

+ (void)LepayRequestURL:(NSString *)url
                 WithMchId:(NSString *)mchId
                 WithCmpAppId:(NSString *)cmpAppId
                 WithPayTypeCode:(NSString *)payTypeCode
                 WithOutTradeNo:(NSString *)outTradeNo
                 WithAmount:(NSString *)amount
                 WithSummary:(NSString *)summary
                 requestType:(PayType)type
                 WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;



+ (BOOL)applicationOpenURL:(NSURL *)url;
@end
