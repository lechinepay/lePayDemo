//
//  ViewController.m
//  lePayDemo
//
//  Created by 马洪亮 on 16/7/14.
//  Copyright © 2016年 lechinepay. All rights reserved.
//

#import "ViewController.h"
#import "LepayRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    float with = self.view.frame.size.width;
    UIButton * WXbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    WXbtn .frame = CGRectMake((with - 200)/2, 100, 200, 50);
    WXbtn.layer.borderWidth = 1;
    WXbtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [WXbtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [WXbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [WXbtn addTarget:self action:@selector(wxGo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:WXbtn];
    
    UIButton * APbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    APbtn .frame = CGRectMake((with - 200)/2, 180, 200, 50);
    APbtn.layer.borderWidth = 1;
    APbtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [APbtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [APbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [APbtn addTarget:self action:@selector(apGo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:APbtn];
    
    
    UIButton * bankbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bankbtn .frame = CGRectMake((with - 200)/2, 250, 200, 50);
    bankbtn.layer.borderWidth = 1;
    bankbtn.layer.borderColor = [UIColor orangeColor].CGColor;
    [bankbtn setTitle:@"银行支付" forState:UIControlStateNormal];
    [bankbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [bankbtn addTarget:self action:@selector(bankbtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bankbtn];
    
    
    
}


- (void)wxGo{
    
    
    [LepayRequest LepayRequestURL:@"http://192.168.2.133:8080/bus.api/order/add" WithMchId:@"15002" WithCmpAppId:@"14501" WithPayTypeCode:@"PT0003" WithOutTradeNo:[self generateTradeNO] WithAmount:@"0.01" WithSummary:@"测试" requestType:WxPay WithCompleteBlock:^(NSDictionary *tBlock) {
        
        NSLog(@"回调结果微信-----%@",tBlock);
    }];
    
    
}
- (void)apGo{
    
    
    
    [LepayRequest LepayRequestURL:@"http://192.168.2.133:8080/bus.api/order/add" WithMchId:@"15002" WithCmpAppId:@"14501" WithPayTypeCode:@"PT0001" WithOutTradeNo:[self generateTradeNO] WithAmount:@"0.01" WithSummary:@"测试" requestType:AliPay WithCompleteBlock:^(NSDictionary *tBlock) {
        
        NSLog(@"支付宝回调结果-----%@",tBlock);
    }];
    
    
}
- (void)bankbtn{
    [LePayBank sendRequestURL:@"http://60.191.57.82/lepay.appapi/quickpay/do_pay_by_quick_vou" WithMchId:@"15002" WithCmpAppId:@"14501" WithPayTypeCode:@"PT0010" WithoutTradeNo:[self generateTradeNO]  WithAmount:@"0.01" WithSummary:@"测试"  WithCompleteBlock:^(NSDictionary *resultDic) {
        
        
        [LePayBank sendSMSURL:@"http://60.191.57.82/lepay.appapi/quickpay/resend_sms"  WithbankCardNo:@"1234567890123" WithidName:@"马洪亮"  WithidCardNo:@"230184198903223312" Withmobile:@"18457118763" WithcardYear:@"" WithcardMonth:@"" WithcvNum:@"" WithCompleteBlock:^(NSDictionary *resultDic) {
            
            
            
            
            [LePayBank sendQuickpayURL:@"http://60.191.57.82/lepay.appapi/quickpay/do_pay_by_quick" WithverifyCode:@"123456" WithCompleteBlock:^(NSDictionary *resultDic) {
                
            } WithtFailedBlock:^(NSError *error) {
                
                
            }];
            
        } WithtFailedBlock:^(NSError *error) {
            
            
        }];
        
        
    } WithtFailedBlock:^(NSError *error) {
        
        
        
    }];
    
    
}
- (NSString *)generateTradeNO
{
    static int kNumber = 16;
    
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    //  PP_RELEASE(resultStr);
    return resultStr;
}


@end
