//
//  Word.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 30/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

enum Language : Int {
    case Italian = 0
    case Japanese = 1
}

enum Answer : Int {
    case Correct = 0
    case Wrong = 1
}

class Word : NSObject, NSCoding {
    var italian : String
    var japanese : String
    
    // Memberwise initializer
    init(italian: String, japanese: String) {
        self.italian = italian
        self.japanese = japanese
    }
    
    // MARK: NSCoding
    
    required convenience init?(coder decoder: NSCoder) {
        guard let italian = decoder.decodeObjectForKey("italian") as? String,
            let japanese = decoder.decodeObjectForKey("japanese") as? String
            else { return nil }
        
        self.init(
            italian: italian,
            japanese: japanese
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.italian, forKey: "italian")
        coder.encodeObject(self.japanese, forKey: "japanese")
    }
}

class TrainerWord : Word {
    
    var isAnswered : Bool
    var answerState : Answer?
    var answerLanguage: Language

    init(italian: String, japanese: String, answered: Bool, answerLanguage: Language, answerState: Answer) {
        self.isAnswered = answered
        self.answerLanguage = answerLanguage
        self.answerState = answerState
        super.init(italian: italian, japanese: japanese)
    }
    
    init(word: Word, answered: Bool, answerLanguage: Language, answerState: Answer?) {
        self.isAnswered = answered
        self.answerLanguage = answerLanguage
        self.answerState = answerState
        super.init(italian: word.italian, japanese: word.japanese)
    }
    
    required convenience init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
