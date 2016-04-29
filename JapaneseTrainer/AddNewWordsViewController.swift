//
//  AddNewWordsViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class AddNewWordsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var languageSegment: UISegmentedControl!
    @IBOutlet weak var italianTextField: ManyLanguagesTextField!
    @IBOutlet weak var japaneseTextField: ManyLanguagesTextField!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        italianTextField.delegate = self
        italianTextField?.setKeyboardLanguage(Constants.KeyboardLanguage.Italian.rawValue as String)
        italianTextField.becomeFirstResponder()
        
        japaneseTextField.delegate = self
        japaneseTextField?.setKeyboardLanguage(Constants.KeyboardLanguage.Japanese.rawValue as String)
        
        /* Observer */
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(AddNewWordsViewController.didUserChangeKeyboardLanguage(_:)),
                                                         name: UITextInputCurrentInputModeDidChangeNotification, object: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let manyLanguageTextField = textField as? ManyLanguagesTextField
        
        // Force the textfield to always have the keyboard language associatated with the textfield (even when the user change it)
        
        if italianTextField == textField {
            manyLanguageTextField?.setKeyboardLanguage(Constants.KeyboardLanguage.Italian.rawValue as String)
        } else {
            manyLanguageTextField?.setKeyboardLanguage(Constants.KeyboardLanguage.Japanese.rawValue as String)
        }
        
        manyLanguageTextField?.reloadInputViews()
        
        return true
    }
    
    func didUserChangeKeyboardLanguage(parameter: NSNotification) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
