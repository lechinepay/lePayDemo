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




- (void) LePayWXsendAppOrderInfo:(NSDictionary *)appOrderInfo
               WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;


- (BOOL)WXOpenURL:(NSURL *)url;


- (NSString *)getIPAddress:(BOOL)preferIPv4;

- (NSString *)TradeTime;
@end
