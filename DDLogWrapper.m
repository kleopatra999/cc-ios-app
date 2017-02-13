//
//  DDLogWrapper.h
//
//
//  http://stackoverflow.com/a/24144858
//

#import "DDLogWrapper.h"

@implementation DDLogWrapper

+ (void) logVerbose:(NSString *)message {
    DDLogVerbose(message);
}

+ (void) logError:(NSString *)message {
    DDLogError(message);
}

+ (void) logInfo:(NSString *)message {
    DDLogInfo(message);
}

@end