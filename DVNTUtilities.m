//
//  DVNTUtilities.m
//  DeviantArt
//
//  Created by Michael Dewey on 9/15/14.
//  Copyright (c) 2014 DeviantArt. All rights reserved.
//

#import "DVNTUtilities.h"


@implementation DVNTUtilities

#pragma mark - Misc Helpers

+ (BOOL) validateEmail:(NSString *)checkString shouldUseStrictFilter:(BOOL)isStrict {
    // Lifted from stack overflow (http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios)
    
    // Strict Vs Lax  http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = isStrict ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
