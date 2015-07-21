//
//  Ocarina.m
//  Biquu
//
//  Created by Blue on 14-6-9.
//

#import "Ocarina.h"
#import "OCTypes.h"
void OCLogPrivate(NSString *format, ...) {
    va_list args;
    va_start(args, format);
    NSString *msg = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    printf("%s\n", [msg UTF8String]);
}




