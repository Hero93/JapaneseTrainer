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
    
    required init?(coder aDecoder: NSCoder) {
        self.dataSource = SavedWordsDataSource(words: WordsDatabase.getSavedWords())
        super.init(coder: aDecoder)
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsTableView.dataSource = dataSource
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
        
        dataSource.checkNewData()
        wordsTableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
