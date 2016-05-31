//
//  SavedWordViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 01/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class SavedWordViewController: UIViewController {

    @IBOutlet weak var wordsTableView: UITableView!
    
    let dataSource: SavedWordsDataSource
    
    // MARK: - Constructor
    
    required init?(coder aDecoder: NSCoder) {
        self.dataSource = SavedWordsDataSource(words: WordController.getWords(), allowDelete: true)
        super.init(coder: aDecoder)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My Dictionary"
        wordsTableView.dataSource = dataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        dataSource.words = WordController.getWords()
        wordsTableView.reloadData()
    }
}
