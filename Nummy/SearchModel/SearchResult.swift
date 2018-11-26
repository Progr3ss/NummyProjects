//
//  SearchResult.swift
//  Nummy
//
//  Created by Martin Chibwe on 5/21/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import Foundation

struct SearchResult {
    
    var query:String?
    var from:Int?
    var to:Int?
    var params:Params?
    var more:String?
    var count:Int?
    var hits = [Hits]()
    
    init(_ object:[String:Any]) {
        
        self.query = object["q"] as? String
        self.from = object["from"] as? Int
        self.to = object["to"] as? Int
        
        if let param = object["params"] as? [String:Any]{
            
            self.params = Params(param)
        }
        
        self.more = object["more"] as? String
        self.count = object["count"] as? Int
        
        if let hits = object["hits"] as? [[String:Any]]{
            
            for hit in hits{
                
                self.hits.append(Hits.init(hit))
            }
        }
        
    }
    
    
}

struct Params{
    
    var sane:[String]
    var q:[String]
    var app_key:[String]
    var health:[String]
    var from:[String]
    var to:[String]
    var calories:[String]
    var app_id:[String]
    
    init(_ object:[String:Any]){
        
        let defaultValue =  [String]()
        self.sane = object["sane"] as? [String] ?? defaultValue
        self.q = object["q"] as? [String] ?? defaultValue
        self.app_key = object["app_key"] as? [String] ?? defaultValue
        self.health = object["health"] as? [String] ?? defaultValue
        self.from = object["from"] as? [String] ?? defaultValue
        self.to = object["to"] as? [String] ?? defaultValue
        self.calories = object["calories"] as? [String] ?? defaultValue
        self.app_id = object["app_id"] as? [String] ?? defaultValue
        
    }
}

struct  Hits{
    
    var recipe:Recipe?
    var bookmarked:Bool?
    var bought:Bool?
    
    init(_ object:[String:Any]) {
        
        self.bookmarked = object["bookmarked"] as? Bool
        self.bought = object["bought"] as? Bool
        if let recipeObject = object["recipe"] as? [String:Any]{
            
            self.recipe = Recipe(recipeObject)
        }
    }
}



struct Recipe{
    
    var uri:String?
    var label:String?
    var image:String?
    var source:String?
    var url:String?
    var shareAs:String?
    var yield:Int?
    var dietLabels:[String]?
    var cautions:[String]?
    var ingredientLines:[String]?
    var ingredients = [Ingredients]()
    var calories:Float?
    var totalWeight:Float?
    var totalTime:Int?
    var totalNutrients = [Nutrient]()
    var totalDaily = [Nutrient]()
    var digest = [Digest]()
    
    init(_ object:[String:Any]) {
        
        self.uri = object["uri"] as? String
        self.label = object["label"] as? String
        self.image = object["image"] as? String
        self.source = object["source"] as? String
        self.url = object["url"] as? String
        self.shareAs = object["shareAs"] as? String
        self.yield = object["yield"] as? Int
        self.dietLabels = object["dietLabels"] as? [String]
        
        if let totalNutrientObject = object["totalNutrients"] as? [String:[String:Any]]{
            
            for (key,value) in totalNutrientObject{
                
                self.totalNutrients.append(Nutrient.init(value, type: key))
            }
        }
        
        
        //        if let recipeObject = object["recipe"] as? [String: Any]
        if let totalDailyObject = object["totalDaily"] as? [String:[String:Any]]{
            
            for (key,value) in totalDailyObject{
                
                self.totalDaily.append(Nutrient.init(value, type: key))
            }
        }
        
        if let digestObject = object["digest"] as? [[String:Any]]{
            
            for value in digestObject{
                
                self.digest.append(Digest.init(value))
            }
        }
        
        if let ingredientsObject = object["ingredients"] as? [[String:Any]]{
            
            for value in ingredientsObject{
                
                self.ingredients.append(Ingredients.init(value))
            }
        }
    }
}


struct Ingredients{
    
    let text:String
    let quantity:Int
    let measure:String
    let food:String
    let weight:Float
    
    init(_ object:[String:Any]) {
        
        self.text = object["text"] as! String
        self.quantity = (object["quantity"] as! NSNumber).intValue
        self.measure = object["measure"] as? String ?? ""
        self.food = object["food"] as! String
        self.weight = (object["weight"] as! NSNumber).floatValue
        
    }
    
}
struct Nutrient{
    
    let lable:String
    let quantity:Double
    let unit:String
    let nutritionType:String
    
    init(_ object:[String:Any], type:String) {
        
        self.lable = object["label"] as! String
        self.quantity = object["quantity"] as! Double
        self.unit = object["unit"] as! String
        self.nutritionType = type
    }
}


struct Digest{
    
    let label:String
    let tag:String
    var schemaOrgTag:String?
    let total:Double
    let hasRDI:Bool
    let daily:Double
    let unit:String
    var subDigest = [Digest]()
    
    init(_ object:[String:Any]) {
        
        self.label = object["label"] as! String
        self.tag = object["tag"] as! String
        self.schemaOrgTag = object["schemaOrgTag"] as? String
        self.unit = object["unit"] as! String
        self.total = object["total"] as! Double
        self.hasRDI = object["hasRDI"] as! Bool
        self.daily = object["daily"] as! Double
        
        if let subDigestObject = object["sub"] as? [[String:Any]]{
            
            for value in subDigestObject{
                
                self.subDigest.append(Digest.init(value))
            }
        }
    }
}

