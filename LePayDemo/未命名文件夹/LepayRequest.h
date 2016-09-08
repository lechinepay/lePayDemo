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
 buyerId:需传入用户的唯一标识符（如登录账号）
 appOrderDictionary:开发者与其服务器对接成功所返回的字典数据
 requestType:支付类型 （微信---WxPay，支付宝---AliPay，快捷支付---BankPay）
*/

+ (void)LepayRequestBuyerID:(NSString *)buyerId
               WithAppOrderDictionary:(NSDictionary *)appOrderDictionary
                 requestType:(PayType)type
                 WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;



+ (BOOL)applicationOpenURL:(NSURL *)url;
@end
