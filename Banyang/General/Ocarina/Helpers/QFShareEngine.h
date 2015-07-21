//
//  PaymentAssistant.h
//  Examination
//
//  Created by gurdjieff on 13-8-24.
//  Copyright (c) 2013年 gurd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kOrderID;
extern NSString *kTotalAmount;
extern NSString *kProductDescription;
extern NSString *kProductName;
extern NSString *kNotifyURL;

typedef unsigned int ShareType;
typedef unsigned int ShareStatus;
typedef void(^SEPublishContentEventHandler) (ShareType type, ShareStatus status, NSError *error, NSData *data, BOOL end);

#define ShareTypeAliPay 100

@interface QFShareEngine : NSObject {
    NSString *_schema;
    NSString *_partnerKey;
    NSString *_sellerKey;
    NSString *_RSAPrivateKey;
    
    SEPublishContentEventHandler _saveCb;
}
+ (QFShareEngine *)sharePaymentAssistant;


/*
     NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
 NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];

 	id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
*/

+ (void)connectAliPayWithSchema:(NSString *)schema
                        partnerKey:(NSString *)partnerKey
                        sellerKey:(NSString *)sellerKey
                        RSAPrivateKey:(NSString *)RSAPrivateKey;



+ (BOOL)paymentWithInfo:(NSDictionary *)payInfo
            type:(ShareType)type
            result:(SEPublishContentEventHandler)result;

+ (BOOL)handleOpenURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation;

@end
