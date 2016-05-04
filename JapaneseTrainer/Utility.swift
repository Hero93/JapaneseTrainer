//
//  Utility.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

class Utility {
    
    static func showAlertViewWithMassage(message: String, inView view: UIViewController) {
        
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        view.presentViewController(alert, animated: true, completion: {})
        
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            view.dismissViewControllerAnimated(true, completion: {})
        }
    }
}

extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerate() { 
            if let to = objectToCompare as? U {
                if object == to {
                    self.removeAtIndex(idx)
                    return true
                }
            }
        }
        return false
    }
}

extension UIColor {
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func jpTrainerYellow() -> UIColor {
        return self.hexStringToUIColor("#EAA85E")
    }
    
    class func jpTrainerRed() -> UIColor {
        return self.hexStringToUIColor("#E24C4C")
    }
    
    class func jpTrainerBlack() -> UIColor {
        return self.hexStringToUIColor("#3E3942")
    }
}
