//
//  FinishViewController.swift
//  JapaneseTrainer
//
//  Created by Luca Gramaglia on 26/05/16.
//  Copyright © 2016 Luca Gramaglia. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.title = "Japanese Trainer"
    }
    
    // IBActions
    @IBAction func restartButtonTap(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func homeButtonTap(sender: UIButton) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}
