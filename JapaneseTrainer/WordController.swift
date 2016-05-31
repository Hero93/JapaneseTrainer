//
//  WordsDatabase.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 01/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

class WordController {
    
    static let wordDBPath = FileSystemUtility.getCompletePathOfFileNameInApplicationSupport("/wordsDB")
    
    // MARK: - Get
    
    static func getWords() -> [Word]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(wordDBPath) as? [Word]
    }
    
    static func getWord(italian: String, japanese : String) -> Word? {
        
        guard let word = getWords()?.filter({$0.italian == italian && $0.japanese == japanese}).first else {
            return nil
        }
        
        return word
    }
    
    static func getMostWrongWords() -> [Word]? {
        return getWords()?.filter({$0.wrongAnswersAmount >= 3 && ($0.wrongAnswersAmount > $0.correctAnswersAmount)})
    }
    
    // MARK: - Add
    
    static func addWord(word: Word) {
        
        if var words = NSKeyedUnarchiver.unarchiveObjectWithFile(wordDBPath) as? [Word] {
            words.append(word)
            NSKeyedArchiver.archiveRootObject(words, toFile: wordDBPath)
        } else {
            var wordArray = [Word]()
            wordArray.append(word)
            NSKeyedArchiver.archiveRootObject(wordArray, toFile: wordDBPath)
        }
    }
    
    static func addWords(words: [Word]) {
     
        deleteDB()
        NSKeyedArchiver.archiveRootObject(words, toFile: wordDBPath)
    }
    
    // MARK: - Remove
    
    private static func deleteDB() -> Bool {
        
        let exists = NSFileManager.defaultManager().fileExistsAtPath(wordDBPath)
        if exists {
            do {
                try NSFileManager.defaultManager().removeItemAtPath(wordDBPath)
            }catch let error as NSError {
                print("error: \(error.localizedDescription)")
                return false
            }
        }
        return exists
    }
    
    static func removeWord(word: Word) {
        if var words = NSKeyedUnarchiver.unarchiveObjectWithFile(wordDBPath) as? [Word] {
            
            for (index, element) in words.enumerate().reverse() {
                if element.italian == word.italian && element.japanese == word.japanese {
                    words.removeAtIndex(index)
                }
            }
            
            NSKeyedArchiver.archiveRootObject(words, toFile: wordDBPath)
        }
    }
}
