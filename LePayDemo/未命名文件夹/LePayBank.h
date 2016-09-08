//
//  LePayBank.h
//  LePay
//
//  Created by 马洪亮 on 16/7/5.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHUD.h"

typedef void(^ resultBlock)(NSDictionary * tBlock);
@interface LePayBank : NSObject <NSURLSessionDelegate>
{
    resultBlock _resultBlock;
}


+ (LePayBank *)sharedLePayBank;

/*
*/

//创建订单
/*
 buyerId:
 appOrderDictionary:
 (void (^)(NSDictionary * resultDic))resultBlock: 成功请求后的回调
*/
- (void) LePayBanksendBuyerID:(NSString *)buyerId
            WithAppOrderDictionary:(NSDictionary *)appOrderDictionary
            WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;


- (void)BankResultsCallback:(NSDictionary *)result;

@end
