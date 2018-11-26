//
//  YNSearchMainView.swift
//  YNSearch
//
//  Created by YiSeungyoun on 2017. 4. 16..
//  Copyright © 2017년 SeungyounYi. All rights reserved.
//

import UIKit

open class YNSearchMainView: UIView {
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height

    open var categoryLabel: UILabel!
    open var ynCategoryButtons = [YNCategoryButton]()
    
    open var searchHistoryLabel: UILabel!
    open var ynSearchHistoryViews = [YNSearchHistoryView]()
    open var ynSearchHistoryButtons = [YNSearchHistoryButton]()
    open var clearHistoryButton: UIButton!
    open var finalFrame:CGRect?
    private var categoryViews = [UIView]()
    
    var margin: CGFloat = 15
    open var delegate: YNSearchMainViewDelegate?
    
    open var ynSearch = YNSearch()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        guard let categories = YNSearch.shared.getCategories() else { return }
        self.initView(categories: categories)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    open func setYNCategoryButtonType(type: YNCategoryButtonType) {
        for ynCategoryButton in self.ynCategoryButtons {
            ynCategoryButton.type = type
        }
    }
    
    @objc open func ynCategoryButtonClicked(_ sender: UIButton) {
        guard let text = ynCategoryButtons[sender.tag].titleLabel?.text else { return }
        ynSearch.appendSearchHistories(value: text)
        self.delegate?.ynCategoryButtonClicked(text: text)
        self.refereshView()

    }
    
    
    @objc open func ynCategoryButtonRemoveClicked(_ sender: UIButton) {
        
        
        let view = sender.superview
        
        let tag = self.categoryViews.index(of: view!)!
        
//        var cat = YNSearch.shared.getCategories()
//        cat!.remove(at: sender.tag)
//        YNSearch.shared.setCategories(value: cat!)
        
        var lastFrame:CGRect!
        var lastView:UIView!
        
        let minimumXValue:CGFloat = self.categoryViews.first!.frame.minX
        
        if  tag != self.categoryViews.count-1{

            for index in tag...self.categoryViews.count-1{
                
                let currentView = self.categoryViews[index]
                
                var nextView:UIView?
                
                if self.categoryViews.count-1 >= index+1{
                    
                    nextView = self.categoryViews[index+1]
                }
                
                UIView.animate(withDuration: 0.2, animations: {
                    if index == tag{
                        
                        let origionalWidth = nextView!.frame.width
                        lastFrame = nextView!.frame
                        
                        nextView?.layer.position = currentView.layer.position
                        nextView!.bounds = currentView.bounds
                        currentView.removeFromSuperview()
                        nextView!.frame.size.width = origionalWidth
                       
                        lastView = nextView!

                        
                    }else{
                        
                        if let currentView = nextView{

                            lastFrame = currentView.frame
                            
                            if lastView.frame.midY == currentView.frame.midY{
                                
                                currentView.layer.position.x = lastView.frame.maxX+(currentView.frame.width/2)+4

                            }else if (lastView.frame.maxX+currentView.frame.width+14 < self.frame.width) && lastView.frame.midY != currentView.frame.midY{

                                currentView.layer.position.y = lastView.layer.position.y
                                currentView.layer.position.x = lastView.frame.maxX+(currentView.layer.frame.width/2)+3

                            }else if lastView.frame.midY != currentView.frame.midY{
                                
                                currentView.layer.position.x = minimumXValue+(currentView.frame.width/2)

                            }else{
                                
                                currentView.layer.position.x = lastFrame.minX+(currentView.layer.frame.width/2)
                            }

                            lastView = currentView
                        }
                        
                    }
                    
                }) { (bool) in
                    
                    
                }
                
                if index == self.categoryViews.count-1{
                    print("Okay")
                    self.categoryViews.remove(at: tag)
                    self.refereshView()
                }
                
            }
            
        }else{
            self.categoryViews.removeLast()
            sender.superview?.removeFromSuperview()
            self.refereshView()
        }
        

    }
    
    @objc open func ynSearchHistoryButtonClicked(_ sender: UIButton) {
        guard let text = ynSearchHistoryButtons[sender.tag].textLabel.text else { return }
        self.delegate?.ynSearchHistoryButtonClicked(text: text)
    }
    
    @objc open func clearHistoryButtonClicked() {
        ynSearch.setSearchHistories(value: [String]())
        self.redrawSearchHistoryButtons()
    }
    
    @objc open func closeButtonClicked(_ sender: UIButton) {
        ynSearch.deleteSearchHistories(index: sender.tag)
        self.redrawSearchHistoryButtons()
    }
    
