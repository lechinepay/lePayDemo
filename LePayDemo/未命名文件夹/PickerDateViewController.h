//
//  PickerDateViewController.h
//  PickerViewProduct
//
//  Created by SanJin on 16-1-8.
//  Copyright (c) 2016年 SanJin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBaseViewController.h"
@interface PickerDateViewController : UIViewController

@property (nonatomic, LP_STRONG) NSString * selectedDate;
@property (nonatomic, LP_STRONG) void (^selectedBlock) (NSString * selectedDate);

@end
