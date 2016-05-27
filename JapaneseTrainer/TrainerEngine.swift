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
    func trainingDidFinish()
    func trainingCurrentWord(word: TrainerWord, withAnswerLanguage: Language)
    func trainingCurrentCorrectWords(correctAnswers: Int, outOf: Int)
    func trainingCurrentAnswerWrongWithCorrectAnswer(correctAnswer: TrainerWord, ofLanguage: Language)
}

class TrainerEngine : TrainerViewControllerDelegate {
    
    private var questions : [TrainerWord]?
    private var currentWordToAnswer : TrainerWord!
    
    var delegate : TrainerEngineDelegate?
    
    init(viewController: UIViewController) {
        if let viewController =  viewController as? TrainerViewController {
            viewController.delegate = self
        }
    }
    
    // MARK: - Engine
    
    func start() {
        
        /* get words from database */
        if let words = WordsDatabase.getSavedWords() {
            
            /* map "Word" objects into "TrainerWord" */
            questions = words.map({TrainerWord(word: $0, answered: false, answerLanguage: getLanguageToShow(), answerState: nil)})
            
        } else {
            if let delegate = delegate {
                delegate.trainingDidFailed("no words in the Dictionary :(")
            }
        }
        
        if let delegate = delegate {
            delegate.trainingDidStart()
            
            if let word = getWordToShow() {
                delegate.trainingCurrentWord(word, withAnswerLanguage: word.answerLanguage)
            } else {
                delegate.trainingDidFailed("no words in the Dictionary :(")
            }
        }
    }
    
    private func finish() {
        
        questions = nil
        currentWordToAnswer = nil
    }
    
    // MARK: - Utility
    
    private func getWordToShow() -> TrainerWord? {
        
        guard let questions = questions else {
            return nil
        }
        
        let randomWord = questions.randomElement()
        
        if randomWord.answerState == .Correct {
            
            /* user answered all questions correctly, no word left! */
            if questions.filter({$0.answerState == .Correct}).count == questions.count {
                return nil
            }
            
            /* I don't need a random word both answered and right, get a new one! */
            return getWordToShow()
        }
        
        if !randomWord.isAnswered || randomWord.answerState == .Wrong {
            
            /* Random word is unaswered or wrong, show it! */
            currentWordToAnswer = randomWord
            return randomWord
        }
        
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
    
    private func buildMostWrongWords() {
        
        let updatedWords = questions!.map({Word(italian: $0.italian, japanese: $0.japanese, wrongAnswersAmount: $0.wrongAnswersAmount, correctAnswersAmount: $0.correctAnswersAmount)})
        
        WordsDatabase.updateDBWithWords(updatedWords)
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
                    question.correctAnswersAmount += 1
                    break
                }
            }
            
            // 2b - inform the class registered to the delegate
            if let delegate = delegate {
                if let word = getWordToShow() {
                    delegate.trainingCurrentWord(word, withAnswerLanguage: word.answerLanguage)
                } else {
                    buildMostWrongWords()
                    finish()
                    delegate.trainingDidFinish()
                }
            }
            
        } else {
            // 3 - if wrong -> trainigCurrectAnswerWrong
            if let delegate = delegate {
                
                // 3a - set wrong answer to true
                for question in questions! {
                    if question == currentWordToAnswer {
                        question.answerState = .Wrong
                        question.wrongAnswersAmount += 1
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
                buildMostWrongWords()
                finish()
                delegate.trainingDidFinish()
            }
        }
    }
}