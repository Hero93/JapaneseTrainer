//
//  MostWrongWordsViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 21/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class MostWrongWordsViewController: UIViewController {
    
    @IBOutlet weak var mostWrongWordsTableView: UITableView!
    
    let dataSource: SavedWordsDataSource
    
    // MARK: - Constructor
    
    required init?(coder aDecoder: NSCoder) {
        self.dataSource = SavedWordsDataSource(words: WordsDatabase.getMostWrongSavedWords(), allowDelete: false)
        super.init(coder: aDecoder)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Most Wrong Words"
        self.navigationController?.navigationBarHidden = false
        mostWrongWordsTableView.dataSource = dataSource
    }
}
