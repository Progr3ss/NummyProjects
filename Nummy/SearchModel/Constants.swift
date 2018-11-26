//
//  Constants.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/14/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//


import Foundation
import UIKit
struct Constants {
    
    struct APIKeys {
        static let app_Key = "4d45a9963d006ce6d48275df6482643b"
        static let app_Id = "b088da30"
    }
    
    struct Edamam {
        static let APIScheme = "https"
        static let APIHost = "api.edamam.com"
        static let APIPath = "/search"
        
    }
    
    struct EdamamParameterKeys {
        static let Query = "q"
        static let AppID = "app_id"
        static let App_key = "app_key"
        static let Ingridents = "ingr"
        static let Diet = "diet"
        static let Health = "health"
        static let Calories = "calories"
        static let From = "from"
        static let To = "to"
        static let Exclused = "excluded"
        static let Time = "time"
        
    }
    

    
    
}
