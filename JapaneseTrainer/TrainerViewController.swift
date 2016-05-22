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
        trainerEngine.start()
    }
    
    // MARK: - IBActions
    
    @IBAction func closeTap(sender: AnyObject) {
        
        Utility.showYesNoAlertView(message: "Are you sure you want to exit?", textYes: "yes", textNo: "no", view: self, onYes: {
            self.navigationController?.popToRootViewControllerAnimated(true)
        }, onNo: {})
    }
    
    @IBAction func checkAnswerTap(sender: UIButton) {
        
        /* check empty answer */
//        if ((italianTextField.text?.isEmpty) != nil) {
//            Utility.showAlertViewWithMassage("Devi inserire la traduzione!", inView: self)
//            return
//        } else {
//            Utility.showAlertViewWithMassage("Devi inserire la traduzione!", inView: self)
//            return
//        }
                
        if sender.titleLabel?.text == "Send Answer" {
            
            if let delegate = delegate {
                
                if !italianTextField.hidden {
                    delegate.didEnterAnswer(italianTextField.text!, ofLanguage: .Italian)
                } else {
                    delegate.didEnterAnswer(japaneseTextField.text!, ofLanguage: .Japanese)
                }
            }
            
        } else if sender.titleLabel?.text == "Next Word" {
            
            if let delegate = delegate {
                delegate.didDisplayNextWord(currectWord)
            }
        }
        
        italianTextField.text = ""
        japaneseTextField.text = ""
    }
    
    // MARK: - Trainer Engine delegate
    
    // MARK: Start
    
    func trainingDidStart() {
        print("CIAO")
    }
    
    // MARK: Fail
    
    func trainingDidFailed(reason: String) {
        Utility.showAlertViewInViewController(self, withMessage: reason, timeLenght: 2.0)
    }
    
    // MARK: Running
    
    func trainingCurrentWord(word: TrainerWord, withAnswerLanguage: Language) {
        
        actionButton.setTitle("Send Answer", forState: .Normal)
        correctAnswerLabel.hidden = true
        correctAnswerTitle.hidden = true
        
        italianTextField.enabled = true
        japaneseTextField.enabled = true
        
        currectWord = word
        
        switch withAnswerLanguage {
        
        case .Italian:
            /* the user need to answer in italian ... */
            italianTextField.hidden = false
            italianFlagImageView.hidden = false
            japaneseTextField.hidden = true
            japaneseFlagImageView.hidden = true
            /* ... I show the japanese word. ... */
            wordToTranslateLabel.text = word.japanese
        
        case .Japanese:
            /* the user need to answer in japanese ... */
            japaneseTextField.hidden = false
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
        
        actionButton.setTitle("Send Answer", forState: .Normal)
    }
    
    func trainingCurrentAnswerWrongWithCorrectAnswer(correctAnswer: TrainerWord, ofLanguage: Language) {
        
        correctAnswerLabel.hidden = false
        correctAnswerTitle.hidden = false
        
        actionButton.setTitle("Next Word", forState: .Normal)
        
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
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
