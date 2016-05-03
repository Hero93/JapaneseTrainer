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
        
        // Search definition
    
//        UIReferenceLibraryViewController *controller = [[UIReferenceLibraryViewController alloc] initWithTerm:term];
//        [self presentViewController:controller animated:YES completion:^{
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            }];
        
        return true
    }
    
    func didUserChangeKeyboardLanguage(parameter: NSNotification) {
        
    }
    
    // MARK: - IBActions & selectors
    
    @IBAction func doneButtonTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    @IBAction func addWordTap(sender: UIButton) {
        
        /* validator */
        if italianTextField.text!.isEmpty || japaneseTextField.text!.isEmpty {
            Utility.showAlertViewWithMassage("Inserisci tutti i valori ^_^", inView: self)
            return
        }
        
        /* save word */
        let wordToSave = Word(italian: italianTextField.text!, japanese: japaneseTextField.text!)
        WordsDatabase.saveWord(wordToSave)
        
        /* dismiss view */
        self.dismissViewControllerAnimated(true, completion: {})
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
