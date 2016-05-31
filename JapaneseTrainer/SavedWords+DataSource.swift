//
//  SavedWordDataSource.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 01/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import Foundation

class SavedWordsDataSource : NSObject {
    
    var words : [Word]?
    internal var allowDelete : Bool
    
    init(words: [Word]?, allowDelete: Bool) {
        self.words = words
        self.allowDelete = allowDelete
    }
}

extension SavedWordsDataSource : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let words = words {
            return words.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(String(SavedWordsTableViewCell)) as! SavedWordsTableViewCell
        
        if let words = words {
            let word = words[indexPath.row]
            cell.italian = word.italian
            cell.japanese = word.japanese
        }

        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if allowDelete {
            return true
        }
        
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            if var words = words {
                let wordToDelete = words[indexPath.row]
                WordsDatabase.removeWord(wordToDelete)
            }
            
            words!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}