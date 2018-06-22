//
//  CategoryRowTableViewCell.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/17/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class CategoryRowTableViewCell: UITableViewCell {
  let diets = ["Vegetarian", "Vegan"]
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension CategoryRowTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! UICollectionViewCell
        
        
        
        
        return cell
    }
    
    
    
    
}

extension CategoryRowTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 1.5
        let hardCodedPadding: CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding )
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
