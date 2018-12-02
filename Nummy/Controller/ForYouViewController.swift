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
    
    
   
    
    //2
    private let items = ["item 1", "item 2", "item 3", "item 4", "item 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        forYouTableView.reloadData()
//       self.forYouTableView.register(ForYouTableViewCell.self, forCellReuseIdentifier: "forYouCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        forYouTableView.reloadData()
//        self.forYouTableView.register(ForYouTableViewCell.self, forCellReuseIdentifier: "forYouCell")
        
    }


  

}

extension ForYouViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ForYouTableViewCell", owner: self, options: nil)?.first as! ForYouTableViewCell
        
//
        cell.recipeNameLabel.text = "test1"
//        cell.sourceNameLabel.text = "test2"
//        self.forYouTableView.register(ForYouTableViewCell.self, forCellReuseIdentifier: "forYouCell")
//        self.forYouTableView.register(ForYouTableViewCell.self, forCellReuseIdentifier: "forYouCell")
//        let cell = forYouTableView.dequeueReusableCell(withIdentifier: "forYouCell") as! ForYouTableViewCell
        
//        cell.textLabel?.text = items[indexPath.row]
        
//        self.forYouTableView.register(ForYouTableViewCell.self, forCellReuseIdentifier: "forYouCell")
//        let cell = forYouTableView.dequeueReusableCell(withIdentifier: "forYouCell", for: indexPath) as! ForYouTableViewCell
        
//        cell.recipeLayout.recipeNameLabel.text = "test1"
//        let cell1 = self.forYouTableView.regis
//        cell.recipeNameLabel.text = "test1"
//        cell.textLabel?.text = "test1"
//        cell.sourceNameLabel.text = "test2"
//        cell.
//        cell.recipeNameLabel.text = "test2"
//        cell.recipeNameLabel
//        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 530
    }
    
    
    
}


