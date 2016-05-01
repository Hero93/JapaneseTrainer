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

