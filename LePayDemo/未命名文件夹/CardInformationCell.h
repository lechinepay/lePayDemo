//
//  CardInformationCell.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/7/29.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageBaseViewController.h"
@interface CardInformationCell : UITableViewCell

@property (nonatomic, retain) UITextField * textfield;


+ (NSString *)reuseId;

@end
