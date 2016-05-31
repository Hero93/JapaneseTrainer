//
//  TrainerViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 28/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

protocol TrainerViewControllerDelegate {
    func didEnterAnswer(answer: String, ofLanguage: Language)
    func didDisplayNextWord(oldWord: TrainerWord)
}

class TrainerViewController: UIViewController, TrainerEngineDelegate {
    
    @IBOutlet weak var wordToTranslateLabel: UILabel!
    @IBOutlet weak var correctAnswerTitle: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    /* Japanese */
    @IBOutlet weak var japaneseTextField: JapaneseTextField!
    @IBOutlet weak var japaneseFlagImageView: UIImageView!

    /* Italian */
    @IBOutlet weak var italianTextField: ItalianTextField!
    @IBOutlet weak var italianFlagImageView: UIImageView!
    
    var trainerEngine : TrainerEngine!
    var delegate : TrainerViewControllerDelegate?
    
    var currectWord : TrainerWord!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TRAINER"
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        trainerEngine = TrainerEngine(viewController: self)
        trainerEngine.delegate = self
        
        japaneseTextField.delegate = self
        italianTextField.delegate = self
        
        actionButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        trainerEngine.start()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeTap(sender: AnyObject) {
        
        Utility.showYesNoAlertView(message: "Are you sure you want to exit?", textYes: "yes", textNo: "no", view: self, onYes: {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }, onNo: {})
    }
    
    @IBAction func checkAnswerTap(sender: UIButton) {
                
        if sender.titleLabel?.text == "Check" {
            
            if let delegate = delegate {
                
                if !italianTextField.hidden {
                    delegate.didEnterAnswer(italianTextField.text!, ofLanguage: .Italian)
                } else {
                    delegate.didEnterAnswer(japaneseTextField.text!, ofLanguage: .Japanese)
                }
            }
            
        } else if sender.titleLabel?.text == "Continue" {
            
            italianTextField.text = ""
            japaneseTextField.text = ""
            
            if let delegate = delegate {
                delegate.didDisplayNextWord(currectWord)
            }
        }
    }
    
    // MARK: - Trainer Engine delegate
    
    // MARK: Start
    
    func trainingDidStart() {
        print("CIAO")
    }
    
    // MARK: Fail
    
    func trainingDidFailed(reason: String) {
        Utility.showAlertViewInViewController(self, withMessage: reason, timeLenght: 5.0, onDismiss: {
            self.navigationController?.popToRootViewControllerAnimated(true)
        })
    }
    
    // MARK: Running
    
    func trainingCurrentWord(word: TrainerWord, withAnswerLanguage: Language) {
        
        italianTextField.text = ""
        japaneseTextField.text = ""
        
        actionButton.setTitle("Check", forState: .Normal)
        correctAnswerLabel.hidden = true
        correctAnswerTitle.hidden = true
        
        italianTextField.enabled = true
        japaneseTextField.enabled = true
        
        currectWord = word
        
        actionButton.enabled = false
        
        switch withAnswerLanguage {
        
        case .Italian:
            /* the user need to answer in italian ... */
            italianTextField.hidden = false
            italianTextField.becomeFirstResponder()
            italianFlagImageView.hidden = false
            japaneseTextField.hidden = true
            japaneseFlagImageView.hidden = true
            /* ... I show the japanese word. ... */
            wordToTranslateLabel.text = word.japanese
        
        case .Japanese:
            /* the user need to answer in japanese ... */
            japaneseTextField.hidden = false
            japaneseTextField.becomeFirstResponder()
            japaneseFlagImageView.hidden = false
            italianTextField.hidden = true
            italianFlagImageView.hidden = true
            /* ... I show the italian word. ... */
            wordToTranslateLabel.text = word.italian
        }
    }
    
    func trainingCurrentCorrectWords(correctAnswers: Int, outOf: Int) {
        
        correctAnswerLabel.hidden = true
        correctAnswerTitle.hidden = true
        
        actionButton.setTitle("Check", forState: .Normal)
    }
    
    func trainingCurrentAnswerWrongWithCorrectAnswer(correctAnswer: TrainerWord, ofLanguage: Language) {
        
        correctAnswerLabel.hidden = false
        correctAnswerTitle.hidden = false
        
        actionButton.setTitle("Continue", forState: .Normal)
        
        switch ofLanguage {
            
        case .Italian:
            correctAnswerLabel.text = correctAnswer.italian
            italianTextField.enabled = false
            
        case .Japanese:
            correctAnswerLabel.text = correctAnswer.japanese
            japaneseTextField.enabled = false
        }
    }
    
    // MARK: End
    
    func trainingDidFinish() {
        italianTextField.text = ""
        japaneseTextField.text = ""
        self.performSegueWithIdentifier("finish", sender: self)
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "finish" {
            let finishVC = segue.destinationViewController as? FinishViewController
        }
     }
}
