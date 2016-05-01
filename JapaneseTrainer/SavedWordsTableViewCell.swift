//
//  SavedWordsTableViewCell.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 01/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class SavedWordsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var italianLabel: UILabel!
    @IBOutlet weak var japaneseLabel: UILabel!

    var italian: String? {
        didSet {
            italianLabel.text = italian
        }
    }
    
    var japanese: String? {
        didSet {
            japaneseLabel.text = japanese
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
