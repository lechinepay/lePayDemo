//
//  LePayAP.h
//  LePay
//
//  Created by 马洪亮 on 16/6/6.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "RequestHUD.h"

typedef void(^ resultBlock)(NSDictionary * tBlock);

@interface LePayAP : NSObject
{
    resultBlock _resultBlock;
}

+ (LePayAP *)sharedLePayAP;




- (void) LePayAPsendAppOrderInfo:(NSString *)appOrderInfo WithCompleteBlock:(void (^)(NSDictionary * tBlock))resultBlock;

- (BOOL)APOpenURL:(NSURL *)url;

@end
