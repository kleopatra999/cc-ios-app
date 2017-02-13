//
//  UIAlertController+RotateFix.swift
//  DeviantArt
//
//  Created by Aaron Pearce on 26/08/15.
//  Copyright (c) 2015 DeviantArt. All rights reserved.
//

import UIKit

// Fixes a crash on iOS9 where UIAlertController causes a crash as it seems to not 
// have supportedInterfaceOrientations implemented and goes into a infinite recursive loop.
// This fix forces the alerts into portrait only
// http://stackoverflow.com/questions/31406820/uialertcontrollersupportedinterfaceorientations-was-invoked-recursively
extension UIAlertController {
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    public override func shouldAutorotate() -> Bool {
        return false
    }
}

