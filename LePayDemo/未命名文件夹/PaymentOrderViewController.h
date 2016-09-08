//
//  PaymentOrderViewController.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/7/29.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBaseViewController.h"

@interface PaymentOrderViewController : PageBaseViewController

@property (nonatomic ,LP_STRONG) NSString * bindingIdStr;
@property (nonatomic ,LP_STRONG) NSString * payTypeTradeNoStr;

@property (nonatomic, LP_STRONG) NSString * phone;
@property (nonatomic, LP_STRONG) NSString * typeChoose;
@property (nonatomic ,LP_STRONG) NSDictionary * appOrderDictionary;
@property (nonatomic ,LP_STRONG) NSDictionary * PersonalInfo;
@end
