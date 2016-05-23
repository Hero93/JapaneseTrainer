//
//  Utility.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

class Utility {
    
    static func showYesNoAlertView(message message: String, textYes: String, textNo: String, view: UIViewController, onYes:()-> Void, onNo: () -> Void) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Bepooler", message: message, preferredStyle: .Alert)
        
        // cancel action
        var cancelText = ""
        if textNo.characters.count > 0 {
            cancelText = textNo
        } else {
            cancelText = NSLocalizedString("no", comment: "")
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: cancelText, style: .Cancel) { action -> Void in
            onNo()
        }
        
        // yes action
        var okText = ""
        if textYes.characters.count > 0 {
            okText = textYes
        } else {
            okText = NSLocalizedString("yes", comment: "")
        }
        let yesAction: UIAlertAction = UIAlertAction(title: okText, style: .Default) { action -> Void in
            onYes()
        }
        
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(yesAction)
        
        //Present the AlertController
        view.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    static func showAlertViewInViewController(viewController: UIViewController, withMessage message: String, timeLenght: Double, onDismiss: () -> Void) {
        
        let alert = UIAlertController(title: "Japanese Trainer", message: message, preferredStyle: .Alert)
        viewController.presentViewController(alert, animated: true, completion: {})
        
        alert.view.tintColor = UIColor.blackColor()
        let delay = timeLenght * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            viewController.dismissViewControllerAnimated(true, completion: {onDismiss()})
        }
    }
}

extension Array {
    
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
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
