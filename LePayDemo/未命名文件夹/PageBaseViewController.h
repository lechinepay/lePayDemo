//
//  PageBaseViewController.h
//  lePayDemo
//
//  Created by lxf_zsc on 16/8/2.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUtils.h"

#ifndef LP_STRONG
#if __has_feature(objc_arc)
#define LP_STRONG strong
#else
#define LP_STRONG retain
#endif
#endif

#ifndef LP_RELEASE
#if __has_feature(objc_arc)
#define LP_RELEASE(x) (void)(x)
#else
#define LP_RELEASE(x) [(x) release]
#endif
#endif


#ifndef LP_BLOCK
#if __has_feature(objc_arc)
#define LP_BLOCK __weak
#else
#define LP_BLOCK __block
#endif
#endif

// rgb color with hex
#define UICOLORRGB(hex)           [UIColor colorWithRed:(((hex) & 0xFF0000) >> 16)/255.0f green:(CGFloat) (((hex) & 0xFF00) >> 8)/255.0f blue:((hex) & 0xFF)/255.0f alpha:1]
#define UICOLORRGBA(hex,_alpha)    [UIColor colorWithRed:(((hex) & 0xFF0000) >> 16)/255.0f green:(CGFloat) (((hex) & 0xFF00) >> 8)/255.0f blue:((hex) & 0xFF)/255.0f alpha:_alpha]



//Access card list
#define QUERYQUICKPAYCARD  @"https://openapi.lechinepay.com/queryQuickPayCards.json?"

//Delete the bank card
#define INVALIDQUICKPAYCARD  @"https://openapi.lechinepay.com/invalidQuickBankCard.json"

//For message authentication code
#define RESEND_SMS    @"https://openapi.lechinepay.com/resend_sms.json?"

//Submit orders
#define DO_PAY_BY_QUICK   @"https://openapi.lechinepay.com/do_pay_by_quick.json?"

//The query Card information
#define QUERYBANKNAME  @"https://openapi.lechinepay.com/queryBankName.json?"

@interface PageBaseViewController : UIViewController
{
    float SizeWidth;
    float SizeHeight;
    UIColor * buttonColor;
}

@property (nonatomic,LP_STRONG) UILabel * titleLab;
@property (nonatomic,LP_STRONG) UIButton * leftBtn;


// Let the keyboard
- (void)setUpForDismissKeyboard;

// prompt
- (void)showAlertViewWithMessage:(NSString *)message;

@end
