//
//  ForYouTableViewCell.swift
//  Nummy
//
//  Created by Martin Chibwe on 12/1/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class ForYouTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
