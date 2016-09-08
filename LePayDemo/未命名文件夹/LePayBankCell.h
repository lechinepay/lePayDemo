//
//  LePayBankCell.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/7/28.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LePayBankCell : UITableViewCell
{
    float _SizeWidth;
}

@property (nonatomic, retain) UIImageView * backView;
@property (nonatomic, retain) UIImageView * bankImage;
@property (nonatomic, retain) UILabel * bankName;
@property (nonatomic, retain) UILabel * bankType;
@property (nonatomic, retain) UILabel * bankCardNumber;

@property (nonatomic, retain) UIView * longPressView;
@property (nonatomic, retain) UIView * partingLine;
@property (nonatomic, retain) UIButton * deleteBtn;
@property (nonatomic, retain) UIButton * cancelBtn;

@end
