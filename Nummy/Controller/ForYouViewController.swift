//
//  ForYouViewController.swift
//  Nummy
//
//  Created by Martin Chibwe on 11/13/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class ForYouViewController: UIViewController {
    

    @IBOutlet weak var forYouTableView: UITableView!
    var searchResult:SearchResult?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRecipe(query: "apple")
        registerNib()
    }
    
    //MARK:-register nib
    func registerNib()  {
          self.forYouTableView.register(UINib(nibName: "ForYouTableViewCell", bundle: nil), forCellReuseIdentifier: "forYouCell")
        
    }
    //MARK:- Methods Parameters fo Edamam api
    func methodParapeters(ingridents: Int, diet:String, health: String, calories:Int, from : Int,to :Int) -> [String:AnyObject]{
        
        let param = [Constants.EdamamParameterKeys.Ingridents: "\(ingridents)", Constants.EdamamParameterKeys.Diet :diet, Constants.EdamamParameterKeys.Health: health, Constants.EdamamParameterKeys.Calories : "\(calories)", Constants.EdamamParameterKeys.From: "\(from)", Constants.EdamamParameterKeys.To: "\(to)"]
        
        
        
        return param as [String : AnyObject]
        
    }
    
    
    //MARK:- Create a link using Commponents
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
    //MARK:- getRecipe with query search
    func getRecipe(query: String)  {
        let param =  methodParapeters(ingridents: 5, diet: "balanced", health: "soy-free", calories: 500, from: 0, to:200)
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
                        self.forYouTableView.reloadData()
                    }
                }
                
            }catch{
                
                print("Could not parse the data as JSON: \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
    

}


extension ForYouViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.searchResult?.hits.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.forYouTableView.dequeueReusableCell(withIdentifier: "forYouCell", for: indexPath) as! ForYouTableViewCell

        if let result = self.searchResult {
            let recipeIndex = result.hits[indexPath.row].recipe
            
            print(" recipeindex \(String(describing: recipeIndex?.label!))")
            cell.recipeNameLabel.text = recipeIndex?.label!
            
            cell.recipeImage.sd_setImage(with: URL(string: recipeIndex?.image ?? "https://www.edamam.com/web-img/c3b/c3bd77339a2b1a1364a629eb4583b133.jpg"))

        }
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
    

}


