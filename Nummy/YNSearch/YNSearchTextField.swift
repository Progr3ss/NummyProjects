//
//  YNSearchTextField.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 11..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit


open class YNSearchTextFieldView: UIView{

    @IBOutlet var ynSearchTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
         self.layer.cornerRadius  = self.frame.size.height/3.5
    }
    
}
