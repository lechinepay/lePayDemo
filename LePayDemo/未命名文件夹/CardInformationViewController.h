//
//  CardInformationViewController.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/7/29.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBaseViewController.h"

@interface CardInformationViewController : PageBaseViewController

@property (nonatomic,assign) BOOL typeCC; // 判断是否为信用卡
@property (nonatomic,LP_STRONG) NSString * cardNumber;
@property (nonatomic ,LP_STRONG) NSDictionary* cardDictionary;
@property (nonatomic ,LP_STRONG) NSDictionary* appOrderDictionary;

@end
