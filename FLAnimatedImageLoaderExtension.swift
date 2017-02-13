//
//  FLAnimatedImageLoaderExtension.swift
//  DeviantArt
//
//  Created by Aaron Pearce on 17/11/15.
//  Copyright © 2015 DeviantArt. All rights reserved.
//

import Foundation
import ImageIO

/* Note: Sometimes you can get caching issues within SDWebImage which causes it to think a GIF is a PNG, still looking into workarounds to recover from this. */
extension FLAnimatedImageView {
    private struct AssociatedKeys {
        static var isGifKey = "isGifKey"
    }
    
    //http://stackoverflow.com/questions/17828044/is-it-possible-to-find-the-file-extension-of-a-uiimage
    public var isGIF: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isGifKey) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isGifKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}