//
//  TrainerEngine.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 04/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

protocol TrainerEngineDelegate {
    func trainingDidStart()
    func trainingDidFailed(reason: String)
    func trainingDidFinishWithCorrectAnswers(correctAnswers: Int, andWrongAnswers: Int)
    func trainingCurrentWord(word: TrainerWord, withAnswerLanguage: Language)
    func trainingCurrentCorrectWords(correctAnswers: Int, outOf: Int)
    func trainingCurrentAnswerWrongWithCorrectAnswer(correctAnswer: TrainerWord, ofLanguage: Language)
}

class TrainerEngine : TrainerViewControllerDelegate {
    
    private var questions : [TrainerWord]?
    var currentWordToAnswer : TrainerWord!
    var delegate : TrainerEngineDelegate?
    
    init(viewController: UIViewController) {
        if let viewController =  viewController as? TrainerViewController {
            viewController.delegate = self
        }
        
        /* get words from database */
        if let words = WordsDatabase.getSavedWords() {
            
            /* map "Word" objects into "TrainerWord" */
            questions = words.map({TrainerWord(word: $0, answered: false, answerLanguage: getLanguageToShow(), answerState: nil)})
        
        } else {
            if let delegate = delegate {
                delegate.trainingDidFailed("no words in the DB")
            }
        }        
    }
    
    // MARK: - Engine
    
    func start() {
        
        if let delegate = delegate {
            delegate.trainingDidStart()
            
            if let word = getWordToShow() {
                delegate.trainingCurrentWord(word, withAnswerLanguage: word.answerLanguage)
            } else {
                delegate.trainingDidFinishWithCorrectAnswers(0, andWrongAnswers: 0)
            }
        }
        
        /* */
    }
    
    // MARK: - Utility
    
    private func getWordToShow() -> TrainerWord? {
        
        guard let questions = questions else {
            return nil
        }
        
        let randomWord = questions.randomElement()
        
        if !randomWord.isAnswered || randomWord.answerState == .Wrong {
        
            /* get unanswered or wrong words */
            currentWordToAnswer = randomWord
            return randomWord

        } else {
            
            var correctAnswers = 0
            
            for word in questions {
                if word.isAnswered && word.answerState == .Correct {
                    correctAnswers += correctAnswers
                }
            }
            
            /* the user answered all questions correctly */
            if correctAnswers == questions.count {
                return nil
            }
        }
        
        getWordToShow()
        
        return nil
    }
    
    private func getLanguageToShow() -> Language {
        let diceRoll = Int(arc4random_uniform(2))
        switch diceRoll {
        case Language.Italian.rawValue:
            return .Italian
        case Language.Japanese.rawValue:
            return .Japanese
        default:
            return .Italian
        }
    }
    
    // MARK: - TrainerViewController delegate methods
    
    func didEnterAnswer(answer: String, ofLanguage: Language) {
        
        // 1 - check answer
        
        var answerToCheck = ""
        
        switch ofLanguage {

        case .Italian:
            answerToCheck = currentWordToAnswer.italian
            
        case .Japanese:
            answerToCheck = currentWordToAnswer.japanese
        }
        
        // 2 - if correct -> new word (getNextWord())
        if answer == answerToCheck {
            
            // 2a - set isAnswer to true
            for question in questions! {
                if question == currentWordToAnswer {
                    question.isAnswered = true
                    question.answerState = .Correct
                    break
                }
            }
            
            // 2b - inform the class registered to the delegate
            if let delegate = delegate {
                if let word = getWordToShow() {
                    delegate.trainingCurrentWord(word, withAnswerLanguage: word.answerLanguage)
                } else {
                    delegate.trainingDidFinishWithCorrectAnswers(0, andWrongAnswers: 0)
                }
            }
            
        } else {
            // 3 - if wrong -> trainigCurrectAnswerWrong
            if let delegate = delegate {
                
                // 3a - set wrong answer to true
                for question in questions! {
                    if question == currentWordToAnswer {
                        question.answerState = .Wrong
                        delegate.trainingCurrentAnswerWrongWithCorrectAnswer(question, ofLanguage: question.answerLanguage)
                    }
                }
            }
        }
    }
    
    func didDisplayNextWord(oldWord: TrainerWord) {
        
        // put old word answer state to Wrong
        
        for question in questions! {
            if question == oldWord {
                question.isAnswered = true
                question.answerState = .Wrong
                break
            }
        }
        
        if let delegate = delegate {
            if let word = getWordToShow() {
                delegate.trainingCurrentWord(word, withAnswerLanguage: word.answerLanguage)
            } else {
                delegate.trainingDidFinishWithCorrectAnswers(0, andWrongAnswers: 0)
            }
        }
    }
}