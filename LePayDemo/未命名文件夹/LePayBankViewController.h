//
//  LePayBankViewController.h
//  lePayDemo
//
//  Created by 马洪亮 on 16/7/28.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBaseViewController.h"


@interface LePayBankViewController : PageBaseViewController

@property (nonatomic, assign) BOOL fromCome; //判断是否从返回页面跳转回来，决定是否允许返回
@property (nonatomic, LP_STRONG) NSDictionary* appOrderDictionary;
@property (nonatomic,assign) BOOL isAdd;


@end
