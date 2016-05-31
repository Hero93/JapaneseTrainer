//
//  AddNewWordsViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class AddNewWordsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var italianTextField: ItalianTextField!
    @IBOutlet weak var japaneseTextField: JapaneseTextField!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New word"
        
        italianTextField.delegate = self
        italianTextField.becomeFirstResponder()
        
        japaneseTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /* Observer */
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(AddNewWordsViewController.didUserChangeKeyboardLanguage(_:)),
                                                         name: UITextInputCurrentInputModeDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - TextField delegate
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
                
        // Force the textfield to always have the keyboard language associatated with the textfield (even when the user change it).
        // By reloading the textfield, the keyboard is set to the keyboard chosen in the beginning with the method "setKeyboardLanguage".
        textField.reloadInputViews()
        
        return true
    }
    
    // MARK: - Observers
    
    func didUserChangeKeyboardLanguage(parameter: NSNotification) {
        
    }
    
    // MARK: - IBActions & selectors
    
    @IBAction func doneButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    @IBAction func addWordTap(sender: UIButton) {
        
        /* validator */
        if italianTextField.text!.isEmpty || japaneseTextField.text!.isEmpty {
            Utility.showAlertViewInViewController(self, withMessage: "Input both language ^_^", timeLenght: 2.0, onDismiss: {})
            return
        }
        
        /* save word */
        let wordToSave = Word(italian: italianTextField.text!, japanese: japaneseTextField.text!)
        WordController.addWord(wordToSave)
        
        /* reset textfield */
        italianTextField.text = ""
        italianTextField.becomeFirstResponder()
        japaneseTextField.text = ""
        
        /* show alert */
        Utility.showAlertViewInViewController(self, withMessage: "Word has been added to you dictionary :)", timeLenght: 2.0, onDismiss: {})
    }
}
