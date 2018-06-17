//
//  SearchedRecipesVC.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/16/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class SearchedRecipesVC: UIViewController {

    @IBOutlet weak var dequeTableView: UITableView!
    var searchResult:SearchResult?
    var delegate: CanReceive?
    var searchedQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("searched \(searchedQuery) count \(self.searchResult?.hits.count)")
        // Do any additional setup after loading the view.
//        getRecipe(query: searchedQuery)
//        print("searched \(searchedQuery) count \(self.searchResult?.hits.count)")
//        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        getRecipe(query: searchedQuery)
//        self.tableView.reloadData()
    }

    func methodParapeters(ingridents: Int, diet:String, health: String, calories:Int, from : Int,to :Int) -> [String:AnyObject]{
        
        let param = [Constants.EdamamParameterKeys.Ingridents: "\(ingridents)", Constants.EdamamParameterKeys.Diet :diet, Constants.EdamamParameterKeys.Health: health, Constants.EdamamParameterKeys.Calories : "\(calories)", Constants.EdamamParameterKeys.From: "\(from)", Constants.EdamamParameterKeys.To: "\(to)"]
        
        
        
        return param as [String : AnyObject]
        
    }
    
    func edamanURLFromParameters(query: String, parameters:[String:AnyObject]? = nil) -> URL {
        let components = NSURLComponents()
        components.scheme = Constants.Edamam.APIScheme
        components.host = Constants.Edamam.APIHost
        components.path = Constants.Edamam.APIPath
        components.queryItems = [NSURLQueryItem]() as [URLQueryItem]
        
        let queryItem0 = NSURLQueryItem(name: Constants.EdamamParameterKeys.Query, value: "\(query)")
        let queryItem1 = NSURLQueryItem(name:Constants.EdamamParameterKeys.AppID, value: Constants.APIKeys.app_Id)
        let queryItem2 = NSURLQueryItem(name: Constants.EdamamParameterKeys.App_key, value:Constants.APIKeys.app_Key)
        
        components.queryItems?.append(queryItem0 as URLQueryItem)
        components.queryItems?.append(queryItem1 as URLQueryItem)
        components.queryItems?.append(queryItem2 as URLQueryItem)
        
        for(key, value) in (parameters)! {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            
            components.queryItems!.append( queryItem)
        }
        
        
        
        
        print("components \(components.url!)")
        return components.url!
        
        
    }
    
    @IBAction func loadData(_ sender: Any) {
        getRecipe(query: searchedQuery)
    }
    func getRecipe(query: String)  {
        let param =  methodParapeters(ingridents: 5, diet: "balanced", health: "soy-free", calories: 500, from: 0, to: 20)
        let url3 = edamanURLFromParameters(query: query, parameters: param)
        
        
        let task = URLSession.shared.dataTask(with: url3) { (data, response, error) in
            guard error == nil else{
                print("There was an error with your request: ",error!.localizedDescription)
                return
            }
            
            guard data != nil else{
                print("No data was returned by the request")
                return
            }
            
            do{
                
                if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String:Any]{
                    
                    self.searchResult = SearchResult(jsonObject)
                    DispatchQueue.main.async {
                   self.dequeTableView.reloadData()
                        
//                        print("counted Items =  \(self.searchResult?.hits.count)")
//                        print("recipeName \(self.searchResult?.hits[0].recipe?.label)")
                        
//                        print("\(self.searchResult?.hits.first?.recipe)")
                        
                    }
                }
                
            }catch{
                
                print("Could not parse the data as JSON: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
    

}
extension SearchedRecipesVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeTableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        cell.recipeNameLabel.text = "Hello Martn"
        
//        if let result = self.searchResult{
//            print("resulets \(result)")
//            let recipeIndex = result.hits[indexPath.row].recipe
//            cell.detailTextLabel?.text = "\(result)"
////            cell.recipeNameLabel.text = recipeIndex?.label
//
////            if let object = result.hits.first?.recipe?.ingredients[indexPath.row]{
////                cell.textLabel?.text = "Text:"+(object.text)+" another One:"+object.food
//
//                //SAME YOU HATE TO USE Search Result object where you need...
//
//        }
//        if let result = self.searchResult {
//            if let object = result.hits.first?.recipe?.ingredients{
////                cell.recipeNameLabel.text = objects
//                cell.textLabel?.text = "Text:"+(object.text)+" another One:"+object.food
//            }
//        }
        
//        let recipeIndex = self.searchResult?.hits[indexPath.row].recipe
//        print("Got some = \(recipeIndex)")
//        cell.recipeNameLabel.text = recipeIndex?.label
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return 10
//        return (self.searchResult?.hits.count)!
//        if let result = self.searchResult {
//            return result.hits.count
//        }else {
//            return 10
//        }
        
        return 10
    
    }
}
//
//extension SearchedRecipesVC: UITableViewDelegate, UITableViewDataSource {
//    
//}
