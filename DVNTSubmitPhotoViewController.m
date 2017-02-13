//
//  DVNTSubmitPhotoViewController.m
//  DeviantArt
//
//  Created by Aaron Pearce on 30/07/14.
//  Copyright (c) 2014 DeviantArt. All rights reserved.
//

#import "DVNTSubmitPhotoViewController.h"

@interface DVNTSubmitPhotoViewController () <UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation DVNTSubmitPhotoViewController

#pragma mark - UIImagePickerController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
#warning [Pickley] Uploading huge pngs here. Not good.
    // see http://stackoverflow.com/questions/4314405/how-can-i-get-the-name-of-image-picked-through-photo-library-in-iphone to upload correct image type
    
    [self dismissViewControllerAnimated:YES completion:^{
         [self setImage:image toViewModel:YES];
    }];
}

@end
