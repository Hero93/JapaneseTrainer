//
//  Word.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 30/04/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

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
