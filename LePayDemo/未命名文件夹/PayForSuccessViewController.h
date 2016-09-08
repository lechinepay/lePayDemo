//
//  PayForSuccessViewController.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/8/2.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import "PageBaseViewController.h"

@interface PayForSuccessViewController : PageBaseViewController

@property (nonatomic, LP_STRONG) NSDictionary * appOrderDictionary;
@property (nonatomic, LP_STRONG) NSDictionary * appOrderResult;
@property (nonatomic, LP_STRONG) NSString * payTypeTradeNo;

@end
