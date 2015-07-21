//
//  NSString+OCAdditions.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//

#import <Foundation/Foundation.h>

@interface NSString (OCAdditions)

+ (NSString *)documentPathWithName:(NSString *)name;
+ (NSString *)cachesPathWithName:(NSString *)name;
+ (NSString *)tmpPathWithName:(NSString *)name;

+ (NSString *)randomString;
+ (NSString *)stringWithString:(NSString *)string duplicateCount:(int)count;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)MD5String;

- (BOOL)isValidMobileNumber;
- (BOOL)isValidEmail;

- (NSString *)trimingInSides;
- (NSString *)trimmingInMiddle;

@end
