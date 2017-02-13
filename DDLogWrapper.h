//
//  DDLogWrapper.h
//
//
//  http://stackoverflow.com/a/24144858
//

@interface DDLogWrapper : NSObject
+ (void) logVerbose:(NSString *)message;
+ (void) logError:(NSString *)message;
+ (void) logInfo:(NSString *)message;
@end
