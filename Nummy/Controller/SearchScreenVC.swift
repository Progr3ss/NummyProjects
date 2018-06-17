//
//  ViewController.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/14/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class YNDropDownMenu: YNSearchModel {
    var starCount = 512
    var description = "Awesome Dropdown menu for iOS with Swift 3"
    var version = "2.3.0"
    var url = "https://github.com/younatics/YNDropDownMenu"
}

class YNSearchData: YNSearchModel {
    var title = "YNSearch"
    var starCount = 271
    var description = "Awesome fully customize search view like Pinterest written in Swift 3"
    var version = "0.3.1"
    var url = "https://github.com/younatics/YNSearch"
}

class YNExpandableCell: YNSearchModel {
    var title = "YNExpandableCell"
    var starCount = 191
    var description = "Awesome expandable, collapsible tableview cell for iOS written in Swift 3"
    var version = "1.1.0"
    var url = "https://github.com/younatics/YNExpandableCell"
}
//Desing Delegator(Sender : SearchedQuery)
class SearchScreenVC: YNSearchViewController, YNSearchDelegate {
    
    @IBOutlet weak var buttonback: UIButton!
    @IBOutlet weak var buttonEndEditing: UIButton!
    @IBOutlet weak var textFieldSearch: UITextField!
    
    @IBOutlet weak var imageViewSearchCenter: UIImageView!
    @IBOutlet weak var imageViewSearchLeft: UIImageView!
    
    private var idealPositionImageViewCenter:CGFloat = 0
    private var ideaPositionImageViewLeft:CGFloat = 0
    var searchedIngridents : String?
    
    var sendDelegator : PassDataDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        self.ideaPositionImageViewLeft = self.imageViewSearchLeft.layer.position.x
        
        let demoCategories = ["Chicken", "Potatoes", "Pork", "Fish", "Peanut", "Spinach"]
        
        let demoSearchHistories = [""]
        
        let ynSearch = YNSearch()
        ynSearch.setCategories(value: demoCategories)
        ynSearch.setSearchHistories(value: demoSearchHistories)
        
        self.ynSearchinit()
        
        self.textFieldSearch.delegate = self
        self.delegate = self
        self.buttonEndEditing.isHidden = true
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let database1 = YNDropDownMenu(key: "YNDropDownMenu")
        let database2 = YNSearchData(key: "YNSearchData")
        let database3 = YNExpandableCell(key: "YNExpandableCell")
        let database4 = YNExpandableCell(key: "YNExpandableCell")
        let database5 = YNExpandableCell(key: "YNExpandableCell")
        let database6 = YNExpandableCell(key: "YNExpandableCell")
        let database7 = YNExpandableCell(key: "YNExpandableCell")
        let database8 = YNExpandableCell(key: "YNExpandableCell")
        let demoDatabase = [database1, database2, database3,database4, database5, database6,database7, database8]
        
        self.initData(database: demoDatabase)
        self.setYNCategoryButtonType(type: .colorful)
        
    }
    
    

    override func textFieldDidBeginEditing(_ textField: UITextField) {
        super.textFieldDidBeginEditing(textField)
        
//       SearchScreenVC.sendDelegator.pa
        
        
        if textField == self.textFieldSearch{
            
            self.buttonback.isHidden = true
            self.buttonEndEditing.isHidden = false
            
            if self.idealPositionImageViewCenter == 0{
                self.idealPositionImageViewCenter = self.imageViewSearchCenter.layer.position.x
            }
            
            UIView.animate(withDuration: 0.2) {
                self.imageViewSearchCenter.layer.position.x = self.ideaPositionImageViewLeft
            }
            
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         print("you search for \(textField.text)")
         self.searchedIngridents = textField.text
        performSegue(withIdentifier: "showRecipes", sender: self)
    }
    
    
    func ynSearchListViewDidScroll() {
        
    }
    
    @IBAction func actionEndEdit(_ sender: UIButton) {
        
        self.ynSearchTextfieldcancelButtonClicked()
        self.buttonback.isHidden = false
        self.buttonEndEditing.isHidden = true
        
        UIView.animate(withDuration: 0.2) {
            self.imageViewSearchCenter.layer.position.x = self.idealPositionImageViewCenter
        }
    }
    
    func ynSearchHistoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        print(text)
    }
    
    func ynCategoryButtonClicked(text: String) {
        self.pushViewController(text: text)
        print(text)
    }
    
    func ynSearchListViewClicked(key: String) {
        self.pushViewController(text: key)
        print(key)
    }
    
    func ynSearchListViewClicked(object: Any) {
        print(object)
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.ynSearchView.ynSearchListView.dequeueReusableCell(withIdentifier: YNSearchListViewCell.ID) as! YNSearchListViewCell
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel {
            cell.searchLabel.text = ynmodel.key
        }
        
        return cell
    }
    
    func ynSearchListView(_ ynSearchListView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ynmodel = self.ynSearchView.ynSearchListView.searchResultDatabase[indexPath.row] as? YNSearchModel, let key = ynmodel.key {
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(key: key)
            self.ynSearchView.ynSearchListView.ynSearchListViewDelegate?.ynSearchListViewClicked(object: self.ynSearchView.ynSearchListView.database[indexPath.row])
            self.ynSearchView.ynSearchListView.ynSearch.appendSearchHistories(value: key)
        }
    }
    
    func pushViewController(text:String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        vc.clickedText = text
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}

extension SearchScreenVC {
//    func dataReceived(query: String) {
//        self.searchedIngridents = query
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipes" {
            var recipeVC = segue.destination as! SearchedRecipesVC
            recipeVC.searchedQuery = self.searchedIngridents!
            
            
//            recipeVC.delegate = self
//                recipeVC
            
        }
    }
    
    
    
}
