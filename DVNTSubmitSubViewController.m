//
//  DVNTSubmitSubViewController.m
//  DeviantArt
//
//  Created by Aaron Pearce on 27/08/14.
//  Copyright (c) 2014 DeviantArt. All rights reserved.
//

#import "DVNTSubmitSubViewController.h"

NSInteger const DVNTSubmitTitleMaxLength = 50;

@interface DVNTSubmitSubViewController ()  <ARGS>

@end

@implementation DVNTSubmitSubViewController

// Implementing for three subclasses with titles: DVNTSubmitArtViewController, DVNTSubmitJournalViewController, DVNTSubmitLiteratureViewController
// DVNTSubmitStatusViewController never initializes titleTextField so it will never use this method
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // Prevent crashing undo bug - see http://stackoverflow.com/a/1773257/858417
    if(range.length + range.location > textField.text.length) {
        return NO;
    }
    
    // no other UITextField has a length restriction
    if ( ![textField isEqual:self.titleTextField] ) return YES;
    
    // limit titleTextField length to DVNTSubmitTitleMaxLength
    NSUInteger newLength = (textField.text).length + string.length - range.length;
    if ( newLength > DVNTSubmitTitleMaxLength ) {
        return NO;
    }
    
    // user's title will still be short enough to use
    return YES;
}

@end
