//
//  TrainerViewController+TextViewDelegate.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 23/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

extension TrainerViewController :UITextFieldDelegate  {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text?.characters.count > 0 {
            actionButton.enabled = true
        } else {
            actionButton.enabled = false
        }
        
        return true
    }
}