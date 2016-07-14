//
//  LePayWX.h
//  WX
//
//  Created by 马洪亮 on 16/5/25.
//  Copyright © 2016年 马洪亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "RequestHUD.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#define IOS_CELLULAR   @"pdp_ip0"
#define IOS_WIFI       @"en0"
#define IOS_VPN        @"utun0"
#define IP_ADDR_IPv4   @"ipv4"
#define IP_ADDR_IPv6   @"ipv6"
typedef void(^ resultBlock)(NSDictionary * tBlock);
@interface LePayWX : NSObject<WXApiDelegate>

{
    resultBlock _resultBlock;
    
}

+ (LePayWX *)sharedLePayWX;

/*
 url:微信调起参数获取接口地址
 mchId:商户在本系统中注册时产生的唯一标识
 cmpAppId:商户在本系统登记应用产生的唯一标识
 payTypeCode:支付渠道编码
 outTradeNo:外部系统订单号(开发者传入的订单号)
 amount:交易金额(单位为分，示例值为1234.56元)
 summary:商品描述
 */
- (void) LePayWXsendRequestURL:(NSString*)url
                        WithMchId:(NSString*)mchId
                     WithCmpAppId:(NSString*)cmpAppId
                  WithPayTypeCode:(NSString*)payTypeCode
                   WithoutTradeNo:(NSString*)outTradeNo
                       WithAmount:(NSString*)amount
                      WithSummary:(NSString*)summary
 WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;


- (BOOL)WXOpenURL:(NSURL *)url;

@end
