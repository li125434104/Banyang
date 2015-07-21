//
//  AppDelegate.m
//  Banyang
//
//  Created by LXJ on 15/1/16.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMS_SDK.h>
#import "YTKNetworkConfig.h"
#import "QFShareEngine.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SMS_SDK registerApp:@"572dc4ead088" withSecret:@"32e67dabb5ed98ac683a92140af01144"];
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = SERVER_URL;
    
    //支付宝
    [self connectAliPay];

    
    return YES;
}

- (void) connectAliPay {
//    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];//获得工程目录里面的info plist文件里面的key值
//    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
//    NSString *rsaPrivateKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"];
    
    NSString *partner = @"2088011539235988";
    NSString *seller = @"2088011539235988";
    NSString *rsaPrivateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBANkMTTiA9TosjPM2bj8BhTTh+ECJGdtgqmeTMdvw3QjvH/jcVJDcdGnEF2zVEGODjTAgL/dP1AmbYkEi+QgcxMpHnvV9LDeltYNulFyAJILLSQhht6NfFIlxCSUJcTm1equNH0N1N8Rd9/htg26JX3tUDjIQZSlxPOLVr3hYKWvVAgMBAAECgYAxt6OoocGKhdHzlDBEtnBw4KIhBkap/caK2yi8nLvE5CGKu82TMSxpXcWP5G5QnT2mHHlgSSTk3nbvPLeWqCBbWW8U+DexDR5h9CIaOP+OKj61G3OWVsGM8TvhSugpFU3NZ98aNL417T763DDjniToMZHQhZ8BmRJvZXuDWh0ssQJBAPFmQ0CTX3g2JPRg8HinlwwfpOg8Vud+LF63dcOiLycXsHIneX7zvwHvdKDRtotdbPaQ6byljdEYv/TlvpihPVMCQQDmLP2w9KLj6AWwxQO/j+XrAdYro8lBXFH5RW597CsADAhPWJ1amT2TVnq91Ahc0Fubdb5X/FR6n7qD1WAobuU3AkEAznkwdrBWzSRKkXfE1v5JVMZQL49EqbYiz1TN9mnnOOGrOsiGw85KBqbAs7kMEMH1LCQguAlGdp1bumUzk6r+HwJAb9D5aOZe3zJO2WHMAVpJShH5VffaA+tyUxLcq0V4Wix+OPWGc4Wv+Qxw0hjX+yao6euYDSwiafOAaxzT+rBsnwJBAJ+6y609sYGL/0MIF2yFu9qyeUlF4qsn5W+wf7KHvFwaOnAYcdJJZ3A7AWSOTQqh4RzxL6nMUrGD9s/8SKWZU64=";
    
    [QFShareEngine connectAliPayWithSchema:@"QFAliPayDemo" partnerKey:partner sellerKey:seller RSAPrivateKey:rsaPrivateKey];//完成初始化
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;

}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
