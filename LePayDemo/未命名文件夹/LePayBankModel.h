//
//  LePayBankModel.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/8/10.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageBaseViewController.h"

@interface LePayBankModel : NSObject

@property(nonatomic, LP_STRONG) NSString * bankCardNo;
@property(nonatomic, LP_STRONG) NSString * bankName;
@property(nonatomic, LP_STRONG) NSString * bindingId;
@property(nonatomic, LP_STRONG) NSString * dbcr;
@property(nonatomic, LP_STRONG) NSString * phoneLastFour;


+(id)bankListWithBankListDictionary:(NSDictionary*)dic;

@end
