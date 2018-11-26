//
//  DetailViewController.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/14/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var clickedText: String?
    
    @IBOutlet var clickedLabel: UILabel!
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clickedLabel.text = clickedText
    }
    
    
}
