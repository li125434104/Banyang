//
//  GeneralRequestApi.m
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "GeneralRequestApi.h"

@implementation GeneralRequestApi
{
    NSString *_url;
}
- (id)initWithUrlStr: (NSString *)UrlStr {
    self = [super init];
    if (self) {
        _url = UrlStr;
    }
    return self;
}

- (NSString *)requestUrl {
    return _url;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}
@end
