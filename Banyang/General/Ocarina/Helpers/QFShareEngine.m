//
//  PaymentAssistant.m
//  Examination
//
//  Created by gurdjieff on 13-8-24.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import "QFShareEngine.h"

#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "DataVerifier.h"

NSString *kOrderID = @"OrderID";
NSString *kTotalAmount = @"TotalAmount";
NSString *kProductDescription = @"productDescription";
NSString *kProductName = @"ProductName";
NSString *kNotifyURL = @"NotifyURL";

@implementation QFShareEngine
+(QFShareEngine *)sharePaymentAssistant
{
    static QFShareEngine * instance = nil;
    if (instance == nil) {
        instance = [[QFShareEngine alloc] init];
    }
    return instance;
}

- (void)setAliPayWithSchema:(NSString *)schema
                    partnerKey:(NSString *)partnerKey
                    sellerKey:(NSString *)sellerKey
                    RSAPrivateKey:(NSString *)RSAPrivateKey {
    _schema = schema;
    _partnerKey = partnerKey;
    _sellerKey = sellerKey;
    _RSAPrivateKey = RSAPrivateKey;
    LOG(_partnerKey);
}

+ (void)connectAliPayWithSchema:(NSString *)schema
                     partnerKey:(NSString *)partnerKey
                      sellerKey:(NSString *)sellerKey
                  RSAPrivateKey:(NSString *)RSAPrivateKey {
    QFShareEngine *share = [QFShareEngine sharePaymentAssistant];
    [share setAliPayWithSchema:schema partnerKey:partnerKey sellerKey:sellerKey RSAPrivateKey:RSAPrivateKey];
}

+ (BOOL)paymentWithInfo:(NSDictionary *)payInfo
                   type:(ShareType)type
                 result:(SEPublishContentEventHandler)result {
    QFShareEngine *share = [QFShareEngine sharePaymentAssistant];
    return [share paymentWithInfo:payInfo type:type result:result];
}

- (BOOL)paymentWithInfo:(NSDictionary *)payInfo
                   type:(ShareType)type
                 result:(SEPublishContentEventHandler)result {
    _saveCb = [result copy];
    
    NSString * orderID = payInfo[kOrderID];
    NSString * total = payInfo[kTotalAmount];
    NSString * productDescription = payInfo[kProductDescription];
    NSString * productName = payInfo[kProductName];
    NSString * notifyURL = payInfo[kNotifyURL];
    if (notifyURL == nil) {
        // 回调URL
        notifyURL = @"http://www.xxx.com";
    }
    if (orderID == nil) {
        orderID = [self generateTradeNO];
    }
    
    if (_partnerKey == 0 || _sellerKey == 0)
	{
		NSError *err = [NSError errorWithDomain:@"缺少partner或者seller。" code:-1 userInfo:nil];
        if (_saveCb) {
            _saveCb(ShareTypeAliPay, 0, err, nil, NO);
        }
		return NO;
	}
    
	Order *order = [[Order alloc] init];
	order.partner = _partnerKey;
	order.seller = _sellerKey;
    
	order.tradeNO = orderID; //订单ID（由商家自行制定）
    order.productName = productName; //@"买的一大堆商品";        //商品标题
    order.productDescription =  productDescription; //@"好东西呀,便宜！杠杠的";   //商品描述
    order.amount = total; //商品价格，测试数据，改成了一分
	order.notifyURL =  notifyURL; //回调URL
    
    NSString *appScheme = @"alisdkdemo";
    
    //	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];

    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    
	id <DataSigner> signer = CreateRSADataSigner(_RSAPrivateKey);
	NSString *signedString = [signer signString:orderSpec];
    
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
	}
    


    
    return YES;
}

/*
 *随机生成15位订单号,外部商户根据自己情况生成订单号
 */
- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init];
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}
+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
    return [[[self class] sharePaymentAssistant] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/id333206289?mt=8"]];
    }
}

@end