    private func refereshView(){
    
        var frame:CGRect = self.categoryLabel.frame
        
        if let lastView = self.categoryViews.last{
            
            frame = lastView.frame
        }
        
        let difference = (self.searchHistoryLabel.frame.maxY-frame.maxY)-68.6796875
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.searchHistoryLabel.layer.position.y = difference > 0 ? self.searchHistoryLabel.layer.position.y-difference :  self.searchHistoryLabel.layer.position.y+difference
            
            if self.clearHistoryButton != nil{
                self.clearHistoryButton.layer.position.y = difference > 0 ? self.clearHistoryButton.layer.position.y-difference :  self.clearHistoryButton.layer.position.y+difference
            }
            
            for view in self.ynSearchHistoryViews{
                
                view.layer.position.y = difference > 0 ? view.layer.position.y-difference :  view.layer.position.y+difference
            }
            
        }) { (bool) in
            self.redrawSearchHistoryButtons()
        }
    }
    
    open func initView(categories: [String]) {
        self.categoryLabel = UILabel(frame: CGRect(x: margin, y: 0, width: width - 40, height: 50))
        self.categoryLabel.text = "Categories"
        self.categoryLabel.font = UIFont.systemFont(ofSize: 13)
        self.categoryLabel.textColor = UIColor.darkGray
        self.addSubview(self.categoryLabel)
        
        let font = UIFont.systemFont(ofSize: 12)
        let userAttributes = [NSAttributedStringKey.font : font, NSAttributedStringKey.foregroundColor: UIColor.gray]
        
        var formerWidth: CGFloat = margin
        var formerHeight: CGFloat = 50
        
        for i in 0..<categories.count {
            
            let size = categories[i].size(withAttributes: userAttributes)
            
            if i > 0 {
                formerWidth = ynCategoryButtons[i-1].sizeFrame.size.width + ynCategoryButtons[i-1].sizeFrame.origin.x + 5
                if formerWidth + size.width + margin > UIScreen.main.bounds.width {
                    formerHeight += ynCategoryButtons[i-1].sizeFrame.size.height + 17
                    formerWidth = margin
                }
                
            }
            
            let view = UIView(frame:  CGRect(x: formerWidth, y: formerHeight, width: size.width+30, height: size.height + 17))
           
            self.categoryViews.append(view)
            
            let button = YNCategoryButton(frame: CGRect(x: 8, y: 0, width: size.width, height: size.height + 17))
            button.sizeFrame = CGRect(x: formerWidth, y: formerHeight, width: size.width+28, height: size.height + 10)
            button.addTarget(self, action: #selector(ynCategoryButtonClicked(_:)), for: .touchUpInside)
            button.setTitle(categories[i], for: .normal)
            button.tag = i
            
            let deleteButton = UIButton()
            deleteButton.setImage(#imageLiteral(resourceName: "deleteButton"), for: .normal)
            deleteButton.tag = i
            deleteButton.addTarget(self, action: #selector(ynCategoryButtonRemoveClicked(_:)), for: .touchUpInside)
            view.addSubview(deleteButton)
            
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            deleteButton.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            deleteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            
            
            ynCategoryButtons.append(button)
            view.addSubview(button)
            self.addSubview(view)
            
        }
        guard let originY = ynCategoryButtons.last?.sizeFrame.origin.y else { return }
        self.searchHistoryLabel = UILabel(frame: CGRect(x: margin, y: originY + 60, width: width - 40, height: 40))
        self.searchHistoryLabel.text = "Recent"
        self.searchHistoryLabel.font = UIFont.boldSystemFont(ofSize: 28)
        self.searchHistoryLabel.textColor = UIColor.black
        self.addSubview(self.searchHistoryLabel)
        self.redrawSearchHistoryButtons()
        
    }
    
    open func redrawSearchHistoryButtons() {
        for ynSearchHistoryView in ynSearchHistoryViews {
            ynSearchHistoryView.removeFromSuperview()
        }
        ynSearchHistoryViews.removeAll()
        ynSearchHistoryButtons.removeAll()

        if self.clearHistoryButton != nil {
            self.clearHistoryButton.removeFromSuperview()
        }
        
        let histories = ynSearch.getSearchHistories() ?? [String]()
        
        let searchHistoryLabelOriginY: CGFloat = searchHistoryLabel.frame.origin.y + searchHistoryLabel.frame.height

        for i in 0..<histories.count {
            
            let view = YNSearchHistoryView(frame: CGRect(x: margin, y: searchHistoryLabelOriginY + CGFloat(i * 80) , width: width - (margin * 2), height: 80))
            view.ynSearchHistoryButton.addTarget(self, action: #selector(ynSearchHistoryButtonClicked(_:)), for: .touchUpInside)
            view.closeButton.addTarget(self, action: #selector(closeButtonClicked(_:)), for: .touchUpInside)

            view.ynSearchHistoryButton.textLabel.text = histories[i]
            view.ynSearchHistoryButton.textLabel.textColor = .red
            view.ynSearchHistoryButton.tag = i
            
            view.closeButton.tag = i
            view.closeButton.isHidden = true
            
            ynSearchHistoryViews.append(view)
            ynSearchHistoryButtons.append(view.ynSearchHistoryButton)
            self.addSubview(view)
            
        
        }
        
        let lastHistoryView = self.ynSearchHistoryViews.last ?? YNSearchHistoryView()
        
        guard let originY = ynCategoryButtons.last?.sizeFrame.origin.y else { return }
        
        self.finalFrame = CGRect(x: margin, y: lastHistoryView.frame.origin.y + lastHistoryView.frame.height, width: width - (margin * 2), height: 40)
        
        if self.clearHistoryButton == nil{
            self.clearHistoryButton = UIButton(frame: CGRect(x: self.width-170, y: originY + 60, width: width - 40, height: 40))
            self.clearHistoryButton.setTitle("clear", for: .normal)
            self.clearHistoryButton.setTitleColor(UIColor.red, for: .normal)
            self.clearHistoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            self.clearHistoryButton.addTarget(self, action: #selector(clearHistoryButtonClicked), for: .touchUpInside)
            self.addSubview(clearHistoryButton)
        }else{
            
            self.clearHistoryButton = UIButton(frame: self.clearHistoryButton.frame)
            self.clearHistoryButton.setTitle("clear", for: .normal)
            self.clearHistoryButton.setTitleColor(UIColor.red, for: .normal)
            self.clearHistoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            self.clearHistoryButton.addTarget(self, action: #selector(clearHistoryButtonClicked), for: .touchUpInside)
            self.addSubview(clearHistoryButton)
        }
        
        self.delegate?.ynSearchMainViewSearchHistoryChanged()
        self.refereshView()
        
    }
}
