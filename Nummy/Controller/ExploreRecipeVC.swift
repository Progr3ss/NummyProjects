//
//  ExploreRecipeVC.swift
//  Nummy
//
//  Created by Martin Chibwe on 6/17/18.
//  Copyright © 2018 Martin Chibwe. All rights reserved.
//

import UIKit

class ExploreRecipeVC: UIViewController {
    
    @IBOutlet weak var dequeTableView: UITableView!
   
    
 
    var categoreies = ["Diets", "Dishes", "Cuisines","Breakfast","lunch","Dinner"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dequeTableView.dataSource = self
        self.dequeTableView.delegate = self
        // Do any additional setup after loading the view.
    }

  

}
extension  ExploreRecipeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoreies[section]
    }
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return categoreies[section]
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoreies.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.dequeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryRowTableViewCell
        return cell
    }
    
    
}
extension ExploreRecipeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}
