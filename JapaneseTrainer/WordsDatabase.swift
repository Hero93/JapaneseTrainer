//
//  WordsDatabase.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 01/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

class WordsDatabase {
    
    static let wordDBPath = FileSystemUtility.getCompletePathOfFileNameInApplicationSupport("/wordsDB")
    
    static func getSavedWords() -> [Word]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(wordDBPath) as? [Word]
    }
    
    static func saveWord(word: Word) {
        
        if var words = NSKeyedUnarchiver.unarchiveObjectWithFile(wordDBPath) as? [Word] {
            words.append(word)
            NSKeyedArchiver.archiveRootObject(words, toFile: wordDBPath)
        } else {
            var wordArray = [Word]()
            wordArray.append(word)
            NSKeyedArchiver.archiveRootObject(wordArray, toFile: wordDBPath)
        }
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
