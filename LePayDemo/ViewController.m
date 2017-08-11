//
//  ViewController.m
//  LePayDemo
//
//  Created by lxf_zsc on 16/8/26.
//  Copyright © 2016年 lechinePay. All rights reserved.
//

#import "ViewController.h"
#import "Lechienpay.h"
#import "AFNetworking.h"

@interface ViewController () <UITextFieldDelegate>
{
    int _money;
    NSString * _goods;
    int _selectedNum;
    NSString * _selectedType;
}
@property(nonatomic,strong)UITextField * moneyTF;
@property(nonatomic,strong)NSArray * typeArray;
@property(nonatomic,strong)UIButton * payBtn;
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    _goods = @"测试商品";
    _selectedNum = -1;
    [self buildContentView];
    
    
// ---------------------------------0x11x2--------
}

-(void)buildContentView{
    CGFloat sizeWidth = [UIScreen mainScreen].bounds.size.width;
    float left = (sizeWidth - 250) / 2;
    
    UILabel * goods = [[UILabel alloc]initWithFrame:CGRectMake(left, 120, sizeWidth - 50 * 2, 25)];
    goods.text = [NSString stringWithFormat:@"商品名称：%@", _goods];
    goods.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:goods];
    
    UILabel * price = [[UILabel alloc]initWithFrame:CGRectMake(left, CGRectGetMaxY(goods.frame) + 5, 50, 25)];
    price.text = @"单价：";
    price.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:price];
    
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 25)];
    lbl.textColor = [UIColor blackColor];
    lbl.text = @"元";
    lbl.font = [UIFont systemFontOfSize:16];
    self.moneyTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(price.frame), CGRectGetMinY(price.frame), 120, 25)];
    self.moneyTF.placeholder = @"请输入价格";
    self.moneyTF.font = [UIFont systemFontOfSize:16];
    self.moneyTF.borderStyle = UITextBorderStyleRoundedRect;
    self.moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyTF.rightViewMode = UITextFieldViewModeAlways;
    self.moneyTF.rightView = lbl;
    self.moneyTF.delegate = self;
    [self.view addSubview:self.moneyTF];
    
    float buttonY = CGRectGetMaxY(price.frame) + 30;
    self.typeArray = @[@"微信支付", @"支付宝支付", @"银行卡支付(有卡列表)", @"银行卡支付(无卡列表)"];
    for (int i = 0; i < self.typeArray.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, buttonY + 44 * i, 280 - 15 * 2, 40);
        button.center = CGPointMake(sizeWidth / 2, button.center.y);
        [button setTitle:self.typeArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectWayToPay:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor greenColor].CGColor;
        [self.view addSubview:button];
    }
    
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.payBtn.frame = CGRectMake(15, buttonY + 44 * 4 + 35, sizeWidth - 15 * 2, 40);
    [self.payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [self.payBtn setBackgroundImage:[CommonUtils getCustomImage:self.payBtn.bounds.size andColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.payBtn addTarget:self action:@selector(goToPay:) forControlEvents:UIControlEventTouchUpInside];
    self.payBtn.layer.cornerRadius = 5;
    self.payBtn.layer.masksToBounds = YES;
    self.payBtn.enabled = NO;
    [self.view addSubview:self.payBtn];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



#pragma mark - textField delegate
// demo此处限制金额最多可输入6位整数，两位小数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    NSCharacterSet * numbers;
    NSRange pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) ) {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }
    else {
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    NSString * tempStr = [textField.text stringByAppendingString:string];
    NSArray * array = [tempStr componentsSeparatedByString:@"."];
    if (array.count == 1) {
        if (tempStr.length >= 6) {
            textField.text = [tempStr substringToIndex:5];
        }
    }
    else{
        if ([array[1] length] >= 2) {
            textField.text = [NSString stringWithFormat:@"%@.%@", array[0], [array[1] substringWithRange:NSMakeRange(0, 1)]];
        }
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    // 注意：商品价格以分为单位。 0.01 * 100表示100分，即0.01元
    _money = [textField.text floatValue] * 100;
}


#pragma mark - button点击事件
-(void)selectWayToPay:(UIButton *)button {
    [self.view endEditing:YES];
    UIImage * backImage = [[UIImage imageNamed:@"LePayPicture.bundle/Bth_green"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    [self.payBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    self.payBtn.enabled = YES;
    if (_selectedNum >= 0) {
        UIButton * lastBtn = (UIButton *)[self.view viewWithTag:_selectedNum + 10];
        [lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _selectedNum = (int)button.tag - 10;
    _selectedType = self.typeArray[_selectedNum];
}


-(void)goToPay:(UIButton *)button{
    [self.view endEditing:YES];
    NSLog(@"选择的是%d-%@", _selectedNum, _selectedType);
    if (_money <= 0) {
        [self showAlertViewWithMessage:@"请输入商品价格"];
        return;
    }
    // 网络检测
    if (![CommonUtils checkCurrentNetworkcheck]) {
        return;
    }
    // 下单请求
    button.enabled = NO;
    [RequestHUD showWithMaskType:RequestHUDMaskTypeGradient];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * param = [NSDictionary dictionary];
    if ([_selectedType isEqualToString:@"微信支付"]) {
        param = @{@"version":@"1.0.0",
                  @"encoding":@"UTF-8",
                  @"signature":@"+Lepay_TEST",
                  @"reqReserved":@"+Lepay_TEST",
                  @"mchId":@"32002",
                  @"subMchId":@"+Lepay_TEST",
                  @"agentMchId":@"+Lepay_TEST",
                  @"companyId":@"+Lepay_TEST",
                  @"cmpAppId":@"35002",
                  @"payTypeCode":@"PT0003",
                  @"outTradeNo":[self generateTradeNO],
                  @"tradeTime":[[LePayWX sharedLePayWX] TradeTime],
                  @"amount":[NSString stringWithFormat:@"%d",_money],
                  @"summary":_goods,
                  @"summaryDetail":@"+Lepay_TEST",
                  @"deviceId":@"+Lepay_TEST",
                  @"deviceIp":[[LePayWX sharedLePayWX] getIPAddress:YES]
                  };
    }
    else if ([_selectedType isEqualToString:@"支付宝支付"]) {
        param = @{@"version":@"1.0.0",
                  @"encoding":@"UTF-8",
                  @"signature":@"+Lepay_TEST",
                  @"reqReserved":@"+Lepay_TEST",
                  @"mchId":@"32002",
                  @"subMchId":@"+Lepay_TEST",
                  @"agentMchId":@"+Lepay_TEST",
                  @"companyId":@"+Lepay_TEST",
                  @"cmpAppId":@"35002",
                  @"payTypeCode":@"PT0001",
                  @"outTradeNo":[self generateTradeNO],
                  @"tradeTime":[[LePayWX sharedLePayWX] TradeTime],
                  @"amount":[NSString stringWithFormat:@"%d",_money],
                  @"summary":_goods,
                  @"summaryDetail":@"+Lepay_TEST",
                  @"deviceId":@"+Lepay_TEST",
                  @"deviceIp":[[LePayWX sharedLePayWX] getIPAddress:YES]
                  };
    }
    else{
        // 注意：在银行卡支付中，若summary参数所对应的value值为中文，需设置请求头参数，否则订单完成页面显示商品名称会出现乱码
        [manger.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        param = @{@"version":@"1.0.0",
                  @"encoding":@"UTF-8",
                  @"signature":@"+Lepay_TEST",
                  @"reqReserved":@"+Lepay_TEST",
                  @"mchId":@"32002",
                  @"subMchId":@"+Lepay_TEST",
                  @"agentMchId":@"+Lepay_TEST",
                  @"companyId":@"+Lepay_TEST",
                  @"cmpAppId":@"35002",
                  @"payTypeCode":@"PT0010",
                  @"outTradeNo":[self generateTradeNO],
                  @"tradeTime":[[LePayWX sharedLePayWX] TradeTime],
                  @"amount":[NSString stringWithFormat:@"%d",_money],
                  @"summary":_goods,
                  @"summaryDetail":@"+Lepay_TEST",
                  @"deviceId":@"+Lepay_TEST",
                  @"deviceIp":[[LePayWX sharedLePayWX] getIPAddress:YES]
                  };
    }
    NSString * url = @"http://openapi.lechinepay.com/lepay.appapi/order/add.json";
    [manger POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //        NSLog(@"------------%@--------%@",operation.responseString,responseObject);
        button.enabled = YES;
        [RequestHUD dismiss];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString * buyerId = [[UIDevice currentDevice].identifierForVendor UUIDString];
        if ([dic[@"respCode"] isEqualToString:@"000000"] && dic[@"appOrderInfo"]) {
            if ([_selectedType isEqualToString:@"微信支付"]) {
                [LepayRequest LepayRequestBuyerID:buyerId WithAppOrderDictionary:dic requestType:WxPay WithCompleteBlock:^(NSDictionary *tBlock) {
                    if ([tBlock[@"result"] isEqualToString:@"Success"]) {
                        [self showAlertViewWithMessage:@"支付成功"];
                    }
                    else {
                        [self showAlertViewWithMessage:@"支付失败"];
                    }
                }];
            }
            else if ([_selectedType isEqualToString:@"支付宝支付"]) {
                [LepayRequest LepayRequestBuyerID:buyerId WithAppOrderDictionary:dic requestType:AliPay WithCompleteBlock:^(NSDictionary *tBlock) {
                    if ([tBlock[@"resultStatus"] isEqualToString:@"9000"]) {
                        [self showAlertViewWithMessage:@"支付成功"];
                    }
                    else {
                        [self showAlertViewWithMessage:@"支付失败"];
                    }
                }];
            }
            else if ([_selectedType isEqualToString:@"银行卡支付(有卡列表)"]) {
                [LepayRequest LepayRequestBuyerID:buyerId  WithAppOrderDictionary:dic requestType:BankPay WithCompleteBlock:^(NSDictionary *tBlock) {
                    [self showAlertViewWithMessage:tBlock[@"tranStatus"]];
                }];
            }
            else if ([_selectedType isEqualToString:@"银行卡支付(无卡列表)"]) {
                [LepayRequest LepayRequestBuyerID:@""  WithAppOrderDictionary:dic requestType:BankPay WithCompleteBlock:^(NSDictionary *tBlock) {
                    [self showAlertViewWithMessage:tBlock[@"tranStatus"]];
                }];
            }
        }
        else{
            [RequestHUD showErrorWithStatus:dic[@"respMsg"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        button.enabled = YES;
        [RequestHUD showErrorWithStatus:@"网络连接异常"];
        //        NSLog(@"------%@----%@",operation.responseString,error);
    }];
}



-(void)showAlertViewWithMessage:(NSString *)message{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * onClickAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
    }];
    [alertController addAction:onClickAction];
    [self presentViewController:alertController animated:YES completion:nil];
}



- (NSString *)generateTradeNO{
    static int kNumber = 16;
    
    NSString *sourceStr = @"0123456789abcdefghijklmnopqrstuvwxyz";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++){
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
